//
//  Memo.swift
//  Koguryo
//
//  Created by KimJungSu on 11/7/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import Foundation

class Memo: NSObject, NSCopying, Realmable {
    
    var contents: String?
    
    var placeHolder: String?
    
    var createDate: Date?
    
    convenience init(memo withContents: String?) {
        
        self.init(memo: withContents, withPlaceHolder:nil)
    }
    
    init(memo withContents: String?, withPlaceHolder placeHolder: String?) {
        self.contents = withContents
        self.placeHolder = placeHolder
        self.createDate = Date.init()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        
        if object is Memo, let anotherMemo = object as! Memo! {
            
            if anotherMemo.createDate == self.createDate {
                return true
            }
        }
        
        return false
    }
   
    public func copy(with zone: NSZone? = nil) -> Any {
        
        let copiedMemo = Memo.init(memo: self.contents, withPlaceHolder: self.placeHolder)
        
        return copiedMemo
    }
    
    
    func realmDictionary() -> Dictionary <String, AnyObject> {
        return ["contents": self.contents as AnyObject, "placeHolder": self.placeHolder as AnyObject, "createDate": self.createDate as AnyObject]
    }

}
