//
//  File.swift
//  Koguryo
//
//  Created by KimJungSu on 11/11/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import Foundation

protocol Realmable {
    
    func realmDictionary() -> Dictionary <String, AnyObject>
}
