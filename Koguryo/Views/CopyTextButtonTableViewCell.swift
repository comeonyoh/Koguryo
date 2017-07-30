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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    @IBAction func didSaveButtonClicked(_ sender: Any) {

        if self.saveButton.isEnabled == true {

            let btn = sender as! UIButton
            
            springAnimate(inView: btn)
            self.delegate?.copyTextButtonTableViewCell(didCopyButtonClicked: btn)
        }
    }
    
}

/**
 * Methods about status
 */

extension CopyTextButtonTableViewCell {
    
    func enable(_ enabled: Bool) {
        self.saveButton.isEnabled = enabled
    }
    
}
