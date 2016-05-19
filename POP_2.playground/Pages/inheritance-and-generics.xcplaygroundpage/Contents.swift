//: Inheritance for Generics
//: ========================

//: [Previous](@previous)

//: You can safely ignore the following code block -- nothing has changed from previous examples

protocol Material {}
struct Wood: Material {}
struct Glass: Material {}

protocol HouseholdThing { }
protocol Furniture: HouseholdThing {
    typealias M: Material
    func mainMaterial() -> M
}

class Chair: Furniture {
    func mainMaterial() -> Wood {
        return Wood()
    }
}

class Lamp: Furniture {
    func mainMaterial() -> Glass {
        return Glass()
    }
}

//: New code changes

class Pet {}
class Inspector<P> {}

let inspector = Inspector<Pet>()

class FurnitureInspector<C: Chair>: Inspector<C> {
    func getMaterials(thing: C) -> Wood {
        return thing.mainMaterial()
    }
}

//: This code works; <Chair> is assumed

let inspector2 = FurnitureInspector()
inspector2.getMaterials(Chair())


//: **This next code snippet will not compile**

//: `getMaterials` expects `Wood` to return, but `Lamp.mainMaterial()` will return `Glass`

let inspector3 = FurnitureInspector()
inspector3.getMaterials(Lamp())

//: [Next](@next)
