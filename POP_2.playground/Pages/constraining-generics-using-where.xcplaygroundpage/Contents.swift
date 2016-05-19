//: Constraining Generics using WHERE
//: =================================

//: [Previous](@previous)

protocol Material {}
struct Wood: Material {}
struct Glass: Material {}
struct Metal: Material {}
struct Cotton: Material {}

protocol HouseholdThing { }
protocol Furniture: HouseholdThing {
    typealias A: Any
    func label() -> A
}

class Chair: Furniture {
    func label() -> Int {
        return 0
    }
}

class Lamp: Furniture {
    func label() -> String {
        return ""
    }
}

class FurnitureInspector<C: Furniture where C.A == Int> {
    func calculateLabel(thing: C) -> C.A {
        return thing.label()
    }
}

let inspector1 = FurnitureInspector<Chair>()

//: This now returns `C.A` (which is constrained to an `Int`)

inspector1.calculateLabel(Chair())

//: **This next code snippet will not compile**

//: `Lamp.label()` is not an `Int`

let inspector2 = FurnitureInspector<Lamp>()

//: [Next](@next)
