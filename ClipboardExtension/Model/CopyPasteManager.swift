//
//  CopyPasteManager.swift
//  Koguryo
//
//  Created by JungSu Kim on 2016. 11. 11..
//  Copyright © 2016년 ODOV. All rights reserved.
//

import Foundation
import UIKit

class CopyPasteManager: NSObject {
    
    static func copyToPasteboard() {
        
        //  Add to list
        
    }
    
    static func copyFromPasteboard(_ string: String) {
        
        UIPasteboard.general.string = string
    }
}
