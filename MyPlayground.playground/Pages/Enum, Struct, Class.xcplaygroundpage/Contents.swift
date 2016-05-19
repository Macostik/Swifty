
// Specification for HTML colors http://www.w3.org/TR/css3-color/
import Foundation

extension CSSColor {
    // Nested type
    // Enum can be used to define constants
    enum ColorName : String {
        case Black, Silver, Gray, White, Maroon, Red, Purple, Fuchsia, Green, Lime, Olive, Yellow, Navy, Blue, Teal, Aqua
    }
}

enum CSSColor {
    // Enum can contain associated values for each case.
    case Named(ColorName)
    case RGB(UInt8,UInt8,UInt8)
}

// Enums can adopt protocols, have methods and computed properties

extension CSSColor: CustomStringConvertible {
    var description: String {
        switch self {
        case .Named(let colorName):
            return colorName.rawValue
        case .RGB(let red, let green, let blue):
            return String(format: "#%02X%02X%02X", red,green,blue)
        }
    }
}

let color1 = CSSColor.Named(.Red)
let color2 = CSSColor.RGB(0xAA, 0xAA, 0xAA)
print("color1 = \(color1), color2 = \(color2)")

extension CSSColor {
    init(gray: UInt8) {
        self = .RGB(gray, gray, gray)
    }
}

let color3 = CSSColor(gray: 0xaa)
print(color3)

// Enum can be used to define a namespace.  They are ideal for this
// because an enum without any cases can never be instantiated.

enum Math {
    static let pi = 3.1415926535897932384626433832795028841971694
}

// Protocols are used to define a blueprint for your model.

protocol DrawingContext {
    func draw(circle: Circle)
    func draw(rectangle: Rectangle)
    // more primitives would go here ...
}

protocol Drawable {
    func draw(context: DrawingContext)
}

struct Circle : Drawable {
    var strokeWidth = 5
    var strokeColor = CSSColor.Named(.Red)
    var fillColor = CSSColor.Named(.Yellow)
    var center = (x: 80.0, y: 160.0)
    var radius = 60.0
    
    // Adopting the Drawable protocol.
    
    func draw(context: DrawingContext) {
        context.draw(self)
    }
}

// Example of computed properties.
extension Circle {
    
    // Diameter setter / getter that maintains radius
    var diameter: Double {
        get {
            return radius * 2
        }
        set {
            radius = newValue / 2
        }
    }
}

// A Rectangle type

struct Rectangle : Drawable {
    var strokeWidth = 5
    var strokeColor = CSSColor.Named(.Teal)
    var fillColor = CSSColor.Named(.Aqua)
    var origin = (x: 110.0, y: 10.0)
    var size = (width: 100.0, height: 130.0)
    
    func draw(context: DrawingContext) {
        context.draw(self)
    }
}

// Our SVGContext is the rendering workhorse for SVGDocuments.  Since it has the
// role of a data sync, taking in commands, using a class is a good choice.

final class SVGContext : DrawingContext {
    
    private var commands: [String] = []
    
    var width = 250
    var height = 250
    
    func draw(circle: Circle) {
        commands.append("<circle cx='\(circle.center.x)' cy='\(circle.center.y)\' r='\(circle.radius)' stroke='\(circle.strokeColor)' fill='\(circle.fillColor)' stroke-width='\(circle.strokeWidth)'  />")
    }
    
    func draw(rectangle: Rectangle) {
        commands.append("<rect x='\(rectangle.origin.x)' y='\(rectangle.origin.y)' width='\(rectangle.size.width)' height='\(rectangle.size.height)' stroke='\(rectangle.strokeColor)' fill='\(rectangle.fillColor)' stroke-width='\(rectangle.strokeWidth)' />")
    }
    
    var SVGString: String {
        var output = "<svg width='\(width)' height='\(height)'>"
        for command in commands {
            output += command
        }
        output += "</svg>"
        return output
    }
    
    var HTMLString: String {
        return "<!DOCTYPE html><html><body>" + SVGString + "</body></html>"
    }
}

// You can create an SVGDocument that renders our pure shape geometry models
// into SVG markup.  Drawable is not coupled at all with the SVG technology.
// We could just as easily create other document types based on other
// technologies such as OpenGL, CoreGraphics, or something else.

struct SVGDocument {
    var drawables: [Drawable] = []
    
    var HTMLString: String {
        let context = SVGContext()
        for drawable in drawables {
            drawable.draw(context)
        }
        return context.HTMLString
    }
    
    // Because we are using a struct model type methods must be marked explicitly
    // mutating.
    
    mutating func append(drawable: Drawable) {
        drawables.append(drawable)
    }
}

// Usage example.  Example of creating a default circle and rectangle.

var document = SVGDocument()

let rectangle = Rectangle()
document.append(rectangle)
let circle = Circle()
document.append(circle)

let HTMLString = document.HTMLString
print(HTMLString)

// Bonus.  Use WebKit to render the SVGDocument.

import WebKit
import XCPlayground
let view = WKWebView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
view.loadHTMLString(HTMLString, baseURL: nil)
XCPlaygroundPage.currentPage.liveView = view


// Define some basic geometery

extension Circle {
    // Example of getter-only computed properties
    var area: Double {
        return radius * radius * Math.pi
    }
    var perimeter: Double {
        return 2 * radius * Math.pi
    }
}
extension Rectangle {
    var area: Double {
        return size.width * size.height
    }
    var perimeter: Double {
        return 2 * (size.width + size.height)
    }
}

// ClosedShapeType is an example of retroactive modeling.
// Now you can compute the totalPerimeter of collections of ShapeGeometry types.

protocol ClosedShapeType {
    var area: Double { get }
    var perimeter: Double { get }
}

extension Circle: ClosedShapeType {}
extension Rectangle: ClosedShapeType {}

func totalPerimeter(shapes: [ClosedShapeType]) -> Double {
    return shapes.reduce(0) { $0 + $1.perimeter }
}