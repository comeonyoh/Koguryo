//
//  PlaceholderTextField.swift
//  Koguryo
//
//  Created by KimJungSu on 11/8/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit

class PlaceholderTextField: UITextField, UITextFieldDelegate {

    static let NotificationTextFieldDidChanged = "kNotificationTextFieldDidChanged"

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.delegate = self
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let text = textField.text! + string
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: PlaceholderTextField.NotificationTextFieldDidChanged), object: self, userInfo: ["info":text])
        
        return true
    }

}
