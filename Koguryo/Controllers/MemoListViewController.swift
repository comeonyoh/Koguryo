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

        self.makeSampleData()

        self.setLayout()
    }

}


extension MemoListViewController {
    
    func setLayout() {

        self.memoListTableView.estimatedRowHeight = 90
        self.memoListTableView.rowHeight = UITableViewAutomaticDimension
        self.memoListTableView.register(UINib.init(nibName: MemoListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MemoListTableViewCell.identifier)
        self.memoListTableView.register(UINib.init(nibName: CopyTextButtonTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CopyTextButtonTableViewCell.identifier)
    }
    
    func makeSampleData() {

        let memo_1 = Memo.init(memo: "Test Memo A")
        let memo_2 = Memo.init(memo: "Test Memo B", withPlaceHolder: "PlaceHolder")
        let memo_3 = Memo.init(memo: "Test Memo C")
        let memo_4 = Memo.init(memo: "Test Memo D", withPlaceHolder: "PlaceHolder")
        let memo_5 = Memo.init(memo: "Test Memo E", withPlaceHolder: "PlaceHolder")
        let memo_6 = Memo.init(memo: "Test Memo F")
        let memo_7 = Memo.init(memo: "Test Memo G", withPlaceHolder: "PlaceHolder")
        let memo_8 = Memo.init(memo: "Test Memo H")
        let memo_9 = Memo.init(memo: "Test Memo I", withPlaceHolder: "PlaceHolder")
        let memo_10 = Memo.init(memo: "Test Memo J")

        self.memoListManager.allOfMemos?.append(memo_1)
        self.memoListManager.allOfMemos?.append(memo_2)
        self.memoListManager.allOfMemos?.append(memo_3)
        self.memoListManager.allOfMemos?.append(memo_4)
        self.memoListManager.allOfMemos?.append(memo_5)
        self.memoListManager.allOfMemos?.append(memo_6)
        self.memoListManager.allOfMemos?.append(memo_7)
        self.memoListManager.allOfMemos?.append(memo_8)
        self.memoListManager.allOfMemos?.append(memo_9)
        self.memoListManager.allOfMemos?.append(memo_10)
        
        _ = self.memoListManager.addFavoriteMemo(memo_3)
        _ = self.memoListManager.addFavoriteMemo(memo_7)
        _ = self.memoListManager.addFavoriteMemo(memo_9)
        
    }
}

extension MemoListViewController: UITableViewDataSource, MemoListTableViewCellDelegate, CopyTextButtonTableViewCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int { return 3 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == MemoListSection.addButton.rawValue {
            return 1
        }
        else if section == MemoListSection.favorite.rawValue {
            return (self.memoListManager.favoriteMemos?.count)!
        }
        else if section == MemoListSection.list.rawValue {
            return (self.memoListManager.allOfMemos?.count)!
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
        
        cell.configureCell(withMemo: memoListManager.getMemo(withIndexPath: indexPath), withIndexPath: indexPath)

        cell.eventDelegate = self

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

    func memoListTableViewCell(didCopyButtonClicked copyButton: UIButton, withIndexPath indexPath: IndexPath) {
        
        self.memoListManager.copyToPasteboard(withIndex: indexPath)
        
        //  Show success alert view
        ProgressHudManager.showCopyHUD(inView: self.view)
    }

    func copyTextButtonTableViewCell(didCopyButtonClicked: UIView) {
        
        print("copyTextButtonTableViewCell")
        
        self.memoListManager.copyFromPasteboard()
        
        self.memoListTableView.reloadData()
    }

}

extension MemoListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath.section != 0 else {
            
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
        return 90.0
    }
    
    func moveToModifyViewController(_ indexPath: IndexPath) {

        let memo = self.memoListManager.getMemo(withIndexPath: indexPath)

        let vc = StoryboardManager.getMainStoryboard().instantiateViewController(withIdentifier: WriteMemoViewController.identifier) as! WriteMemoViewController
        
        vc.memoInfo = memo?.copy() as! Memo?
        vc.writeType = .modify
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
