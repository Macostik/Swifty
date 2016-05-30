//: [Previous](@previous)

import Foundation
import UIKit

var str: String? = "Hello, playground"
let s = str.map { $0 + "this is Yura"}
print (">>self - \(s)<<")

func flatten<A>(x: A??) -> A? {
    if let y = x { return y }
    return nil
}

infix operator >>>= {}
func >>>= <A, B> (optional: A?, f: A -> B?) -> B? {
    return flatten(optional.map(f))
}

func mapReflection<T, U>(x: T, @noescape transform: (String, MirrorType) -> U) -> [U] {
    var result: [U] = []
    let mirror = reflect(x)
    for i in 0..<mirror.count {
        result.append(transform(mirror[i]))
    }
    return result
}

func _flatten(str: String) {
    guard let x = flatten(str) else {
        print (">>self - guard <<")
        return
    }
    let label = UITextView()
    label.text = x
    print (">>self - \(label) <<")
}

_flatten(str!)

protocol JSONRepresentable {
    var JSONRepresentation: AnyObject { get }
}

protocol JSONSerializable: JSONRepresentable {
}

extension JSONSerializable {
    var JSONRepresentation: AnyObject {
        var representation = [String: AnyObject]()
        
        for case let (label?, value) in Mirror(reflecting: self).children {
            switch value {
            case let value as JSONRepresentable:
                representation[label] = value.JSONRepresentation
                
            case let value as NSObject:
                representation[label] = value
                
            default:
                break
            }
        }
        
        return representation
    }
}

extension JSONSerializable {
    func toJSON() -> String? {
        let representation = JSONRepresentation
        
        guard NSJSONSerialization.isValidJSONObject(representation) else {
            return nil
        }
        
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(representation, options: [])
            return String(data: data, encoding: NSUTF8StringEncoding)
        } catch {
            return nil
        }
    }
}

struct Owner: JSONSerializable {
    var name: String
}

struct Car: JSONSerializable {
    var owner: Owner
    var manufacturer: String
    var model: String
    var mileage: Float
}

let car = Car(manufacturer: "Tesla", model: "Model T", mileage: 1234.56, owner: Owner(name: "Emil"))

if let json = car.toJSON() {
    print(json)
}

extension NSDate: JSONRepresentable {
    var JSONRepresentation: AnyObject {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        return formatter.stringFromDate(self)
    }
}

struct Event: JSONSerializable {
    var name: String
    var timestamp: NSDate
}

let event = Event(name: "Something happened", timestamp: NSDate())

if let json = event.toJSON() {
    print(json)
}
