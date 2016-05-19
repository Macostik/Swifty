
import Foundation
import UIKit

protocol RemoteResource {}

extension RemoteResource {
    func load(url: String, completion: ((success: Bool)->())?) {
        print("Performing request: ", url)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!) { (data, response, error) -> Void in
            if let httpResponse = response as? NSHTTPURLResponse where error == nil && data != nil {
                print("Response Code: %d", httpResponse.statusCode)
                
                dataCache[url] = data
                if let c = completion {
                    c(success: true)
                }
            } else {
                print("Request Error")
                if let c = completion {
                    c(success: false)
                }
            }
        }
        task.resume()
    }
    
    func dataForURL(url: String) -> NSData? {
        // A real app would require a more robust caching solution.
        return dataCache[url]
    }
}

public var dataCache: [String : NSData] = [:]

protocol JSONResource : RemoteResource {
    var jsonHost: String { get }
    var jsonPath: String { get }
    func processJSON(success: Bool)
}

protocol MediaResource : RemoteResource {
    var mediaHost: String { get }
    var mediaPath: String { get }
}

extension JSONResource {
    // Default host value for REST resources
    var jsonHost: String { return "api.pearmusic.com" }
    
    // Generate the fully qualified URL
    var jsonURL: String { return String(format: "http://%@%@", self.jsonHost, self.jsonPath) }
    
    // Main loading method.
    func loadJSON(completion: (()->())?) {
        self.load(self.jsonURL) { (success) -> () in
            // Call adopter to process the result
            self.processJSON(success)
            
            // Execute completion block on the main queue
            if let c = completion {
                dispatch_async(dispatch_get_main_queue(), c)
            }
        }
    }
}

extension MediaResource {
    // Default host value for media resources
    var mediaHost: String { return "media.pearmusic.com" }
    
    // Generate the fully qualified URL
    var mediaURL: String { return String(format: "http://%@%@", self.mediaHost, self.mediaPath) }
    
    // Main loading method
    func loadMedia(completion: (()->())?) {
        self.load(self.mediaURL) { (success) -> () in
            // Execute completion block on the main queue
            if let c = completion {
                dispatch_async(dispatch_get_main_queue(), c)
            }
        }
    }
}

extension JSONResource {
    var jsonValue: [String : AnyObject]? {
        do {
            if let d = self.dataForURL(self.jsonURL), result = try NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.MutableContainers) as? [String : AnyObject] {
                return result
            }
        } catch {}
        return nil
    }
}

extension MediaResource {
    var imageValue: UIImage? {
        if let d = self.dataForURL(self.mediaURL) {
            return UIImage(data: d)
        }
        return nil
    }
}

protocol Unique {
    var id: String! { get set }
}

extension Unique where Self: NSObject {
    // Built-in init method from a protocol!
    init(id: String?) {
        print (">>self - init<<")
        self.init()
        if let identifier = id {
            self.id = identifier
        } else {
            self.id = NSUUID().UUIDString
        }
    }
}

// Bonus: Make sure Unique adopters are comparable.
func ==(lhs: Unique, rhs: Unique) -> Bool {
    return lhs.id == rhs.id
}
extension NSObjectProtocol where Self: Unique {
    func isEqual(object: AnyObject?) -> Bool {
        if let o = object as? Unique {
            return o.id == self.id
        }
        return false
    }
}

class Song : NSObject, JSONResource, Unique {
    // MARK: - Metadata
    var title: String?
    var artist: String?
    var streamURL: String?
    var duration: NSNumber?
    var imageURL: String?
    
    // MARK: - Unique
    var id: String!
}

extension JSONResource where Self: Song {
    var jsonPath: String { return String(format: "/songs/%@", self.id) }
    
    func processJSON(success: Bool) {
        if let json = self.jsonValue where success {
            self.title = json["title"] as? String ?? ""
            self.artist = json["artist"] as? String ?? ""
            self.streamURL = json["url"] as? String ?? ""
            self.duration = json["duration"] as? NSNumber ?? 0
        }
    }
}

let s = Song(id: "abcd12345")
let artistLabel = UILabel()

s.loadJSON { (success) -> () in
    artistLabel.text = s.artist
}
