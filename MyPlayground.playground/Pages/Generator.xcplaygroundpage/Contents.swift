//: [Previous](@previous)

import Foundation
import UIKit

struct Family: SequenceType {
    var name = "Smith"
    var father = "Bob"
    var mother = "Alice"
    var child = "Carol"
    
    typealias Generator = AnyGenerator<String>
    
    func generate() -> Generator {
        var i = 0
        return AnyGenerator {
            switch i++ {
            case 0: return "\(self.father) \(self.name)"
            case 1: return "\(self.mother) \(self.name)"
            case 2: return "\(self.child) \(self.name)"
            default: return nil
            }
        }
    }
}

extension GeneratorType {
    mutating func dropIf(predicate: (Self.Element) -> Bool) -> [Self.Element] {
        var result = [Element]()
        while true {
            if let item = next() {
                if !predicate(item) { result.append(item) }
            } else {
                return result
            }
        }
    }
}

let f = Family()

for x in f {
    print(x)
}

var g = f.generate()
let withoutBob = g.dropIf { p in p.hasPrefix("Bob") }

print (">>self - \(withoutBob)<<")


