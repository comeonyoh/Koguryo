//
//  AppDelegate.swift
//  Koguryo
//
//  Created by KimJungSu on 11/7/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let NotificationBecomeActive = "kNotificationBecomeActive"

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?)
        -> Bool {

            FirebaseApp.configure()
            return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: AppDelegate.NotificationBecomeActive), object: self)

    }

}

