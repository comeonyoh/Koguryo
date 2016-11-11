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
    
    dynamic var createDate: Date?
}
