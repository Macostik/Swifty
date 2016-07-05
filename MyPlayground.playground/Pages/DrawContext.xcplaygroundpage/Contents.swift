//: [Previous](@previous)

import Foundation
import UIKit
import XCPlayground

class DrawView: UIView {
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let myShadowOffset = CGSize.zero
      
        let myContext = UIGraphicsGetCurrentContext()
        
        CGContextSaveGState(myContext);
//
        CGContextSetShadow (myContext, myShadowOffset, 5)

//        CGContextSetRGBFillColor (myContext, 1, 1, 1, 1);
//        CGContextFillRect (myContext, rect)
        
        CGContextSetShadowWithColor (myContext, myShadowOffset, 5, UIColor.redColor().CGColor)
        CGContextSetRGBFillColor (myContext, 1, 1, 1, 1);
//        CGContextFillRect (myContext, CGRectMake(10, 10, 50, 50))
        
        CGContextRestoreGState(myContext)
    }
}



let view1 = UIView(frame: CGRectMake(0, 0, 300, 300))
view1.backgroundColor = UIColor.whiteColor()

let drawView = DrawView(frame: CGRectMake(50, 50, 100, 100))
//drawView.backgroundColor = UIColor.greenColor()
view1.addSubview(drawView)
drawView.setNeedsDisplay()
XCPlaygroundPage.currentPage.liveView =  view1




          