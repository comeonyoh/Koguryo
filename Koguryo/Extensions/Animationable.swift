//
//  Animationable.swift
//  Koguryo
//
//  Created by KimJungSu on 11/8/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import Foundation

import pop
import UIKit

protocol Animationable {
    
    func springAnimate(inView view: UIView)
}

extension Animationable {
    
    func springAnimate(inView view: UIView) {
        
        let anim = POPSpringAnimation.init(propertyNamed: kPOPViewScaleXY)
        
        anim?.toValue = NSValue.init(cgPoint: CGPoint.init(x: 1.2, y: 1.2))
        anim?.velocity = NSValue.init(cgPoint: CGPoint.init(x: 3, y: 3))
        anim?.springBounciness = 27.0
        
        view.pop_add(anim, forKey: "spring_animation")

    }
}
