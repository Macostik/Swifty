//: [Previous](@previous)

import Foundation
import UIKit

let a = false
let b = true
let c = false

let z = a && b || c

let s = "Yura"
let data = s.dataUsingEncoding(NSUTF8StringEncoding)
let s1 = String(data: data!, encoding: NSUTF8StringEncoding)

let string = "This_ is simple. string"
if let startIndex = string.rangeOfString("_", options: .CaseInsensitiveSearch, range: nil, locale: nil)?.startIndex {
    if let endIndex = string.rangeOfString(".", options: .CaseInsensitiveSearch, range: nil, locale: nil)?.startIndex where endIndex > startIndex {
        let subString = string[Range(startIndex ..< endIndex)]
    }
}

let label = UILabel()
label.font = UIFont(name: "AvenirNext-Medium", size: 12.0)







