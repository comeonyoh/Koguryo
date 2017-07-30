//
//  DateExtension.swift
//  Koguryo
//
//  Created by JungSu Kim on 2017. 7. 30..
//  Copyright © 2017년 ODOV. All rights reserved.
//

import Foundation

extension Date {
    
    func localString() -> String {
        
        let format = DateFormatter()
        
        format.dateStyle = .long
        format.timeStyle = .short
        
        return format.string(from: self)
    }
}
