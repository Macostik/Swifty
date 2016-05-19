
import Foundation
import UIKit

let someOptional: Int? = 42

if case .Some(let x) = someOptional {
    print(x)
}

if case let x? = someOptional {
    print(x)
}

let myOptional : String? = "Hello"
switch myOptional {
case let .Some(value):
    print(value)
case .None:
    break
}

let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]
for case let number? in arrayOfOptionalInts {
    print("Found a \(number)")
}
// Found a 2
// Found a 3
// Found a 5

let otherItems : [Any] = ["Hello", 10, (1, 2), UIButton(), 3.14159]

for item in otherItems {
    switch item {
    case 10 as Int:
        print("An integer with value 10")
    case let message as String:
        print("You're message is: \(message)")
    case let (firstValue, secondValue) as (Int, Int):
        print("A tuple containing two Int elements: (\(firstValue), \(secondValue))")
    default:
        print("Unknown")
    }
}

let items = [NSString(string:"Hello"), UILabel(), UITextField()]

for item in items {
    switch item {
    case is NSString:
        print("NSString")
    case is UIControl:
        print("UIControl")
    case is UIView:
        print("UIView")
    default:
        print("Unknown")
    }
}