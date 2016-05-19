//: [Previous](@previous)

import Foundation
import UIKit

var one: String? = nil
var array = [1, 2, 3, 5]
let two = 4
if let firstElement = array.first {
    array.insert(two, atIndex:(array.indexOf(firstElement)! + 3))
}
array.append(1)
//( $0 % 2 == 0 ? $0 : 0 ) + ( $1 %2 == 0 ? $1 : 0)
let sum  = array.reduce( 0,  combine:{ (($0 % 2) != 0 ? $0 : 0) + (($1 % 2) != 0 ? $1 : 0) })
print (">>self - \(sum)<<")

let _sum  = array.filter({ $0 % 2 != 0 }).reduce(0, combine: +)
print (">>self - \(_sum)<<")


for x in 1.stride(to: 10, by: 0.1) {
    print (">>self - \(x)<<")
}

let nilArray: [Int?] = [1, nil, 2, nil, 3, 4, nil, 5]

for case .Some(let x) in nilArray {
    print (">>self - \(x)<<")
}

for case let number? in nilArray {
    print("Found a \(number)")
}

var fao1:[Int?] = [1,2,3,4,nil,6]

var fao1m = fao1.flatMap({$0})
fao1m /*[Int] with content [1, 2, 3, 4, 6] */

var fao12m = fao1.map({$0})
fao12m

var s: String? = .Some("someSting")
var arr: [String] = []
let e = s.flatMap({$0})
e
arr.append(e!)
