//
//  StringExtension.swift
//  Koguryo
//
//  Created by KimJungSu on 11/14/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import Foundation

protocol NonEmptyString {
    func protectStringNonEmpty(_ param: String?) -> String
}

extension NonEmptyString {
    
    func protectStringNonEmpty(_ param: String?) -> String {
        
        if param != nil {
            
            guard (param?.characters.count)! > 0 else {
                return ""
            }
            
            return param!
        }
        return ""
    }
}
