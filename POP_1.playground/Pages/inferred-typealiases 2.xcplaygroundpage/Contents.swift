//: Inferred Typealiases
//: ===================

//: [Previous](@previous)

//: `mainMaterial()` and `secondaryMaterial()` must return the same types
protocol Furniture {
    typealias M
    func mainMaterial() -> M // <====
    func secondaryMaterial() -> M // <====
}

struct Chair: Furniture {
    func mainMaterial() -> String {
        return "Wood"
    }
    func secondaryMaterial() -> String {
        return "More wood"
    }
}

struct Lamp: Furniture {
    func mainMaterial() -> Bool {
        return true
    }
    func secondaryMaterial() -> Bool {
        return true
    }
}

//: **This next code snippet will not compile**

// Error: Type `Stool` does not conform to protocol `Furniture`
struct Stool: Furniture {
    func mainMaterial() -> String {
        return "Wood"
    }
    func secondaryMaterial() -> Bool {
        return false
    }
}

//: [Next](@next)
