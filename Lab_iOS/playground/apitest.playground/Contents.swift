//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


let url = URL(string:"http://dig.taichung.gov.tw/easygo/json/site_data.aspx")
var request = URLRequest(url: url!)
request.httpMethod = "GET"

let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
    guard let data = data, error == nil else{
        print("error=\(String(describing: error))")
        return
    }
//    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // 檢查HTTP狀態 （200為正常）
//        print("statusCode should be 200, but is \(httpStatus.statusCode)")
//        print("response = \(String(describing: response))")
//    }
//    
    
    // 印出由server輸出的字串
    let responseString = String(data: data, encoding: .utf8)
    print("luckeyNumbers= \(String(describing: responseString))")
}
task.resume()


