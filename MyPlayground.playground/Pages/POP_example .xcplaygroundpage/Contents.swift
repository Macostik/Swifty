//: [Previous](@previous)

import Foundation
import UIKit

protocol Unique {
    var id: String? { get set }
}

class Song: NSObject, Unique {
    var id: String?
}

extension Unique where Self: NSObject {
    init(id: String) {
        print (">>self - init <<")
        self.init()
        self.id = id
    }
}

let s = Song(id: "abcd12345")
