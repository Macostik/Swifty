//: [Previous](@previous)

import Foundation
import UIKit

enum LazyEnum<T> {
    case noValue(() -> T)
    case value(T)
}

class LazyClass<T> {
    init (completion:() -> T) {
        _value = .noValue(completion)
    }
    
    private var _value: LazyEnum<T>
    private let _queue = dispatch_queue_create(
        "LazyBox._value", DISPATCH_QUEUE_SERIAL)
    
    var value: T {
        var returnValue: T? = nil
        dispatch_sync(_queue) {
            switch self._value {
            case .noValue(let completion):
                let result = completion()
                print (">>self - \(result)<<")
                self._value = .value(result)
                returnValue = result
            case .value(let result):
                returnValue = result
            }
        }
        assert(returnValue != nil)
        return returnValue!
    }
}

var counter = 0
let lazyValue = LazyClass<Int> {
    counter += 1;
    return counter * 20
}
lazyValue.value

assert(lazyValue.value == 20)
assert(lazyValue.value == 20)
assert(counter == 1)
