//
//  RealmMemo.swift
//  Koguryo
//
//  Created by KimJungSu on 11/11/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import Foundation
import RealmSwift

enum MemoType {
    case normal
    case favorite
}

class RealmMemo: Object {

    dynamic var contents: String?
    
    dynamic var placeHolder: String?

    dynamic var isFavorite: Bool = false
   
    dynamic var createDate: Date = Date.init()
    
    override func isEqual(_ object: Any?) -> Bool {
        
        if object is RealmMemo, let anotherMemo = object as! RealmMemo! {
            
            if anotherMemo.createDate == self.createDate {
                return true
            }
        }
        
        return false
    }
    
}

extension RealmMemo: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        
        let copiedMemo = RealmMemo.init(value: ["contents" : self.contents, "placeHolder": self.placeHolder, "createDate": self.createDate, "isFavorite": self.isFavorite])
        
        return copiedMemo
    }
    
}

