//: [Previous](@previous)

import Foundation
import UIKit

extension NSString {
    func heightWithFont(font: UIFont, width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.max)
        let height = boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil).height
        return ceil(height)
    }
}

var str = "Hello\n\n, playground" // normal height isEqual 21.0

let height = str.heightWithFont(UIFont.systemFontOfSize(17.0), width: 150.0)





