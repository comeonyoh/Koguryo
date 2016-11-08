//
//  WriteMemoViewController.swift
//  Koguryo
//
//  Created by KimJungSu on 11/7/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit

class WriteMemoViewController: UIViewController {

    @IBOutlet weak var rightNavigationItem: UIBarButtonItem!
    
    @IBOutlet weak var inputTableView: UITableView!
    
    let headerTitles = [NSLocalizedString("tag", comment: "tag"), NSLocalizedString("contents", comment: "")]

    enum WriteMemoSection: Int {
        case placeholder
        case contents
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        _ = self.shouldAutorotate
        _ = self.supportedInterfaceOrientations
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
