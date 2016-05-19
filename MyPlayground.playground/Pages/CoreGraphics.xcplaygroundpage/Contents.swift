//: [Previous](@previous)

import Foundation
import UIKit
import XCPlayground

class BlurView: UIView {
    lazy var gradientView: GradientView = {
        let clearView = GradientView(frame: CGRectMake(50, 50, 50, 200))
            clearView.backgroundColor = UIColor.clearColor()
        
            return clearView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(gradientView)
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(flipGradientView), userInfo: nil, repeats: true)
        UIView.animateWithDuration(5, delay: 0, options: [.Repeat, .Autoreverse], animations: {
            self.gradientView.transform = CGAffineTransformMakeTranslation(150, 0)
            self.gradientView.locations = self.gradientView.locations[0] == 1 ? [1, 0.2] : [0.2, 1]
            }, completion: nil)
    }
    
    func flipGradientView() {
        print (">>self - <<")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(ctx, UIColor.blueColor().colorWithAlphaComponent(0.7).CGColor)
        CGContextFillRect (ctx, rect)
        CGContextClearRect(ctx, CGRectMake(50, 50, 200, 200))
    }
}

class GradientView: UIView {
    
    var locations:[CGFloat] = [1, 0.2]
    
    override func drawRect(rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let startColor = UIColor.greenColor();
        let startColorComponents = CGColorGetComponents(startColor.CGColor)
        let endColor = UIColor.clearColor();
        let endColorComponents = CGColorGetComponents(endColor.CGColor)
        let colorComponents
            = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3],
               endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
        
        let gradient = CGGradientCreateWithColorComponents(colorSpace,colorComponents,locations,2)
        
        let startPoint = CGPointMake(0, frame.height)
        let endPoint = CGPointMake(frame.width, frame.height)
        CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, CGGradientDrawingOptions.DrawsBeforeStartLocation)
    }
}




let viewController = UIViewController()
viewController.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
let imageView = UIImageView(frame: viewController.view.bounds)
imageView.image = UIImage(named: "image.jpg")
viewController.view.addSubview(imageView)
let clearView = BlurView(frame: CGRectInset(viewController.view.frame, 20, 20))
clearView.backgroundColor = UIColor.clearColor()
viewController.view.addSubview(clearView)
XCPlaygroundPage.currentPage.liveView =  viewController.view

