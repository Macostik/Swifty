import Foundation
import UIKit



protocol StringRepresentable {
    var shortString: String { get }
    var mediumString: String { get }
    var longString: String { get }
}

extension NSObjectProtocol where Self: StringRepresentable {
    var description: String { return self.longString }
}

class Artist : NSObject, StringRepresentable {
    var name: String!
    var instrument: String!
    var bio: String!
}

class Album : NSObject, StringRepresentable {
    var title: String!
    var artist: Artist!
    var tracks: Int!
}

extension StringRepresentable where Self: Artist {
    var shortString: String { return self.name }
    var mediumString: String { return String(format: "%@ (%@)", self.name, self.instrument) }
    var longString: String { return String(format: "%@ (%@), %@", self.name, self.instrument, self.bio) }
}

extension StringRepresentable where Self: Album {
    var shortString: String { return self.title }
    var mediumString: String { return String(format: "%@ (%d Tracks)", self.title, self.tracks) }
    var longString: String { return String(format: "%@, an Album by %@ (%d Tracks)", self.title, self.artist.name, self.tracks) }
}

protocol StringDisplay {
    var containerSize: CGSize { get }
    var containerFont: UIFont { get }
    func assignString(str: String)
}

extension StringDisplay {
    func displayStringValue(obj: StringRepresentable) {
        if self.stringWithin(obj.longString) {
            self.assignString(obj.longString)
        } else if self.stringWithin(obj.mediumString) {
            self.assignString(obj.mediumString)
        } else {
            self.assignString(obj.shortString)
        }
    }
    
    func sizeWithString(str: String) -> CGSize {
        return (str as NSString).boundingRectWithSize(CGSizeMake(self.containerSize.width, .max),
            options: .UsesLineFragmentOrigin,
            attributes:  [NSFontAttributeName: self.containerFont],
            context: nil).size
    }
    
    private func stringWithin(str: String) -> Bool {
        return self.sizeWithString(str).height <= self.containerSize.height
    }
}

extension UIButton : StringDisplay {
    var containerSize: CGSize { return self.frame.size}
    var containerFont: UIFont { return self.titleLabel!.font }
    func assignString(str: String) {
        self.setTitle(str, forState: .Normal)
    }
}


let a = Artist()
a.name = "Bob Marley"
a.instrument = "Guitar / Vocals"
a.bio = "Every little thing's gonna be alright."

let smallButton = UIButton(frame: CGRectMake(0.0, 0.0, 120.0, 40.0))
smallButton.displayStringValue(a)

print(smallButton.titleLabel!.text) // 'Bob Marley'

let mediumButton = UIButton(frame: CGRectMake(0.0, 0.0, 600.0, 40.0))
mediumButton.displayStringValue(a)

print(mediumButton.titleLabel!.text) // 'Bob Marley (Guitar / Vocals)'
