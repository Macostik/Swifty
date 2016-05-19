//: Generic Crash Course
//: ====================

//: [Previous](@previous)

//: A method that does a run time check using `as`. As a result, the error you see is at RUN TIME, not COMPILE TIME

extension Int {
    func addOne() -> Int {
        return self + 1
    }
}

extension String {
    func addOne() -> String {
        return self + "1"
    }
}

func increment(foo: Any) -> Any {
    if let fooStr = foo as? String {
        return fooStr.addOne()
    }
    else if let fooInt = foo as? Int {
        return fooInt.addOne()
    }
    fatalError("unknown type can't addOne") // <==== Sandbox errors here -- but why??
}

increment("foo")
increment(1)

//: **This next code snippet DOES compile, but errors during run time**

increment(1.0) // <===== this is causing your error at runtime

//: [Next](@next)
