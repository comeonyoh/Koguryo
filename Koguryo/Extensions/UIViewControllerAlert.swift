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

    enum AnswerType {
        case OK
        case cancel
    }
    
    typealias AnswerIndexHandler = (AnswerType) -> Void

    //  USED only without no choice case
    func showAlertView(withPrompt message: String?) {
        
        let alert = UIAlertController.init(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction.init(title: NSLocalizedString("confirm", comment: ""), style: UIAlertActionStyle.`default`) { (action) in }
        
        alert.addAction(action)

        self.present(alert, animated: true, completion: nil)
    }

    //  USED only with 2 options
    func showAlertView(withPromt message: String?, withSelectIndex handler : AnswerIndexHandler?) {
        
        let alert = UIAlertController.init(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction.init(title: NSLocalizedString("confirm", comment: ""), style: UIAlertActionStyle.`default`) { (action) in handler?(AnswerType.OK) }
        
        let cancelAction = UIAlertAction.init(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.cancel) { (action) in handler?(AnswerType.cancel) }
        
        alert.addAction(OKAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
