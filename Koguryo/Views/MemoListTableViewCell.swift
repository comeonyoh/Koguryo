//
//  MemoListTableViewCell.swift
//  Koguryo
//
//  Created by KimJungSu on 11/7/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit
import MGSwipeTableCell
import UIColor_Hex_Swift


enum SwipeButtonEvent {
    case favorite
    case remove
}

protocol MemoListTableViewCellDelegate: class {
    
    func memoListTableViewCell(didCopyButtonClicked copyButton: UIButton, withIndexPath indexPath: IndexPath)
    
    func memoListTableViewCell(didSwipeButtonClicked event: SwipeButtonEvent, withIndexPath indexPath: IndexPath)
}


class MemoListTableViewCell: MGSwipeTableCell, MGSwipeTableCellDelegate {

    static let longInset = UIEdgeInsets.init(top: 2.0, left: 20.0, bottom: 2.0, right: 20.0)
    
    static let shortInset = UIEdgeInsets.init(top: 2.0, left: 10.0, bottom: 2.0, right: 10.0)

    var indexPath: IndexPath?
    
    weak var eventDelegate: MemoListTableViewCellDelegate?
    
    static let identifier = "MemoListTableViewCell"

    @IBOutlet weak var messageContentsLabel: UILabel!

    
    //  Interface method that communicate with ViewController
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.delegate = self
    }
    
    
    @IBAction func didCopyButtonClicked(_ sender: Any) {

        if let path = self.indexPath {
            
            let button = sender as! UIButton
            
            self.eventDelegate?.memoListTableViewCell(didCopyButtonClicked: button, withIndexPath: path)
        }
    }
    
    func configureCell(withMemo memo: RealmMemo?, withIndexPath indexPath: IndexPath)  {
        
        if memo?.placeHolder != nil && (memo?.placeHolder?.characters.count)! > 0{
            messageContentsLabel.text = memo?.placeHolder
        }
        else {
            messageContentsLabel.text = memo?.contents
        }
        
        self.indexPath = indexPath

        self.setBothPositionButtons(withIndexPath: indexPath)
    }
    
    func setBothPositionButtons(withIndexPath indexPath: IndexPath)  {

        self.rightButtons = [MGSwipeButton.init(title: NSLocalizedString("delete", comment: ""),
                                                backgroundColor: UIColor.red,
                                                insets: MemoListTableViewCell.longInset)]
        
        if indexPath.section == MemoListSection.favorite.rawValue {
            
            self.leftButtons = [MGSwipeButton.init(title: NSLocalizedString("favorite_delete", comment: ""), backgroundColor: UIColor.init("#25A0EE"), insets: MemoListTableViewCell.shortInset)]
        }
            
        else if indexPath.section == MemoListSection.list.rawValue {
            self.leftButtons = [MGSwipeButton.init(title: NSLocalizedString("favorite_add", comment: ""), backgroundColor: UIColor.init("#25A0EE"), insets: MemoListTableViewCell.shortInset)]
        }

    }
    
    func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        
        //  add favorite or not
        if direction == .leftToRight {
            self.eventDelegate?.memoListTableViewCell(didSwipeButtonClicked: .favorite, withIndexPath: self.indexPath!)
        }
        //  delete
        else if direction == .rightToLeft {
            self.eventDelegate?.memoListTableViewCell(didSwipeButtonClicked: .remove, withIndexPath: self.indexPath!)
        }

        return true
    }


}
