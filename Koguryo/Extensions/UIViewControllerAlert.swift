//
//  UIViewControllerAlert.swift
//  Koguryo
//
//  Created by KimJungSu on 11/16/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func showAlertView(withPrompt message: String?) {
        
        let alert = UIAlertController.init(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction.init(title: NSLocalizedString("confirm", comment: ""), style: UIAlertActionStyle.`default`) { (action) in
        }
        
        alert.addAction(action)

        self.present(alert, animated: true, completion: nil)
    }
}
