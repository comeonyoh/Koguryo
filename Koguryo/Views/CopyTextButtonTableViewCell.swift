//
//  CopyTextButtonTableViewCell.swift
//  Koguryo
//
//  Created by KimJungSu on 11/7/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit
import pop

protocol CopyTextButtonTableViewCellDelegate: class {
    func copyTextButtonTableViewCell(didCopyButtonClicked: UIView)
}

class CopyTextButtonTableViewCell: UITableViewCell, Animationable {

    @IBOutlet weak var saveButton: UIButton!
    
    static let identifier = "CopyTextButtonTableViewCell"

    weak var delegate: CopyTextButtonTableViewCellDelegate?
    
    @IBAction func didSaveButtonClicked(_ sender: Any) {

        let btn = sender as! UIButton

        springAnimate(inView: btn)
    }
    
}
