//: Typealias for Self - limitations with structs
//: =============================================

//: [Previous](@previous)

protocol Material {}
struct Wood: Material {}
struct Glass: Material {}
struct Metal: Material {}
struct Cotton: Material {}

//: Alternate method for creating a factory -- we changed `factory()` to return `Self` instead of `T`

protocol Furniture {
    typealias M: Material
    typealias M2: Material
    
    func mainMaterial() -> M
    func secondaryMaterial() -> M2
    static func factory() -> Self // <=====
}

//: still works

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

//: **This next code snippet will not compile -- which is good!**

//: Notice here that `Chair` can not be the return type for `factory()`. Change `Chair` => `Lamp` to fix this error

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
