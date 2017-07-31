//
//  User.swift
//  Koguryo
//
//  Created by Clayton Kim on 2017. 7. 31..
//  Copyright © 2017년 ODOV. All rights reserved.
//

import Foundation

class User {
    
    static let shared = User()
    
    var widgetOrder: WidgetOrderKey {
        
        set(newValue) {
            UserDefaults.standard.set(newValue.rawValue, forKey: "widget_ordering_key")
            UserDefaults.standard.synchronize()
        }
        get {
            return WidgetOrderKey(rawValue: UserDefaults.standard.integer(forKey: "widget_ordering_key"))!
        }
    }
    
    private init() {}
    
}
