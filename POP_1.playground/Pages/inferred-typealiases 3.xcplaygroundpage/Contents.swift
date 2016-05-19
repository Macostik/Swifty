//: Inferred Typealiases
//: ===================

//: [Previous](@previous)

protocol Material {}
struct Wood: Material {}
struct Glass: Material {}
struct Metal: Material {}
struct Cotton: Material {}

//: `mainMaterial()` and `secondaryMaterial()` may return _different_ types now

protocol Furniture {
    typealias M: Material
    typealias M2: Material
    func mainMaterial() -> M // <====
    func secondaryMaterial() -> M2 // <====
}

struct Chair: Furniture {
    func mainMaterial() -> Wood {
        return Wood()
    }
    func secondaryMaterial() -> Cotton {
        return Cotton()
    }
}

struct Lamp: Furniture {
    func mainMaterial() -> Glass {
        return Glass()
    }
    func secondaryMaterial() -> Metal {
        return Metal()
    }
}


//: [Next](@next)
