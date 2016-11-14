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

    override init() {
        
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
        
        let realm = self.configRealm()

        let memos = realm.objects(RealmMemo.self)

        if memos.count > 0 {
            return true
        }

        return false
    }
    
    func hasFavoriteMemos() -> Bool {

        let realm = self.configRealm()

        if realm.objects(RealmMemo.self).filter(NSPredicate.init(format: "isFavorite = 1")).count > 0 {
            return true
        }
        
        return false
    }
    
    func addMemo(_ memo: RealmMemo) {
        
        let realm = self.configRealm()
        
        try! realm.write {
            realm.add(memo, update: true)
        }
    }

    func deleteMemo(withMemoId memo: RealmMemo) {
        
        let realm = self.configRealm()

        try! realm.write {
            realm.delete(memo)
        }
    }
    
    func getMemoAt(_ index: Int, withType type: MemoType) -> RealmMemo {
        
        let realm = self.configRealm()

        guard type == .normal else {
            return realm.objects(RealmMemo.self).filter(NSPredicate.init(format: "isFavorite = 1"))[index]
        }
        return realm.objects(RealmMemo.self)[index]
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
            
            UIPasteboard.general.string = self.getMemoAt(indexPath.row, withType: .favorite).contents
        }
        else if indexPath.section == MemoListSection.list.rawValue {

            UIPasteboard.general.string = self.getMemoAt(indexPath.row, withType: .normal).contents
        }
    }
    
    func copyFromPasteboard(){
        
        let content = UIPasteboard.general.string

        let newMemo = RealmMemo(value: ["content" : content, "memoId" : content?.encryption()])
        
        self.addMemo(newMemo)
        
    }
    
}

/**
 * Private method
 */

extension MemoManager {
    
    fileprivate func configRealm() -> Realm {
        
        var config = Realm.Configuration()
        
        config.schemaVersion = 2
        
        config.migrationBlock = { (migration, scheme) in 
        
        }
        
        return try! Realm()
    }
}


