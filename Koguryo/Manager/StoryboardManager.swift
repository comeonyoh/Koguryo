//
//  StoryboardManager.swift
//  Koguryo
//
//  Created by KimJungSu on 11/8/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit

class StoryboardManager: NSObject {

    static let mainStoryboard = "Main"
    
    static func getMainStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: StoryboardManager.mainStoryboard, bundle: nil)
    }
}
