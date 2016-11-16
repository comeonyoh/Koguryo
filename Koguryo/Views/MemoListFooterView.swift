//
//  MemoListFooterView.swift
//  Koguryo
//
//  Created by KimJungSu on 11/16/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit

class MemoListFooterView: UIView {

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.loadXib()
    }
    
    func loadXib() {
        
        let view = Bundle.init(for: self.classForCoder).loadNibNamed("MemoListFooterView", owner: self, options: nil)?.first as! UIView
        
        view.frame = self.bounds
        
        self.addSubview(view)
    }

}
