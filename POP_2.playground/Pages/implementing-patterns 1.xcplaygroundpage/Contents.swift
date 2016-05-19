//: Implementing Patterns
//: =====================

//: [Previous](@previous)

protocol Material {}
struct Wood: Material {}
struct Glass: Material {}
struct Metal: Material {}
struct Cotton: Material {}

protocol HouseholdThing { }
protocol Furniture: HouseholdThing {
    typealias M: Material
    typealias T: HouseholdThing
    func mainMaterial() -> M
    static func factory() -> T
}

class Chair: Furniture {
    func mainMaterial() -> Wood {
        return Wood()
    }
    static func factory() -> Chair {
        return Chair()
    }
}

class Lamp: Furniture {
    func mainMaterial() -> Glass {
        return Glass()
    }
    static func factory() -> Lamp {
        return Lamp()
    }
}

//: **This next code snippet will not compile**

//: The protocol of `Furniture` does not have a public initializer

class FurnitureMaker<C: Furniture> {
    func make() -> C {
        return C()
    }
    
    func material(furniture: C) -> C.M {
        return furniture.mainMaterial()
    }
}

//: [Next](@next)
