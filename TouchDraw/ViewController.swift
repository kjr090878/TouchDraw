//
//  ViewController.swift
//  TouchDraw
//
//  Created by Kelly Robinson on 9/30/15.
//  Copyright © 2015 Kelly Robinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    
    
    @IBOutlet weak var fillStroke: MainButton!
    
    @IBOutlet weak var strokeSlider: TouchSlider!
    
    @IBOutlet weak var controlPanelTop: NSLayoutConstraint!
    
    @IBOutlet weak var colorPallete: UICollectionView!
    
    @IBAction func toggleFillStroke(sender: AnyObject) {
        
        colorSource.isFill = !colorSource.isFill

        
        colorPallete.reloadData()
        
    }
    
    @IBOutlet weak var controlPanelView: UIView!
    
    @IBOutlet weak var toggleButton: ToggleButton!
    
    @IBAction func toggleControlPanel(sender: AnyObject) {
        
        controlPanelTop.constant = controlPanelView.frame.origin.y == 0 ? -200 : 0
        
        view.setNeedsUpdateConstraints()
        
        let degrees: CGFloat = controlPanelView.frame.origin.y == 0 ? 0 : 180
        
        UIView.animateWithDuration(0.4) { () -> Void in
            
            self.view.layoutIfNeeded()
            
            let degreesToRadians: (CGFloat) -> CGFloat = {
                return $0 / 180.0 * CGFloat(M_PI)
            }
            
            let t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
            self.toggleButton.transform = t
            
        }
        
    }
    
    let colorSource = Colors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controlPanelTop.constant = -200
        
        print(colorPallete)
        
        colorPallete.delegate = self
        colorPallete.dataSource = colorSource
        
        print(colorPallete.dataSource)
        
        colorPallete.reloadData()
    
    }
    
    var chosenTool: Int = 0
    
    @IBAction func chooseTool(button: UIButton) {
        
        chosenTool = button.tag
        
    }
    
    var fillColor: UIColor = UIColor.blackColor()
    var strokeColor: UIColor = UIColor.blackColor()
    var strokeWidth: CGFloat = 10
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        if colorSource.isFill {
            
            fillColor = cell?.backgroundColor ?? UIColor.blackColor()
            fillStroke.backgroundColor = fillColor
            
        } else {
            
            strokeColor = cell?.backgroundColor ?? UIColor.blackColor()
            fillStroke.borderColor = strokeColor.CGColor
            fillStroke.setNeedsDisplay()
            
        }
        
        
    }

    @IBAction func strokeWidthChanged(sender: TouchSlider) {
        
       strokeWidth = sender.value
        
    }
    
    
    @IBAction func clearButton(sender: UIButton) {
        (view as? DrawView)?.lines = []
        
        view.setNeedsDisplay()
        
    }
    @IBAction func undoButton(sender: UIButton) {
        
        if (view as? DrawView)?.lines.count > 0 {(view as? DrawView)?.lines.removeLast()
        }
        view.setNeedsDisplay()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            
            switch chosenTool {
                
            case 1 :
                
                let newScribble = Scribble()
                
                newScribble.points.append(touch.locationInView(view))
                
                
                newScribble.strokeColor = strokeColor
                newScribble.fillColor = fillColor

                newScribble.strokeWidth = strokeWidth
                
                (view as? DrawView)?.lines.append(newScribble)
                
                
            case 2 :
                
                startShape(.Circle, withTouch: touch)
                
            case 3 :
                
                startShape(.Rectangle, withTouch: touch)
                
            case 4 :
                
                startShape(.Triangle, withTouch: touch)
                
            case 5 :
                
                startShape(.Diamond, withTouch: touch)
                
            default :
                
                
                let newLine = Line()
                
                newLine.start = touch.locationInView(view)
                newLine.strokeColor = strokeColor
                newLine.fillColor = fillColor

                newLine.strokeWidth = strokeWidth

                
                (view as? DrawView)?.lines.append(newLine)
                
                
            }
            
            
            view.setNeedsDisplay()
            
        }
        
    }
    
    func startShape(type: ShapeType, withTouch touch: UITouch) {
        
        let shape = Shape(type: type)
        
        shape.start = touch.locationInView(view)
        
        shape.fillColor = fillColor
        shape.strokeColor = strokeColor
        
        shape.strokeWidth = strokeWidth

        (view as? DrawView)?.lines.append(shape)
        
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            
            if let currentScribble = (view as? DrawView)?.lines.last as? Scribble {
                
                currentScribble.points.append(touch.locationInView(view))
                
                view.setNeedsDisplay()
                
            } else if let currentLine = (view as? DrawView)?.lines.last {
                
                currentLine.end = touch.locationInView(view)
                
                view.setNeedsDisplay()
                
            }
            
        }
        
    }
}

class Colors: NSObject, UICollectionViewDataSource {
    
    let fillColors = [
    
        UIColor.redColor(),
        UIColor.blackColor(),
        UIColor.cyanColor(),
        UIColor.orangeColor(),
        UIColor.greenColor()
    
    ]
    
    let strokeColors = [
    
        UIColor.magentaColor(),
        UIColor.blueColor(),
        UIColor.yellowColor(),
        UIColor.greenColor(),
        UIColor.purpleColor()
    
    ]
    
    var isFill = false
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return isFill ? fillColors.count : strokeColors.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell =
        collectionView.dequeueReusableCellWithReuseIdentifier("ColorCell", forIndexPath: indexPath)
        
        cell.backgroundColor = isFill ? fillColors[indexPath.item] : strokeColors[indexPath.item]
        
        return cell
        
    }
    
}
    
    
