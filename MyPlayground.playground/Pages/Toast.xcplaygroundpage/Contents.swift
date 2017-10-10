//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import PlaygroundSupport

struct ErrorOptions {
    let message: String
    let tintColor: UIColor
    
    init(message: String = "Error!", tintColor: UIColor = UIColor.clear) {
        self.message = message
        self.tintColor = tintColor
    }
}

typealias ErrorRenderingCompletionBlock = ()->()

protocol ErrorPopoverRenderer {
    func presentError(errorOptions: ErrorOptions)
    func presentError(errorOptions: ErrorOptions, completion : ErrorRenderingCompletionBlock?)
}

extension ErrorPopoverRenderer {
    func presentError(errorOptions: ErrorOptions = ErrorOptions()) {
        self.presentError(errorOptions: errorOptions, completion: nil)
    }
}

extension ErrorPopoverRenderer where Self: UIViewController {
    
    func presentError(errorOptions: ErrorOptions = ErrorOptions(), completion : ErrorRenderingCompletionBlock?) {
        let errorBanner = UILabel()
        errorBanner.backgroundColor = errorOptions.tintColor
        errorBanner.textAlignment = .center
        errorBanner.adjustsFontSizeToFitWidth = true
        errorBanner.font = UIFont.systemFont(ofSize: 20.0)
        errorBanner.textColor = UIColor.white
        errorBanner.text = errorOptions.message
        let height : CGFloat = 50
        errorBanner.frame = CGRect(x: 0, y: -height, width: self.view.bounds.width, height: height)
        self.view.addSubview(errorBanner)
        UIView.animate(withDuration: 0.8, animations: { () -> Void in
            errorBanner.transform = CGAffineTransform.init(translationX: 0, y: height)
            }) { (done1) -> Void in
                UIView.animate(withDuration:0.8, delay: 0.5, options: .curveEaseOut, animations: { () -> Void in
                    errorBanner.transform = .identity
                    }, completion: { (done2) -> Void in
                        errorBanner.removeFromSuperview()
                        if let completionBlock = completion {
                            completionBlock()
                        }
                })
        }
    }
}

extension ErrorPopoverRenderer where Self: UIView {
    
    func presentError(errorOptions: ErrorOptions = ErrorOptions(), completion : ErrorRenderingCompletionBlock?) {
        let errorBanner = UILabel()
        errorBanner.backgroundColor = errorOptions.tintColor
        errorBanner.textAlignment = .center
        errorBanner.adjustsFontSizeToFitWidth = true
        errorBanner.font = UIFont.systemFont(ofSize: 20.0)
        errorBanner.text = "!"
        errorBanner.textColor = UIColor.red
        let size : CGFloat = 32.0
        let padding : CGFloat = 8.0
        errorBanner.layer.cornerRadius = size/2.0
        errorBanner.layer.borderColor = UIColor.red.cgColor
        errorBanner.layer.borderWidth = 1.0
        errorBanner.frame = CGRect(x:  self.bounds.width - size - padding, y: padding, width: size, height: size)
        self.addSubview(errorBanner)
        if let completionBlock = completion {
            completionBlock()
        }
    }
}

extension UIViewController : ErrorPopoverRenderer {}
extension UIView : ErrorPopoverRenderer {}


let viewController = UIViewController()
viewController.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
viewController.view.backgroundColor = UIColor.white
PlaygroundPage.current.liveView =  viewController.view

let errorOptions = ErrorOptions(message: "OMG an error!", tintColor: UIColor.red)
viewController.presentError(errorOptions: errorOptions) { () -> () in
    viewController.view.presentError()
}
