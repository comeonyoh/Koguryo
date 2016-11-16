//
//  Memo.swift
//  Koguryo
//
//  Created by KimJungSu on 11/16/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import Foundation

struct Memo {
    
    var memoId: String!
    
    var contents: String!

    var placeHolder: String?

    
    init(_ dictionary: Dictionary<String, String>) {

        self.memoId = dictionary["memoId"]
        self.contents = dictionary["contents"]
        self.placeHolder = dictionary["placeHolder"]
    }
}
