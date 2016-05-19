//: [Previous](@previous)

import Foundation

func typeName(some: Any) -> String {
    return (some is Any.Type) ? "\(some)" : "\(some.dynamicType)"
}

/// Cast the argument to the infered function return type.
func autocast<T>(x: Any) -> T {
    return x as! T
}

protocol Foo {
    static func foo() -> Self
}

class Vehicle: Foo {
    class func foo() -> Self {
        return autocast(Vehicle())
    }
}

class Tractor: Vehicle {
    override class func foo() -> Self {
        return autocast(Tractor())
    }
}

let vehicle = Vehicle.foo()
let tractor = Tractor.foo()

print(typeName(vehicle)) // Vehicle
print(typeName(tractor)) // Tractor
