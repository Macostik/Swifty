//: [Previous](@previous)

import Foundation

import Foundation
protocol Stringable {
    var string: String { get }
}
extension String: Stringable {
    var string: String {
        return self
    }
}
extension Dictionary where Key: Stringable {
    subscript(matching string: Stringable) -> [Value] {
        let regex = try! NSRegularExpression(pattern: string.string, options: [])
        return filter({ (key: Stringable, value: Value) -> Bool in
            let nskey = key.string as NSString
            return regex.firstMatchInString(key.string, options: [], range: NSRange(location: 0, length: nskey.length)) != nil
        }).map({ $0.1 })
    }
}

let d = [ "one": 1, "two": 2, "three": 3, "four": 4, "five": 5]
d[matching: "o"]
d[matching: "^...$"]
d[matching: "r|w"]