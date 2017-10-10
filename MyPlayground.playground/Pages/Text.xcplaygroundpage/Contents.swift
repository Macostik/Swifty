//: [Previous](@previous)

import Foundation
import UIKit

let a = false
let b = true
let c = false

let z = a && b || c

let s = "Yura"
let data = s.data(using: .utf8)
let s1 = String(data: data!, encoding: .utf8)

let string = "This_ is simple. string"
if let startIndex = string.range(of: "_", options: .caseInsensitive)?.lowerBound {
    if let endIndex = string.range(of: ".", options: .caseInsensitive)?.upperBound, endIndex > startIndex {
        let subString = string[Range(startIndex ..< endIndex)]
    }
}

let label = UILabel()
label.font = UIFont(name: "AvenirNext-Medium", size: 12.0)






