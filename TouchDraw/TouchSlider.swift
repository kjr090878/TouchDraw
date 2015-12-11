//
//  TouchSlider.swift
//  CustomSlider
//
//  Created by Kelly Robinson on 10/2/15.
//  Copyright © 2015 Kelly Robinson. All rights reserved.
//

import UIKit


@IBDesignable
class TouchSlider: UIControl {
    
    @IBInspectable var barColor: UIColor = UIColor.blackColor()
    @IBInspectable var value: CGFloat = 0 {
        
        didSet {
            
            if value < minValue { value = minValue }
            if value > maxValue { value = maxValue }
            
            setNeedsDisplay()
            
        }
        
    }
    
    
    
    @IBInspectable var minValue: CGFloat = 0
    @IBInspectable var maxValue: CGFloat = 100

    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        barColor.set()
        
        CGContextMoveToPoint(context, 0, rect.height / 2)
        CGContextAddLineToPoint(context, rect.width, rect.height / 2)
        
        CGContextStrokePath(context)
    
        
        CGContextFillEllipseInRect(context, handleRect)
        
        CGContextSetBlendMode(context, .Clear)
        
        CGContextFillEllipseInRect(context, CGRectInset(handleRect, 5, 5))
        
        CGContextSetBlendMode(context, .Normal)
        
        CGContextFillPath(context)
        
    }
    
    var handleRect: CGRect {
        
        let handleX = (bounds.width - bounds.height) * (value / maxValue)
        
        return CGRect(x: handleX, y: 0, width: bounds.height, height: bounds.height)
        
        
    }
    
    var isTouchingHandle = false
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            
            let locPoint = touch.locationInView(self)
            
            isTouchingHandle = CGRectContainsPoint(handleRect, locPoint)
            
        }
        
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if isTouchingHandle {
            
            if let touch = touches.first {
                
                let touchX = touch.locationInView(self).x
                
                let removeRadius = touchX - bounds.height / 2
                
                let fullDistance = bounds.width - bounds.height
                
                let percent = removeRadius / fullDistance
                
                value = percent * maxValue

                sendActionsForControlEvents(.ValueChanged)
                
            }
            
        }
    }
    
}
