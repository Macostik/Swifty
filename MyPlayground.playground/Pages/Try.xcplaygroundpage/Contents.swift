//: [Previous](@previous)

import Foundation

enum DivisionError: ErrorType {
    case ByZero
}

func divide(dividend: Float, by divisor: Float) -> Float {
//    guard divisor != 0.0 else {
//        throw DivisionError.ByZero
//    }
    return dividend / divisor
}

func throwsFunc(operation:()  -> Float ) -> Float {
    return operation()
}


//do {
//    
//} catch DivisionError.ByZero {
//    print (">>self - can't divide)<<")
//}

let d = divide


//throwsFunc(d(4, by: 2))


enum NumberError:ErrorType {
    case ExceededInt32Max
}

func functionWithCallback(callback:(Int) throws -> Int) rethrows {
    try callback(Int(Int32.max)+1)
}

do {
    try functionWithCallback({v in if v <= Int(Int32.max) { return v }; throw NumberError.ExceededInt32Max})
} catch NumberError.ExceededInt32Max {
    "Error: exceeds Int32 maximum"
} catch {
}