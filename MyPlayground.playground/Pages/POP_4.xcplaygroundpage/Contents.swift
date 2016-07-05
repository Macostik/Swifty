//: [Previous](@previous)

import Foundation

protocol Bird: BooleanType {
    var name: String { get }
    var canFly: Bool { get }
}

protocol Flyable {
    var airspeedVelocity: Double { get }
}

struct FlappyBird: Bird, Flyable {
    let name: String
    let flappyAmplitude: Double
    let flappyFrequency: Double
    let canFly = true
    
    var airspeedVelocity: Double {
        return 3 * flappyFrequency * flappyAmplitude
    }
}

struct Penguin: Bird {
    let name: String
    let canFly = false
}

struct SwiftBird: Bird, Flyable {
    var name: String { return "Swift \(version)" }
    let version: Double
    let canFly = true
    
    var airspeedVelocity: Double { return 2000.0 }
}

extension Bird where Self: Flyable {
    var canFly: Bool { return true }
}

enum UnladenSwallow: String, Bird, Flyable {
    case African
    case European
    case Unknown
    
    var name: String { return rawValue }
    
    var airspeedVelocity: Double {
        switch self {
        case .African:
            return 10.0
        case .European:
            return 9.9
        case .Unknown:
            fatalError("You are thrown from the bridge of death!")
        }
    }
}

extension BooleanType where Self: Bird {
    var boolValue: Bool {
        return self.canFly
    }
}

func checkBird() {
    if UnladenSwallow.African {
        print("I can fly!")
        print (">>self - \(UnladenSwallow.African.name)<<")
    } else {
        print("Guess I’ll just sit here :[")
    }
}

checkBird()

