

import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

import SwiftyJSON
import Alamofire
import UIKit

enum PostRouter: URLRequestConvertible {
    static let baseURLString = "http://jsonplaceholder.typicode.com/"
    
    case Get(Int)
    case Create([String: AnyObject])
    case Delete(Int)
    
    var URLRequest: NSMutableURLRequest {
        var method: Alamofire.Method {
            switch self {
            case .Get:
                return .GET
            case .Create:
                return .POST
            case .Delete:
                return .DELETE
            }
        }
        
        let params: ([String: AnyObject]?) = {
            switch self {
            case .Get, .Delete:
                return (nil)
            case .Create(let newPost):
                return (newPost)
            }
        }()
        
        let url:NSURL = {
            // build up and return the URL for each endpoint
            let relativePath:String?
            switch self {
            case .Get(let postNumber):
                relativePath = "posts/\(postNumber)"
            case .Create:
                relativePath = "posts"
            case .Delete(let postNumber):
                relativePath = "posts/\(postNumber)"
            }
            
            var URL = NSURL(string: PostRouter.baseURLString)!
            if let relativePath = relativePath {
                URL = URL.URLByAppendingPathComponent(relativePath)
            }
            return URL
        }()
        
        let URLRequest = NSMutableURLRequest(URL: url)
        
        let encoding = Alamofire.ParameterEncoding.JSON
        let (encodedRequest, _) = encoding.encode(URLRequest, parameters: params)
        
        encodedRequest.HTTPMethod = method.rawValue
        
        return encodedRequest
    }
}

class ViewController: UIViewController {
    func getFirstPost() {
        // Get first post
        let request = Alamofire.request(PostRouter.Get(1))
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /posts/1")
                    print(response.result.error!)
                    return
                }
                
                if let value: AnyObject = response.result.value {
                    // handle the results as JSON, without a bunch of nested if loops
                    let post = JSON(value)
                    // now we have the results, let's just print them though a tableview would definitely be better UI:
                    print("The post is: " + post.description)
                    if let title = post["title"].string {
                        // to access a field:
                        print("The title is: " + title)
                    } else {
                        print("error parsing /posts/1")
                    }
                }
        }
        debugPrint(request)
    }
    
    func createPost() {
        let newPost = ["title": "Frist Psot", "body": "I iz fisrt", "userId": 1]
        Alamofire.request(PostRouter.Create(newPost))
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /posts/1")
                    print(response.result.error!)
                    return
                }
                
                if let value: AnyObject = response.result.value {
                    // handle the results as JSON, without a bunch of nested if loops
                    let post = JSON(value)
                    print("The post is: " + post.description)
                }
        }
    }
    
    func deleteFirstPost() {
        Alamofire.request(PostRouter.Delete(1))
            .responseJSON { response in
                if let error = response.result.error {
                    // got an error while deleting, need to handle it
                    print("error calling DELETE on /posts/1")
                    print(error)
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // pick which method you want to test here
        // comment out the other two
//        getFirstPost()
        
        createPost()
        
        //deleteFirstPost()
    }
}

let viewController = ViewController()
viewController.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
viewController.view.backgroundColor = UIColor.whiteColor()
XCPlaygroundPage.currentPage.liveView =  viewController.view
