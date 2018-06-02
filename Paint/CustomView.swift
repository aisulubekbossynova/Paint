//
//  CustomView.swift
//  Paint
//
//Created by Macbook on 16.02.18.
//  Copyright © 2018 SDU. All rights reserved.
//

import UIKit

class CustomView: UIView {
    var switcherValue: Bool = false
    var vc : ViewController!
    var identifier: String?
    var color = 0
    var shapes : [(my_path: UIBezierPath,isFilled: Bool, colorIndex: Int)] = Array()
    var initialPoint: CGPoint?
    var initPoint: CGPoint?
    var endPoint: CGPoint?
    var animatePoint: CGPoint?
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    
    let colors: [(CGFloat, CGFloat, CGFloat)] = [(255,0,0),(0,255,0),(0,0,255),(255,255,0)
    ]
    
    override func draw(_ rect: CGRect) {
         //if(endPoint != nil){
        for shape in shapes{
            if shape.isFilled{
                (red, green, blue) = colors[shape.colorIndex]
                UIColor(red: red, green: green, blue: blue, alpha: 1).set()
                shape.my_path.lineWidth = 2.0
                shape.my_path.fill()
                shape.my_path.stroke()
            } else {
                (red, green, blue) = colors[shape.colorIndex]
                UIColor(red: red, green: green, blue: blue, alpha: 1).set()
                shape.my_path.lineWidth = 2.0
                shape.my_path.stroke()
            }
        }
    }
  //  }
    func drawLine(_ firstPoint: CGPoint, _ secondPoint: CGPoint) {
        let line = UIBezierPath()
        line.move(to: initialPoint!)
        line.addLine(to: endPoint!)
        
        shapes.append((my_path: line, isFilled: switcherValue, colorIndex: color))
        self.setNeedsDisplay()
        
    }
    
    func drawCircle(_ firstPoint: CGPoint, _ secondPoint: CGPoint) {
        let circleCenter = CGPoint(x: (firstPoint.x + secondPoint.x)/2, y: (firstPoint.y + secondPoint.y)/2)
        
        let circleRadius : CGFloat = sqrt((secondPoint.x - firstPoint.x)*(secondPoint.x - firstPoint.x) + (secondPoint.y - firstPoint.y)*(secondPoint.y - firstPoint.y))/2
        let circle = UIBezierPath(arcCenter: circleCenter, radius: circleRadius, startAngle: 0.0, endAngle: CGFloat(2*Double.pi), clockwise: false)
        
        shapes.append((my_path: circle, isFilled: switcherValue, colorIndex: color))
        
        self.setNeedsDisplay()
        
    }
    
    func drawRectangle(_ firstPoint: CGPoint, _ secondPoint: CGPoint){
        
        let originPoint = CGPoint(x : firstPoint.x, y : firstPoint.y)
        let rectSize = CGSize(width: (secondPoint.x - firstPoint.x), height: (secondPoint.y - firstPoint.y))
        let aRectangle = CGRect(origin: originPoint, size: rectSize)
        let rectangle = UIBezierPath(rect: aRectangle)
        
        shapes.append((my_path: rectangle, isFilled: switcherValue, colorIndex: color))
        self.setNeedsDisplay()
        
    }
    
    func drawTriangle(_ firstPoint: CGPoint, _ secondPoint: CGPoint){
        let triangle = UIBezierPath()
        triangle.move(to: CGPoint(x: firstPoint.x, y: firstPoint.y))
        triangle.addLine(to: CGPoint(x: firstPoint.x, y: secondPoint.y))
        triangle.addLine(to: CGPoint(x: secondPoint.x, y: secondPoint.y))
        triangle.close()
        
        shapes.append((my_path: triangle, isFilled: switcherValue, colorIndex: color))
        
        self.setNeedsDisplay()
        
    }
    
    func drawAnimatedWithPen(_ firstPoint: CGPoint, _ secondPoint: CGPoint) {
        
        
        let line = UIBezierPath()
        line.move(to: firstPoint)
        line.addLine(to: secondPoint)
        
        shapes.append((my_path: line, isFilled: switcherValue, colorIndex: color))
        self.setNeedsDisplay()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        initialPoint = touches.first?.location(in: self)
        initPoint = touches.first?.location(in: self)
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        endPoint = touches.first?.location(in: self)
        
        switch identifier {
        case "line"?:
            drawLine(initialPoint!, endPoint!)
        case "circle"?:
            drawCircle(initialPoint!, endPoint!)
        case "rectangle"?:
            drawRectangle(initialPoint!, endPoint!)
        case "triangle"?:
            drawTriangle(initialPoint!, endPoint!)
        default:
            break
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        animatePoint = touches.first?.location(in: self)
        if identifier == "pen"{
            drawAnimatedWithPen(initPoint!, animatePoint!)
            initPoint = animatePoint
        }
    }
    
    
}
