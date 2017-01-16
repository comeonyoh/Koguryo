//
//  NoMarginTextView.swift
//  Koguryo
//
//  Created by JungSu Kim on 2017. 1. 16..
//  Copyright © 2017년 ODOV. All rights reserved.
//

import UIKit

class NoMarginTextView: UITextView {
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        self.setMarginZero()
    }
    
    func setMarginZero() {
        
        self.textContainer.lineFragmentPadding = 0
        self.textContainerInset = UIEdgeInsets.zero
        self.textContainer.lineBreakMode = .byWordWrapping
    }
    
}
