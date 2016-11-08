//
//  PlaceholderTextView.swift
//  Koguryo
//
//  Created by KimJungSu on 11/8/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit

class PlaceholderTextView: UITextView {

    static let NotificationTextViewDidChanged = "kNotificationTextViewDidChanged"
    
    var isEdited: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.delegate = self
    }
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        guard self.text.characters.count == 0 else {
            
            self.isEdited = true
            
            return
        }
        
        self.textColor = UIColor.init(red: 0.7803, green: 0.7803, blue: 0.8039, alpha: 1.0)
        self.text = NSLocalizedString("input_contents_placeholder", comment: "")
    }
}

extension PlaceholderTextView: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if self.isEdited == false {
            self.text = ""
            self.isEdited = true
            self.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.characters.count == 0 {
            self.isEdited = false
            self.text = NSLocalizedString("input_contents_placeholder", comment: "")
            self.textColor = UIColor.init(red: 0.7803, green: 0.7803, blue: 0.8039, alpha: 1.0)
        }
        else {
            self.isEdited = true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: PlaceholderTextView.NotificationTextViewDidChanged), object: self, userInfo: ["info":textView])
    }
}
