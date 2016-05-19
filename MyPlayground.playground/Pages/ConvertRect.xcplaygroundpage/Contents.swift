//: [Previous](@previous)

import Foundation
import UIKit
import XCPlayground

let view1 = UIView(frame: CGRectMake(0, 0, 300, 300))
view1.backgroundColor = UIColor.blueColor()

let view2 = UIView(frame: CGRectMake(10, 10, 200, 200))
view2.backgroundColor = UIColor.orangeColor()
view1.addSubview(view2)

let view3 = UIView(frame: CGRectMake(20, 20, 100, 100))
view3.backgroundColor = UIColor.greenColor()
view2.addSubview(view3)

let rect2 = view2.convertRect(view3.frame, toCoordinateSpace: view1)

XCPlaygroundPage.currentPage.liveView =  view1
