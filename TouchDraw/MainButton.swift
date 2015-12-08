//
//  MainButton.swift
//  FlashCardsGame
//
//  Created by Paul Vagner on 11/4/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit

@IBDesignable

    class MainButton: UIButton {
        
        @IBInspectable var cornerRadius: CGFloat = 0
        
        
        override func drawRect(rect: CGRect) {
            
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
            layer.borderWidth = borderWidth
            layer.borderColor = borderColor
            
        }
        
        @IBInspectable var borderWidth: CGFloat = 2
    
        @IBInspectable var borderColor: CGColor = UIColor.blackColor().CGColor
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

