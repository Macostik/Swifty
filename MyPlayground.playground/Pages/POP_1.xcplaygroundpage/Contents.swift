//: [Previous](@previous)

import Foundation
import UIKit

struct Image {
    let image: UIImage?
}

struct Movie {
    let url: NSURL?
}

struct TextMessage {
    let message: String
}

protocol Populable {
    associatedtype T
    func render(data: T)
}

final class Cell: UITableViewCell {}

extension Cell: Populable {
    func render(data: Cell) {
        print("Don't render yourself, dummy!. On second thought, why not?")
    }
}

extension Populable {
    func render(data: Image) {
        print("Render Image \(data.image)")
    }
}

extension Populable {
    func render(data: Movie) {
        print("Render Movie \(data.url)")
    }
}

extension Populable {
    func render(data: TextMessage) {
        print("Render TextMessage \(data.message)")
    }
}

let image = Image(image: UIImage(named: "myIcon"))
let movie = Movie(url: NSURL(string: "http://ctarda.com"))
let textMessage = TextMessage(message: "The amazing adventures of a sse")

let cell = Cell(frame: .zero)
cell.render(image)
cell.render(movie)
cell.render(textMessage)