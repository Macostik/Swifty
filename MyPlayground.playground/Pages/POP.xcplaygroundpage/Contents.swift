//: [Previous](@previous)

import Foundation
import UIKit
import XCPlayground

protocol Vehicle {
    var speed: UInt { get }
    var wheel: UInt { get }
    var description: String { get }
   
}

struct Car: Vehicle {
    
    var speed: UInt
    var wheel: UInt
    var description: String { return "This is car" }
    
    init (speed: UInt, wheel: UInt) {
        self.speed = speed
        self.wheel = wheel
    }
}

struct Bicycle: Vehicle {
    var speed: UInt
    var wheel: UInt
    var description: String { return "This is bicycle" }
    
    init (speed: UInt, wheel: UInt) {
        self.speed = speed
        self.wheel = wheel
    }
}

extension Vehicle {
    func compareHowFaster (vehicle: Self) -> Bool {
        return self.speed > vehicle.speed
    }
}

let car1 = Car(speed: 120, wheel: 4)
let car2 = Car(speed: 130, wheel: 4)
let bicycle = Bicycle(speed: 20, wheel: 2)

car1.compareHowFaster(car2)

protocol Styled {
    func updateStyles()
}

protocol BackgroundColor : Styled {
    var color: UIColor { get }
}

protocol FontWeight : Styled {
    var size: CGFloat { get }
    var bold: Bool { get }
}

protocol BackgroundColor_Purple : BackgroundColor {}
extension BackgroundColor_Purple {
    var color: UIColor { return UIColor.purpleColor() }
}

protocol BackgroundColor_Blue : BackgroundColor {}
extension BackgroundColor_Blue {
    var color: UIColor { return UIColor.blueColor() }
}

protocol FontWeight_H1 : FontWeight {}
extension FontWeight_H1 {
    var size: CGFloat { return 24.0 }
    var bold: Bool { return true }
}

extension UILabel : Styled {
    func updateStyles() {
        if let s = self as? BackgroundColor {
            self.backgroundColor = s.color
            print(s.color)
            textColor = .redColor()
        }
        if let s = self as? FontWeight {
            font = (s.bold) ? UIFont.boldSystemFontOfSize(s.size) : UIFont.systemFontOfSize(s.size)
        }
    }
}

class MyLabel: UILabel, BackgroundColor_Blue, FontWeight_H1 {}

let l = MyLabel(frame: CGRectMake(0, 0, 150, 30))
l.text = "This is label"
l.updateStyles()
XCPlaygroundPage.currentPage.liveView =  l
