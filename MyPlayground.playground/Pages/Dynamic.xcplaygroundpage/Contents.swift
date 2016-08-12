//: [Previous](@previous)

import Foundation

class A {
    var aProperty: [Int]?
    func doSomething() { print (">>self - class A is invoked doSomething <<") }
    dynamic func doSomethingElse() { print (">>self - class A is invoked doSomethingElse <<") }
}

class B : A {
    private var _aProperty:[Int]?
    override var aProperty:[Int]? {
        get { return _aProperty }
        set { self.aProperty = newValue }
    }
    
    override func doSomething() { print (">>self - class A is invoked doSomething <<") }
}

func usingAnA(a: A) {
    a.doSomething()
    a.aProperty = [1]
}
