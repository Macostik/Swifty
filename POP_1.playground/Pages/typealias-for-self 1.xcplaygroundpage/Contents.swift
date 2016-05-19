//: Typealias for Self - Unintended Types
//: =======================================

//: [Previous](@previous)

protocol Material {}
struct Wood: Material {}
struct Glass: Material {}
struct Metal: Material {}
struct Cotton: Material {}

protocol HouseholdThing { }
protocol Furniture: HouseholdThing {
    typealias M: Material
    typealias M2: Material
    typealias T: HouseholdThing
    
    func mainMaterial() -> M
    func secondaryMaterial() -> M2
    static func factory() -> T
}

struct Chair: Furniture {
    func mainMaterial() -> Wood {
        return Wood()
    }
    func secondaryMaterial() -> Cotton {
        return Cotton()
    }
    static func factory() -> Chair {
        return Chair()
    }
}

//: Notice the unintended return type of `factory()`

struct Lamp: Furniture {
    func mainMaterial() -> Glass {
        return Glass()
    }
    func secondaryMaterial() -> Metal {
        return Metal()
    }
    static func factory() -> Chair {
        return Chair() // <== this is not what we intended!
    }
}

//: [Next](@next)
