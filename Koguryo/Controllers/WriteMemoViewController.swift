//
//  WriteMemoViewController.swift
//  Koguryo
//
//  Created by KimJungSu on 11/7/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit

enum WriteType {
    case newMemo
    case modify
}

protocol WriteMemoViewControllerDelegate: class {

    func didMemoWritten(_ memoInfo: Dictionary<String, String>, withType type: WriteType, withMemoId memoId: String?)

}

class WriteMemoViewController: UIViewController {

    static let identifier = "WriteMemoViewController"

    let headerTitles = [NSLocalizedString("tag", comment: "tag"), NSLocalizedString("contents", comment: "")]

    var writeType: WriteType = .newMemo
    
    weak var delegate: WriteMemoViewControllerDelegate?

    
    /**
     * properties for modify memo item
     */
    
    var placeholder: String?
    
    var contents: String?

    var memoId: String?
    
    
    @IBOutlet weak var rightNavigationItem: UIBarButtonItem!
    
    @IBOutlet weak var inputTableView: UITableView!
    
    enum WriteMemoSection: Int {
        case placeholder
        case contents
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.registNotifications()
        
        self.setRightNavigationBarItemEnabled()
    }
    
    @IBAction func didRightBarButtonClicked(_ sender: Any) {
    
        //  post delegate alarm with memo info
        self.delegate?.didMemoWritten(self.getInputtedMemoInfo(), withType: self.writeType, withMemoId: self.memoId)

        //  navigation pop
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}


/**
 * Extension about modify memo
 */

extension WriteMemoViewController {
    
    func setRightNavigationBarItemEnabled() {
        
        if self.writeType == .modify {
            self.rightNavigationItem.isEnabled = true
        }
    }
    
}


/**
 * Extension about keyboard notification
 */

extension WriteMemoViewController {
    
    func registNotifications() {

        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue:PlaceholderTextView.NotificationTextViewDidChanged),
                                               object: nil,
                                               queue: OperationQueue.main) {
                                                
            if let info = $0.userInfo {
                
                let textView = info["info"] as! UITextView
                
                let text = textView.text!
                
                if text.characters.count > 0 {
                    self.rightNavigationItem.isEnabled = true
                }
                else {
                    self.rightNavigationItem.isEnabled = false
                }
                
                if self.writeType == .modify {
                    self.contents = text
                }
            }
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue:PlaceholderTextField.NotificationTextFieldDidChanged),
                                               object: nil,
                                               queue: OperationQueue.main) {
            
            if let info = $0.userInfo {
                
                let text = info["info"] as! String
                
                if self.writeType == .modify {
                    self.placeholder = text
                }
            }
        }
    }
}

extension WriteMemoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.getCellReuseIdentifier(indexPath), for: indexPath)
        
        if self.writeType == .modify {
         
            self.setModifyMemoData(indexPath, withCell: cell)
        }
        
        return cell
    }
    
    func getCellReuseIdentifier(_ indexPath: IndexPath) -> String {
        
        if indexPath.section == WriteMemoSection.placeholder.rawValue {
            return "placeHolderTableViewCellId"
        }
        else if indexPath.section == WriteMemoSection.contents.rawValue{
            return "contentsTableViewCellId"
        }

        return ""
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.headerTitles[section]
    }
    
    func setModifyMemoData(_ indexPath: IndexPath, withCell cell: UITableViewCell) {
        
        if indexPath.section == WriteMemoSection.placeholder.rawValue {
            
            let textField = cell.viewWithTag(WriteMemoViewControllerElementsManager.kTextFieldElementTagId) as! UITextField
            
            textField.text = self.placeholder
            
        }
        else if indexPath.section == WriteMemoSection.contents.rawValue {
            
            let textView = cell.viewWithTag(WriteMemoViewControllerElementsManager.kTextViewElementTagId) as! PlaceholderTextView
            
            textView.text = self.contents

        }
    }
    
    func getInputtedMemoInfo() -> Dictionary<String, String> {
        
        let placeHolderCell = self.inputTableView.cellForRow(at: IndexPath.init(row: 0, section: WriteMemoSection.placeholder.rawValue))
        
        let textField = placeHolderCell?.viewWithTag(WriteMemoViewControllerElementsManager.kTextFieldElementTagId) as! UITextField
        
        let contentsCell = self.inputTableView.cellForRow(at: IndexPath.init(row: 0, section: WriteMemoSection.contents.rawValue))

        let textView = contentsCell?.viewWithTag(WriteMemoViewControllerElementsManager.kTextViewElementTagId) as! PlaceholderTextView
        
        var memoInfo = [String: String]()
        
        memoInfo["contents"] = textView.text
        memoInfo["placeHolder"] = textField.text
        
        if self.writeType == .newMemo {
            memoInfo["memoId"] = textView.text.encryption()
        }
        
        return memoInfo
    }
    
}

extension WriteMemoViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == WriteMemoSection.placeholder.rawValue {
            return 45
        }
        else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}

extension WriteMemoViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
