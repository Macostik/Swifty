//: A Typealias as a Return Type
//: ============================

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

//: Changing `C: Chair` => `C: Furniture`
class FurnitureInspector<C: Furniture>: Inspector<Pet> {
    //: Changing Wood => C.M
    func getMaterials(thing: C) -> C.M {
        return thing.mainMaterial()
    }
}

//: These will now work since the return type of `thing.mainMaterial()` is the same as `C.M`

let inspector2 = FurnitureInspector<Chair>()
inspector2.getMaterials(Chair())

let inspector3 = FurnitureInspector<Lamp>()
inspector3.getMaterials(Lamp())

//: [Next](@next)
