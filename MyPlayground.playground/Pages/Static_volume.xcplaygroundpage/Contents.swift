//: [Previous](@previous)

import Foundation

class SomeStatic {
    static var foo: String = "" {
        willSet {
            print (">>self - \(newValue)<<")
        }
    }
    
    deinit {
        print (">>self - deinit was happened<<")
    }
}

print (">>self - \(SomeStatic.foo)<<")
var someClass: SomeStatic? = SomeStatic()
SomeStatic.foo = "String"
print (">>self - \(SomeStatic.foo)<<")
someClass = nil
print (">>self - \(SomeStatic.foo)<<")