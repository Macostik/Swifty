//: Implementing Patterns
//: =====================

//: [Previous](@previous)

protocol Material {}
struct Wood: Material {}
struct Glass: Material {}
struct Metal: Material {}
struct Cotton: Material {}

//: Adding `init()`

protocol HouseholdThing { }
protocol Furniture: HouseholdThing {
    init() // <=====
    typealias M: Material
    typealias T: HouseholdThing
    func mainMaterial() -> M
    static func factory() -> T
}

class Chair: Furniture {
    required init() {} // <=====

    func mainMaterial() -> Wood {
        return Wood()
    }
    static func factory() -> Chair {
        return Chair()
    }
}

class Lamp: Furniture {
    required init() {} // <=====

    func mainMaterial() -> Glass {
        return Glass()
    }
    static func factory() -> Lamp {
        return Lamp()
    }
}

//: Now this works

class FurnitureMaker<C: Furniture> {
    func make() -> C {
        return C()
    }
    
    func material(furniture: C) -> C.M {
        return furniture.mainMaterial()
    }
}

//: So does all this
let chairMaker = FurnitureMaker<Chair>()
let chair1 = chairMaker.make()
let chair2 = chairMaker.make()
chairMaker.material(chair2) // returns Wood

let lampMaker = FurnitureMaker<Lamp>()
let lamp = lampMaker.make()
lampMaker.material(lamp) // returns Glass

//: Optimizing (readability) the code by creating a BetterChairMaker...

class ChairMaker: FurnitureMaker<Chair> {}

let betterChairMaker = ChairMaker()
let chair3 = betterChairMaker.make()
let chair4 = betterChairMaker.make()
betterChairMaker.material(chair4)

//: [Next](@next)
