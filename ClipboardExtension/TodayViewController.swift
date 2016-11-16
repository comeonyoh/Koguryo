//
//  TodayViewController.swift
//  ClipboardExtension
//
//  Created by KimJungSu on 11/9/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit
import NotificationCenter


enum ClipboardIndex: Int {
    case addMemo
    case normalMemo
}

class TodayViewController: UIViewController, NCWidgetProviding {
    
    var favoriteMemos: Array<Memo> = [Memo]()
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var clipboardTableView: UITableView!

    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.setLayout()

        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        self.synchronizeDataBetweenAppAndExtension()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
        if activeDisplayMode == .expanded {
            self.preferredContentSize = CGSize.init(width: 0.0, height: 245.0)
        }
            
        else if activeDisplayMode == .compact {
            self.preferredContentSize = maxSize
        }
    }
    
    @IBAction func didSettingButtonClicked(_ sender: Any) {
        
        self.extensionContext?.open(URL.init(string: "Koguryo://")!, completionHandler: nil)
    }
    
}

/**
 * Set layout
 */

extension TodayViewController {

    func setLayout() {
        
        
        self.clipboardTableView.register(UINib.init(nibName: MemoListTableViewCell.identifier, bundle: nil),
                                         forCellReuseIdentifier: MemoListTableViewCell.identifier)
        
        self.clipboardTableView.register(UINib.init(nibName: AddMemoButtonTableViewCell.identifier, bundle: nil),
                                         forCellReuseIdentifier: AddMemoButtonTableViewCell.identifier)
    }
}

extension TodayViewController {

    func synchronizeDataBetweenAppAndExtension() {
        
        let shareInfo = UserDefaults.init(suiteName: GroupKey.groupKey)
    
        let favoriteMemos = shareInfo?.object(forKey: GroupKey.favorites) as! Array<Dictionary<String, String>>?
        
        if favoriteMemos != nil {
            
            for( _ , memoInfo) in (favoriteMemos?.enumerated())! {
                
                let memo = Memo.init(memoInfo)
                
                self.favoriteMemos.insert(memo, at: 0)
            }
        }
        
        self.clipboardTableView.reloadData()
    }

}

extension TodayViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1 + self.favoriteMemos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard indexPath.row != ClipboardIndex.addMemo.rawValue else {
            
            let addPlusCell = tableView.dequeueReusableCell(withIdentifier: AddMemoButtonTableViewCell.identifier, for: indexPath)
            
            return addPlusCell
        }
        
        let memoCell = tableView.dequeueReusableCell(withIdentifier: MemoListTableViewCell.identifier, for: indexPath)
        
        let memo = self.favoriteMemos[indexPath.row - 1]
        
        if memo.placeHolder != nil && (memo.placeHolder?.characters.count)! > 0 {
            memoCell.textLabel?.text = memo.placeHolder
        }
        else {
            memoCell.textLabel?.text = memo.contents
        }

        memoCell.detailTextLabel?.text = NSLocalizedString("copy", comment: "")
        
        return memoCell
    }

}

extension TodayViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        guard indexPath.row != ClipboardIndex.addMemo.rawValue else {
            
            CopyPasteManager.copyToPasteboard()
            
            return
        }
        
        CopyPasteManager.copyFromPasteboard(self.favoriteMemos[indexPath.row - 1].contents)

        DispatchQueue.main.async {
            self.statusLabel.text = NSLocalizedString("copy_success", comment: "")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { 
                self.statusLabel.text = NSLocalizedString("copy_wait", comment: "")
            })
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard indexPath.row != 0 else {
            return 45
        }
        
        return 55
    }
    
}
