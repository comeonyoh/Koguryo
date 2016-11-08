//
//  WriteMemoViewController.swift
//  Koguryo
//
//  Created by KimJungSu on 11/7/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit

class WriteMemoViewController: UIViewController {

    enum WriteType {
        case newMemo
        case modify
    }
    
    static let identifier = "WriteMemoViewController"
    
    var writeType: WriteType = .newMemo
    
    var memoInfo: Memo?
    
    
    @IBOutlet weak var rightNavigationItem: UIBarButtonItem!
    
    @IBOutlet weak var inputTableView: UITableView!
    
    
    let headerTitles = [NSLocalizedString("tag", comment: "tag"), NSLocalizedString("contents", comment: "")]


    
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
