//
//  MemoListTableViewCell.swift
//  Koguryo
//
//  Created by KimJungSu on 11/7/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit
import MGSwipeTableCell

protocol MemoListTableViewCellDelegate: class {
    
    func memoListTableViewCell(didCopyButtonClicked copyButton: UIButton, withIndexPath indexPath: IndexPath)
}


class MemoListTableViewCell: MGSwipeTableCell {

    var indexPath: IndexPath?
    
    weak var eventDelegate: MemoListTableViewCellDelegate?
    
    static let identifier = "MemoListTableViewCell"

    @IBOutlet weak var messageContentsLabel: UILabel!

    
    //  Interface method that communicate with ViewController
    
    @IBAction func didCopyButtonClicked(_ sender: Any) {

        if let path = self.indexPath {
            
            let button = sender as! UIButton
            
            self.eventDelegate?.memoListTableViewCell(didCopyButtonClicked: button, withIndexPath: path)
        }
    }
    
    func configureCell(withMemo memo: Memo?, withIndexPath indexPath: IndexPath)  {
        
        if memo?.placeHolder != nil {
            messageContentsLabel.text = memo?.placeHolder
        }
        else {
            messageContentsLabel.text = memo?.contents
        }
        
        self.indexPath = indexPath
    }

}
