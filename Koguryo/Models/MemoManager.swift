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
    func hasMemo() -> Bool {
        
        if (allOfMemos?.count)! > 0 {
            return true
        }
        return false
    }
    
    func hasFavoriteMemos() -> Bool {
        
        if favoriteMemos != nil {
            
            if (favoriteMemos?.count)! > 0 {
                return true
            }
        }
        
        return false
    }
    
    func addMemo(_ memo: RealmMemo) {
        
        let realm = self.configRealm()
        
        try! realm.write {
            realm.add(memo)
        }
    }
    
    func getMemoCount(withType type: MemoType) -> Int {
        
        let realm = self.configRealm()

        guard type == .normal else {
            
            return realm.objects(RealmMemo.self).filter(NSPredicate.init(format: "isFavorite = 1")).count
        }
        let memos = realm.objects(RealmMemo.self)
        
        return memos.count
    }
    
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
 * Private method
 */

extension MemoManager {
    
    fileprivate func configRealm() -> Realm {
        
        var config = Realm.Configuration()
        
        config.schemaVersion = 0
        
        return try! Realm()
    }
}


