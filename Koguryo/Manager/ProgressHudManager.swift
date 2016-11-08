//
//  ProgressHudManager.swift
//  Koguryo
//
//  Created by KimJungSu on 11/8/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit
import JGProgressHUD

class ProgressHudManager: NSObject {

    static func showCopyHUD(inView view: UIView) {
        
        let hud = JGProgressHUD.init(style: .dark)
        
        hud?.textLabel.text = NSLocalizedString("copy", comment: "copy")
        hud?.indicatorView = JGProgressHUDSuccessIndicatorView.init()
        
        hud?.show(in: view)
        hud?.dismiss(afterDelay: 0.5, animated: true)
        
    }
}
