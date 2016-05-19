//: [Previous](@previous)

import Foundation
import UIKit
import XCPlayground

 XCPSetExecutionShouldContinueIndefinitely(true)

class CircularLoaderView: UIView {
    
    let circlePathLayer = CAShapeLayer()
    let circleRadius: CGFloat = 20.0
    
    var progress: CGFloat {
        get {
            return circlePathLayer.strokeEnd
        }
        set {
            print("New value \(newValue)")
            if (newValue > 1) {
                circlePathLayer.strokeEnd = 1
            } else if (newValue < 0) {
                circlePathLayer.strokeEnd = 0
            } else {
                circlePathLayer.strokeEnd = newValue
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        circlePathLayer.frame = bounds
        circlePathLayer.lineWidth = 2
        circlePathLayer.fillColor = UIColor.clearColor().CGColor
        circlePathLayer.strokeColor = UIColor.redColor().CGColor
        layer.addSublayer(circlePathLayer)
        backgroundColor = UIColor.whiteColor()
        progress = 0
    }
    
    func circleFrame() -> CGRect {
        var circleFrame = CGRect(x: 0, y: 0, width: 2*circleRadius, height: 2*circleRadius)
        circleFrame.origin.x = CGRectGetMidX(circlePathLayer.bounds) - CGRectGetMidX(circleFrame)
        circleFrame.origin.y = CGRectGetMidY(circlePathLayer.bounds) - CGRectGetMidY(circleFrame)
        return circleFrame
    }
    
    func circlePath() -> UIBezierPath {
        return UIBezierPath(ovalInRect: circleFrame())
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circlePathLayer.frame = bounds
        circlePathLayer.path = circlePath().CGPath
    }
    
    func reveal() {
        backgroundColor = UIColor.clearColor()
        progress = 1
        circlePathLayer.removeAnimationForKey("strokeEnd")
        circlePathLayer.removeFromSuperlayer()
        superview?.layer.mask = circlePathLayer
        
        let center = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMidY(bounds))
        let finalRadius = sqrt((center.x*center.x) + (center.y*center.y))
        let radiusInset = finalRadius - circleRadius
        let outerRect = CGRectInset(circleFrame(), -radiusInset, -radiusInset)
        let toPath = UIBezierPath(ovalInRect: outerRect).CGPath
        
        //2
        let fromPath = circlePathLayer.path
        let fromLineWidth = circlePathLayer.lineWidth
        
        //3
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        circlePathLayer.lineWidth = 2*finalRadius
        circlePathLayer.path = toPath
        CATransaction.commit()
        
        //4
        let lineWidthAnimation = CABasicAnimation(keyPath: "lineWidth")
        lineWidthAnimation.fromValue = fromLineWidth
        lineWidthAnimation.toValue = 2*finalRadius
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = fromPath
        pathAnimation.toValue = toPath
        
        //5
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 1
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.animations = [pathAnimation, lineWidthAnimation]
        groupAnimation.delegate = self
        circlePathLayer.addAnimation(groupAnimation, forKey: "strokeWidth")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        superview?.layer.mask = nil
    }
}
  
class CustomImageView: UIImageView, NSURLSessionTaskDelegate, NSURLSessionDelegate,NSURLSessionDownloadDelegate {
    
    let progressIndicatorView = CircularLoaderView(frame: CGRectZero)
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.progressIndicatorView)
        progressIndicatorView.frame = bounds
        progressIndicatorView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration() , delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        let url = NSURL(string: "https://placeimg.com/1136/640/any")!
        let task = defaultSession.downloadTaskWithURL(url)
        task.resume()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print (">>self - \(CGFloat(totalBytesExpectedToWrite)/CGFloat(totalBytesWritten))<<")
        progressIndicatorView.progress = CGFloat(totalBytesExpectedToWrite)/CGFloat(totalBytesWritten)
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        print (">>self - FinishDownloading<<")
        progressIndicatorView.reveal()
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
            print (">>self - didResumeAtOffset<<")
    }
}

let view = UIView(frame: CGRectMake(0, 0, 300, 300))
view.backgroundColor = UIColor.whiteColor()
let image = CustomImageView(frame:CGRectMake(20, 20, 150, 150))
image.backgroundColor = UIColor.redColor()
view.addSubview(image)
XCPlaygroundPage.currentPage.liveView = view
