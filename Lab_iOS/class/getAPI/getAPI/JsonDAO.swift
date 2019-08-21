//
//  JsonDAO.swift
//  getAPI
//
//  Created by 陳鍵群 on 2017/11/27.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit

protocol JsonAPIDelegate {
    func carResult(success:Bool,carResultObjects:JsonDAO.Data?,errorMessage:String?)
}

class JsonDAO: NSObject {
    var delegate:JsonAPIDelegate?
    struct Data:Codable {
        struct wheathers:Codable {
            let color:String
            let licenseNumber:String
            let owner:String?
        }
        let wheather:[wheathers]
    }
    

    func getCarsFromWebAPI(){
        let url = URL(string:"http://dig.taichung.gov.tw/easygo/json/site_data.aspx")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else{
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // 檢查HTTP狀態 （200為正常）
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
//            //JsonDecoder
//            let decoder = JSONDecoder()
//            let responseResult = try! decoder.decode(Data.self, from: data)
//            if self.delegate != nil{
//                self.delegate?.carResult(success: true, carResultObjects: responseResult, errorMessage: nil)
//            }
            
            
            // 印出由server輸出的字串
            //            let responseString = String(data: data, encoding: .utf8)
            //            print("luckeyNumbers= \(String(describing: response))")
        }
        task.resume()
    }
}
