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
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var clipboardTableView: UITableView!

    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.setLayout()

        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
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
 * set Layout
 */
extension TodayViewController {

    func setLayout() {
        
        self.clipboardTableView.register(UINib.init(nibName: MemoListTableViewCell.identifier, bundle: nil),
                                         forCellReuseIdentifier: MemoListTableViewCell.identifier)
        
        self.clipboardTableView.register(UINib.init(nibName: AddMemoButtonTableViewCell.identifier, bundle: nil),
                                         forCellReuseIdentifier: AddMemoButtonTableViewCell.identifier)
    }
}

extension TodayViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard indexPath.row != ClipboardIndex.addMemo.rawValue else {
            
            let addPlusCell = tableView.dequeueReusableCell(withIdentifier: AddMemoButtonTableViewCell.identifier, for: indexPath)
            
            return addPlusCell
        }
        
        let memoCell = tableView.dequeueReusableCell(withIdentifier: MemoListTableViewCell.identifier, for: indexPath)
        
        if indexPath.row == 1 {
            memoCell.textLabel?.text = "우리집 주소"
        }
            
        else if indexPath.row == 2 {
            memoCell.textLabel?.text = "내 계좌번호"
        }
            
        else if indexPath.row == 3{
            memoCell.textLabel?.text = "www.naver.com"
        }
        
        memoCell.detailTextLabel?.text = "복사하기"
        
        return memoCell
    }

}

extension TodayViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        guard indexPath.row != ClipboardIndex.addMemo.rawValue else {
            
            CopyPasteManager.copyToPasteboard()
            
            return
        }

        CopyPasteManager.copyFromPasteboard("위젯 테스트")

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
