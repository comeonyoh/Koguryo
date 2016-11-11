//
//  RealmClipboard.swift
//  Koguryo
//
//  Created by KimJungSu on 11/11/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import Foundation

import RealmSwift

class RealmClipboard: Object {
    
    let favoriteNotes = List<RealmMemo>()
    
    let allOfNotes = List<RealmMemo>()
    
}
