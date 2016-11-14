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

extension String {
    
    func encryption() -> String {
      
        let dateFormatter = DateFormatter.init()
        
        dateFormatter.dateFormat = "yyyyMMddHHmmssSSS"
        
        let fromDate = Date.timeIntervalBetween1970AndReferenceDate
        
        let dateString = dateFormatter.string(from: Date.init()) + String(fromDate) + self
        
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        
        if let d = dateString.data(using: String.Encoding.utf8) {
            
            _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}
