//: [Previous](@previous)

import Foundation
import UIKit

class FirstClass {
    let className = "FirstClass"
    lazy var description: String = {
      return "Class is " + self.className
    }()
    
    deinit {
        print (__FUNCTION__)
        print (">>self - deinit happened<<")
    }
}

var firstClass: FirstClass? = FirstClass()
firstClass?.description
firstClass = nil


