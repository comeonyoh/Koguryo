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

enum PasteboardItem {
    case none
    case string
    case image
}

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

        let memos = realm.objects(RealmMemo.self).filter(NSPredicate.init(format: "isFavorite = 0"))

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
        
        let currentMemoCount = self.getMemoCount(withType: .favorite)
        
        if currentMemoCount < 3 {
            memo.isFavorite = true
        }
        
        try! realm.write {
            realm.add(memo, update: true)
        }
    }

    func deleteMemo(withMemo memo: RealmMemo) {
        
        let realm = self.configRealm()

        try! realm.write {
            realm.delete(memo)
        }
    }
    
    func getMemoAt(_ indexPath: IndexPath) -> RealmMemo {

        let realm = self.configRealm()
        
        guard indexPath.section == MemoListSection.list.rawValue else {
            return realm.objects(RealmMemo.self).filter(NSPredicate.init(format: "isFavorite = 1")).sorted(byProperty: "createDate", ascending: false)[indexPath.row]
        }

        return realm.objects(RealmMemo.self).filter(NSPredicate.init(format: "isFavorite = 0")).sorted(byProperty: "createDate", ascending: false)[indexPath.row]
    }
    
    func getMemoAt(_ index: Int, withType type: MemoType) -> RealmMemo {
        
        let realm = self.configRealm()

        guard type == .normal else {
            return realm.objects(RealmMemo.self).filter(NSPredicate.init(format: "isFavorite = 1")).sorted(byProperty: "createDate", ascending: false)[index]
        }
        return realm.objects(RealmMemo.self).filter(NSPredicate.init(format: "isFavorite = 0")).sorted(byProperty: "createDate", ascending: false)[index]
    }
    
    func getMemoCount(withType type: MemoType) -> Int {
        
        let realm = self.configRealm()

        guard type == .normal else {
            return realm.objects(RealmMemo.self).filter(NSPredicate.init(format: "isFavorite = 1")).count
        }
        
        let memos = realm.objects(RealmMemo.self).filter(NSPredicate.init(format: "isFavorite = 0"))
        
        return memos.count
    }
    
    func updateMemo(withMemoId memoId: String, withNewInfo newInfo: Dictionary<String, String>)  {

        let realm = self.configRealm()

        let memo = realm.objects(RealmMemo.self).filter(NSPredicate.init(format: "memoId = %@", memoId))
        
        if memo.first != nil {

            try! realm.write {
                
                memo.first?.contents = newInfo["contents"]
                memo.first?.placeHolder = newInfo["placeHolder"]

                realm.add(memo, update: true)
            }
        }
    }
    
    func updateMemoFavorite(withIndexPath indexPath: IndexPath) -> Bool{
        
        let memo = self.getMemoAt(indexPath)
        
        let realm = self.configRealm()

        if memo.isFavorite == false {

            guard realm.objects(RealmMemo.self).filter(NSPredicate.init(format: "isFavorite = 1")).count < 3 else {
                return false
            }
        }

        try! realm.write {

            memo.isFavorite = !memo.isFavorite
            
            realm.add(memo, update: true)
        }
        
        return true
    }
    
    func getFavoriteMemos() -> Array<Dictionary<String, String>>? {
        
        let realm = self.configRealm()
        
        //  Search favorite memos
        let queryResult = realm.objects(RealmMemo.self).filter(NSPredicate.init(format: "isFavorite = 1"))
        
        guard queryResult.count > 0 else {
            return nil
        }
        
        var resultInfo = [Dictionary<String, String>]()
        
        for (_, resultItem ) in queryResult.enumerated() {
            resultInfo.append(resultItem.dictionary())
        }
        
        return resultInfo
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

        if content != nil && (content?.characters.count)! > 0 {

            let newMemo = RealmMemo(value: ["contents" : content, "memoId" : content?.encryption()])
            
            self.addMemo(newMemo)
        }
    }
    
    func hasPasteboardItem() -> PasteboardItem {
        
        if UIPasteboard.general.string != nil {
            return .string
        }
        else if UIPasteboard.general.image != nil {
            return .image
        }
        
        return .none
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


