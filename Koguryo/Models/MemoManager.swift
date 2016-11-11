//
//  MemoList.swift
//  Koguryo
//
//  Created by KimJungSu on 11/7/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import Foundation

import UIKit
import RealmSwift

class MemoManager: NSObject {

    let maxCountOfFavoriteMemos = 3

    var favoriteMemos : Array<RealmMemo>?
    
    var allOfMemos: Array<RealmMemo>?
  
    override init() {
        allOfMemos = Array.init()
        favoriteMemos = Array.init()
    }
    
}


/**
 * Extension about Memo list
 */

extension MemoManager {

    /**
     * Open Interface that can community with ViewController
     */
    
    func hasFavoriteMemos() -> Bool {
        
        if favoriteMemos != nil {
            
            if (favoriteMemos?.count)! > 0 {
                return true
            }
        }
        
        return false
    }
    
    func hasMemo() -> Bool {
        
        if (allOfMemos?.count)! > 0 {
            return true
        }
        return false
    }
    
//    func addFavoriteMemo(_ memo: Memo) -> Bool {
//        
//        if (favoriteMemos?.count)! < maxCountOfFavoriteMemos {
//            
//            favoriteMemos?.append(memo)
//            
//            return true
//        }
//        
//        return false
//    }
//    
//    func getMemo(withIndexPath indexPath: IndexPath) -> Memo? {
//        
//        if indexPath.section == MemoListSection.favorite.rawValue {
//            return favoriteMemos?[indexPath.row]
//        }
//        else if indexPath.section == MemoListSection.list.rawValue {
//            return allOfMemos?[indexPath.row]
//        }
//        
//        return nil
//    }

}


/**
 * Extension about Pasteboard
 */

extension MemoManager {
    
    func copyToPasteboard(withIndex indexPath: IndexPath) {
        
        if indexPath.section == MemoListSection.favorite.rawValue {
            
            UIPasteboard.general.string = self.favoriteMemos?[indexPath.row].contents
        }
        else if indexPath.section == MemoListSection.list.rawValue {

            UIPasteboard.general.string = self.allOfMemos?[indexPath.row].contents
        }
    }
    
    func copyFromPasteboard(){
        
        let content = UIPasteboard.general.string
        
        let newMemo = RealmMemo(value: ["content": content])
        
        self.allOfMemos?.append(newMemo)
        
    }
    
}


/**
 * Extension about Realm Service
 */

extension MemoManager {

    
    
}
