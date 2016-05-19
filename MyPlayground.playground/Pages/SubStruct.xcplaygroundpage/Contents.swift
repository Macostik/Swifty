//: [Previous](@previous)

import Foundation

class MyClass {
    var value: Int
    
    init (value: Int) {
        self.value = value
    }
    
    private struct subStruct {
        var structValue: Int
        
        init(structValue: Int) {
            self.structValue = structValue
        }
    }
}

let myClass = MyClass(value: 50)
print (">>self - \(myClass.value)<<")
