//
//  CopyTextButtonTableViewCell.swift
//  Koguryo
//
//  Created by KimJungSu on 11/7/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit

protocol CopyTextButtonTableViewCellDelegate: class {
    func copyTextButtonTableViewCell(didCopyButtonClicked: UIView)
}

class CopyTextButtonTableViewCell: UITableViewCell {

    static let identifier = "CopyTextButtonTableViewCell"

    weak var delegate: CopyTextButtonTableViewCellDelegate?
    
}
