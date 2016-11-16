//
//  MemoListViewController.swift
//  Koguryo
//
//  Created by KimJungSu on 11/7/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit

class MemoListViewController: UIViewController {

    let memoListManager = MemoManager.init()
    
    @IBOutlet weak var memoListTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.setLayout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == StoryboardManager.segueWriteMemo {
            
            let vc = segue.destination as! WriteMemoViewController
            
            vc.delegate = self
        }
    }

}


extension MemoListViewController {
    
    func setLayout() {

        self.memoListTableView.estimatedRowHeight = 90
        self.memoListTableView.rowHeight = UITableViewAutomaticDimension
        self.memoListTableView.register(UINib.init(nibName: MemoListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MemoListTableViewCell.identifier)
        self.memoListTableView.register(UINib.init(nibName: CopyTextButtonTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CopyTextButtonTableViewCell.identifier)
    }
}

extension MemoListViewController: UITableViewDataSource, MemoListTableViewCellDelegate, CopyTextButtonTableViewCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int { return 3 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == MemoListSection.addButton.rawValue {
            return 1
        }
        else if section == MemoListSection.favorite.rawValue {
            return self.memoListManager.getMemoCount(withType: .favorite)
        }
        else if section == MemoListSection.list.rawValue {
            return self.memoListManager.getMemoCount(withType: .normal)
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard indexPath.section != MemoListSection.addButton.rawValue  else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CopyTextButtonTableViewCell.identifier, for: indexPath) as! CopyTextButtonTableViewCell
            
            cell.delegate = self
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoListTableViewCell.identifier, for: indexPath) as! MemoListTableViewCell

        cell.eventDelegate = self

        if indexPath.section == MemoListSection.favorite.rawValue {
            cell.configureCell(withMemo: memoListManager.getMemoAt(indexPath), withIndexPath: indexPath)
        }
        else {
            cell.configureCell(withMemo: memoListManager.getMemoAt(indexPath), withIndexPath: indexPath)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == MemoListSection.favorite.rawValue {
            
            if memoListManager.hasFavoriteMemos() == true{
                return NSLocalizedString("section_title_favorite", comment: "title for favorite memo items")
            }
        }
        else {
            
            if memoListManager.hasMemo() == true {
                return NSLocalizedString("section_title_items", comment: "title for memo items")
            }
        }
        
        return nil
    }

    
    //MARK: MemoListTableViewCellDelegate
    
    func memoListTableViewCell(didCopyButtonClicked copyButton: UIButton, withIndexPath indexPath: IndexPath) {
        
        self.memoListManager.copyToPasteboard(withIndex: indexPath)
        
        //  Show success alert view
        ProgressHudManager.showCopyHUD(inView: self.view)
    }
    
    func memoListTableViewCell(didSwipeButtonClicked event: SwipeButtonEvent, withIndexPath indexPath: IndexPath) {
        
        if event == .remove {
            
            let memo = self.memoListManager.getMemoAt(indexPath)
            
            self.memoListManager.deleteMemo(withMemo: memo)
        }
        
        else if event == .favorite {
            
            let result = self.memoListManager.updateMemoFavorite(withIndexPath: indexPath)
            
            if result == false {
                self.showAlertView(withPrompt: NSLocalizedString("warning_favorite_max_count", comment: ""))
            }
        }

        self.memoListTableView.reloadData()

    }

    //MARK: CopyTextButtonTableViewCellDelegate
    
    func copyTextButtonTableViewCell(didCopyButtonClicked: UIView) {
        
        self.memoListManager.copyFromPasteboard()
        
        self.memoListTableView.reloadData()
    }

}

extension MemoListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath.section != MemoListSection.addButton.rawValue else {
            
            let addSectionCell = tableView.cellForRow(at: indexPath) as! CopyTextButtonTableViewCell
            
            addSectionCell.springAnimate(inView: addSectionCell.saveButton)
            
            return
        }
        
        self.moveToModifyViewController(indexPath)

    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == MemoListSection.addButton.rawValue {
            return 0
        }
            
        else if section == MemoListSection.favorite.rawValue {

            if memoListManager.hasFavoriteMemos() == true{
                return 20.0
            }
        }
            
        else {
            
            if memoListManager.hasMemo() == true{
                return 20.0
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { return 0.0 }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func moveToModifyViewController(_ indexPath: IndexPath) {

        let vc = StoryboardManager.getMainStoryboard().instantiateViewController(withIdentifier: WriteMemoViewController.identifier) as! WriteMemoViewController
        
        vc.delegate = self
        vc.writeType = .modify
        
        let memo = memoListManager.getMemoAt(indexPath)
        
        vc.memoId = memo.memoId
        vc.contents = memo.contents
        vc.placeholder = memo.placeHolder

        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MemoListViewController: WriteMemoViewControllerDelegate {
    
    func didMemoWritten(_ memoInfo: Dictionary<String, String>, withType type: WriteType, withMemoId memoId: String?) {

        if type == .newMemo {
            memoListManager.addMemo(RealmMemo.init(value: memoInfo))
        }
        
        else if type == .modify && memoId != nil {
            memoListManager.updateMemo(withMemoId: memoId!, withNewInfo: memoInfo)
        }

        self.memoListTableView.reloadData()
    }
}
