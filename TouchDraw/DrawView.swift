//
//  DrawView.swift
//  TouchDraw
//
//  Created by Kelly Robinson on 9/30/15.
//  Copyright © 2015 Kelly Robinson. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var lines = [Line]()
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        UIColor.magentaColor().set()
        
        for line in lines {
            
            if let start = line.start, let end = line.end {
                
                if let fillColor = line.fillColor {
                    
                    fillColor.set()
                    
                    if let shape = line as? Shape {
                        
                        let width = end.x - start.x
                        let height = end.y - start.y
                        
                        let rect = CGRect(x: start.x, y: start.y, width: width, height: height)
                        
                        switch shape.type  ?? .Rectangle {
                            
                        case .Circle :
                            
                            CGContextFillEllipseInRect(context, rect)
                            
                        case .Triangle :
                            
                            let top = CGPoint(x: width / 2 + start.x, y: start.y)
                            let right = end
                            let left = CGPoint(x: start.x, y: end.y)
                            
                            CGContextMoveToPoint(context, top.x, top.y)
                            CGContextAddLineToPoint(context, right.x,right.y)
                            CGContextAddLineToPoint(context, left.x,left.y)
                            CGContextAddLineToPoint(context, top.x,top.y)
                            CGContextFillPath(context) // closes triangle
                            
                        case .Rectangle :
                            
                            CGContextFillRect(context, rect)
                            
                        case .Diamond :
                            
                            let top = CGPoint(x: width / 2 + start.x, y: start.y)
                            let right = CGPoint(x: end.x, y: height / 2 + start.y)
                            let left = CGPoint(x: start.x, y: height / 2 + start.y)
                            let bottom = CGPoint(x: width / 2 + start.x, y: end.y)
                            
                            
                            CGContextMoveToPoint(context, top.x, top.y)
                            CGContextAddLineToPoint(context, right.x, right.y)
                            CGContextAddLineToPoint(context, bottom.x, bottom.y)
                            CGContextAddLineToPoint(context, left.x, left.y)
                            CGContextAddLineToPoint(context, top.x, top.y)
                            
                            CGContextFillPath(context) // closes triangle
                            
                            
                            
                        }
                        
                        
                        
                    } else {
                        
                        CGContextSetLineCap(context, .Round)
                        CGContextSetLineJoin(context, .Round)
                        
                        CGContextMoveToPoint(context, start.x, start.y)
                        
                        if let scribble = line as? Scribble {
                            
                            CGContextAddLines(context, scribble.points, scribble.points.count)
                            
                        }
                        
                        CGContextAddLineToPoint(context, end.x, end.y)
                    
                        CGContextFillPath(context)
                        
                    }
                    
                }
                
                if let strokeColor = line.strokeColor {
                    
                    strokeColor.set()
                    
                    CGContextSetLineWidth(context, line.strokeWidth)
                    
                    CGContextSetLineCap(context, .Round)
                    CGContextSetLineJoin(context, .Round)
                    
                    if let shape = line as? Shape {
                        
                        let width = end.x - start.x
                        let height = end.y - start.y
                        
                        let rect = CGRect(x: start.x, y: start.y, width: width, height: height)
                        
                        switch shape.type  ?? .Rectangle {
                            
                        case .Circle :
                            
                            CGContextStrokeEllipseInRect(context, rect)
                            
                        case .Triangle :
                            
                            let top = CGPoint(x: width / 2 + start.x, y: start.y)
                            let right = end
                            let left = CGPoint(x: start.x, y: end.y)
                            
                            CGContextMoveToPoint(context, top.x, top.y)
                            CGContextAddLineToPoint(context, right.x,right.y)
                            CGContextAddLineToPoint(context, left.x,left.y)
                            CGContextAddLineToPoint(context, top.x,top.y)
                            CGContextStrokePath(context) // closes triangle
                            
                        case .Rectangle :
                            
                            CGContextStrokeRect(context, rect)
                            
                        case .Diamond :
                            
                            let top = CGPoint(x: width / 2 + start.x, y: start.y)
                            let right = CGPoint(x: end.x, y: height / 2 + start.y)
                            let left = CGPoint(x: start.x, y: height / 2 + start.y)
                            let bottom = CGPoint(x: width / 2 + start.x, y: end.y)
                            
                            
                            CGContextMoveToPoint(context, top.x, top.y)
                            CGContextAddLineToPoint(context, right.x, right.y)
                            CGContextAddLineToPoint(context, bottom.x, bottom.y)
                            CGContextAddLineToPoint(context, left.x, left.y)
                            CGContextAddLineToPoint(context, top.x, top.y)
                            
                            CGContextStrokePath(context) // closes triangle
                            
                            
                            
                        }
                        
                        
                        
                    } else {
                        
                        CGContextMoveToPoint(context, start.x, start.y)
                   
                        if let scribble = line as? Scribble {
                            
                            CGContextAddLines(context, scribble.points, scribble.points.count)
                            
                        }
                        
                        CGContextAddLineToPoint(context, end.x, end.y)
                        
                        CGContextStrokePath(context)
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    
}






class Line {
    
    var start: CGPoint?
    var end: CGPoint?
    
    var strokeColor: UIColor?
    var fillColor: UIColor?
    
    var strokeWidth: CGFloat = 0
    var fillWidth: CGFloat = 0
    
    
    
}

class Scribble: Line {
    
    var points = [CGPoint]() {
        
        didSet {
            
            start = points.first
            end = points.last
            
        }
        
    }
    
    
    
    
}

enum ShapeType {
    
    case Rectangle, Circle, Triangle, Diamond
    
}

class Shape: Line {
    
    var type: ShapeType!
    
    init(type: ShapeType) {
        
        
        self.type = type
    }
    
}
    