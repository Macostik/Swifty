//: Generic Crash Course
//: ====================

//: [Previous](@previous)

protocol CanAddOne {
    func addOne() -> Self
}

extension Int: CanAddOne {
    func addOne() -> Int {
        return self + 1
    }
}

extension String: CanAddOne {
    func addOne() -> String {
        return self + "1"
    }
}

//: Writing a compile time check that accomplishes the same end result


func incrementBetter<T: CanAddOne>(foo: T) -> T {
    return foo.addOne()
}

incrementBetter("foo")
incrementBetter(1)

//: **This next code snippet will not compile**

//: This produces a nice compile time error telling you this is wrong

incrementBetter(1.0)

//: [Next](@next)
