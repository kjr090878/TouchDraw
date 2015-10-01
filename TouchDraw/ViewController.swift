//
//  ViewController.swift
//  TouchDraw
//
//  Created by Kelly Robinson on 9/30/15.
//  Copyright © 2015 Kelly Robinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var controlPanelTop: NSLayoutConstraint!
    
    
    @IBOutlet weak var controlPanelView: UIView!

    @IBAction func toggleControlPanel(sender: AnyObject) {
        
        controlPanelTop.constant = controlPanelView.frame.origin.y == 0 ? -200 : 0
        
        
        self.controlPanelTop.constant = self.controlPanelView.frame.origin.y == 0 ? -200 : 0
        
        view.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(0.4) { () -> Void in
            
         self.view.layoutIfNeeded()

            
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            
            /////// LINE
            
            
//            let newLine = Line()
//            
//            
//            newLine.start = touch.locationInView(view)
//            newLine.strokeColor = UIColor.blackColor()
//            newLine.strokeWidth = 10
//            
//            (view as? DrawView)?.lines.append(newLine)
            
            /////// SCRIBBLE
//            
//            let newScribble = Scribble()
//
//            newScribble.points.append(touch.locationInView(view))
//            
//            newScribble.strokeColor = UIColor.blackColor()
//            newScribble.strokeWidth = 10
//            
//            (view as? DrawView)?.lines.append(newScribble)
            
            /////// Shape
            
            let shape = Shape(type: .Circle)
            
            shape.start = touch.locationInView(view)
            
            shape.fillColor = UIColor.blackColor()
            
            (view as? DrawView)?.lines.append(shape)
            
            view.setNeedsDisplay()
            
        }
        
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            
//            if let currentLine = (view as? DrawView)?.lines.last {
//                
//                currentLine.end = touch.locationInView(view)
//                
//                view.setNeedsDisplay()
            ///// SCRIBBLE
            
            
//            if let currentScribble = (view as? DrawView)?.lines.last as? Scribble {
//                
//                currentScribble.points.append(touch.locationInView(view))
//                
//                view.setNeedsDisplay()
            
//            }
            
            ////// SHAPE
            
            if let currentShape = (view as? DrawView)?.lines.last {
                
                currentShape.end = touch.locationInView(view)
                
                                view.setNeedsDisplay()
            
            }
            
        }
        
    }
}