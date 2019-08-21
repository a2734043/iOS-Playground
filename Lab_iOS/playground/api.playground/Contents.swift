import UIKit
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


struct AuthResponse: Decodable{
    var checkToolAuthList:[CheckToolAuthList]
    var count:Int
    var method:String
    var responseCode:String

    enum CodingKeys:String, CodingKey{
        case checkToolAuthList = "CheckToolAuthList"
        case count = "Count"
        case method = "Method"
        case responseCode = "ResponseCode"
    }
}
struct CheckToolAuthList: Decodable{
    var authEnd:Int = 0
    var authRemark:String = ""
    var authStart:Int = 0
    var authState:Int = 0
    var sp:String = ""
    var st188MacId:String = ""
    var st940Code:String = ""

    enum CodingKeys:String, CodingKey{
        case authEnd = "AuthEnd"
        case authRemark = "AuthRemark"
        case authStart = "AuthStart"
        case authState = "AuthState"
        case sp = "Sp"
        case st188MacId = "St188MacId"
        case st940Code = "St940Code"
    }
}
struct ResponseError : Decodable{
    var ResponseCode = ""
}
let url = URL(string: "http://114.55.95.56:8889/api_gateway")
var request = URLRequest(url: url!)
request.httpMethod = "POST"
let authparameter:[String:String] = ["Method":"checktool-auth-query",
                                     "UserId":"NsUTC",
                                     "UserPwd":"123456"]
do{
    request.httpBody = try JSONSerialization.data(withJSONObject: authparameter, options: JSONSerialization.WritingOptions())
}catch let error{
    print(error)
}
//request.setValue("application/json", forHTTPHeaderField: "Content-Type")
let urlSession = URLSession.shared
urlSession.dataTask(with: request) { (data1, response2, error3) in
    if let error = error3{
        print(error)
    }else if let response = response2 as? HTTPURLResponse, let data = data1{
        print(response.statusCode)
        let decoder = JSONDecoder()
        if let object = try? decoder.decode(AuthResponse.self, from: data){
            print(object.count)
        }else if let errorObject = try? decoder.decode(ResponseError.self, from: data){
            print(errorObject.ResponseCode)
        }
    }
}.resume()

