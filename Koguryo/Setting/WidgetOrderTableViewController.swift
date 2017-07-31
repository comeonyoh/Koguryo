//
//  WidgetOrderTableViewController.swift
//  Koguryo
//
//  Created by Clayton Kim on 2017. 7. 31..
//  Copyright © 2017년 ODOV. All rights reserved.
//

import UIKit

class WidgetOrderTableViewController: UITableViewController {

    let orderOptions = [NSLocalizedString("favorite_recent_order", comment: ""), NSLocalizedString("recent_order", comment: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        User.shared.widgetOrder = WidgetOrderKey(rawValue: indexPath.row)!
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderOptions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderWiegetCellIdentifier", for: indexPath)
        
        cell.textLabel?.text = orderOptions[indexPath.row]
        
        if User.shared.widgetOrder.rawValue == indexPath.row {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return NSLocalizedString("widget_order_info", comment: "")
    }
}
