//
//  MemoListTableViewCell.swift
//  Koguryo
//
//  Created by KimJungSu on 11/9/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit

class MemoListTableViewCell: UITableViewCell {

    static let identifier = "MemoListTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var copyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
