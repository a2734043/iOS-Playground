//
//  ApiTask.swift
//  FoodMap
//
//  Created by 陳鍵群 on 2018/1/5.
//  Copyright © 2018年 陳鍵群. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ApiTask: NSObject {
    //MARK:registerApi
    class func registerApi(name:String, email:String, password:String, completion:((registerResponse) -> Void)?){
        let header:HTTPHeaders = ["Accept":"application/json"]
        let parament = ["name":name,"email":email,"password":password]
        Alamofire.request(Apiurl.register, method: .post, parameters: parament, headers: header).responseObject { (response:DataResponse<registerResponse>) in
    
//            if let response = response.result.value{
//                completion?(response)
//
//            }
            switch response.result{
            case .success(let value):
                print(value.status)
            case .failure(let error):
                let decoder = JSONDecoder()
               print(error.localizedDescription)
            }
            
        }
    }
    
    //MARK:loginApi(auth)
    class func authApi(email:String, password:String, completion:((authResponse) -> Void)?){
        let header:HTTPHeaders = ["Accept":"application/json"]
        let parament = ["email":email,"password":password]
        Alamofire.request(Apiurl.auth, method: .post, parameters: parament, headers: header).responseObject { (response:DataResponse<authResponse>) in
            if let response = response.result.value{
                completion?(response)
            }
        }
    }
    
    //MARK:userInfoApi
    class func userInfoApi(token:String,completion:((userInfoResponse) -> Void)?){
        let header:HTTPHeaders = ["Accept":"application/json","Authorization":token]
        Alamofire.request(Apiurl.userInfo, method: .get, headers: header).responseObject { (response:DataResponse<userInfoResponse>) in
            if let response = response.result.value{
                completion?(response)
            }
        }
    }
    
    //MARK:mapApi
    class func getMapApi(completion:((MapResponse) -> Void)?){
        let header:HTTPHeaders = ["Accept":"application/json"]
        Alamofire.request(Apiurl.map, method: .get, headers: header).responseObject { (response:DataResponse<MapResponse>) in
            if let response = response.result.value{
                completion?(response)
            }
        }
    }
    
    //MARK:uploadImage
    class func uploadImage(token:String,name:String,description:String,lat:Double,lng:Double,completion:((uploadImage) -> Void)?){
        let header:HTTPHeaders = ["Accept":"application/json","Authorization":token]
        let parameters:Parameters = ["name":name,"description":description,"images":1,"lat":lat,"lng":lng]
        Alamofire.request(Apiurl.map, method: .post, parameters: parameters, headers: header).responseObject { (response:DataResponse<uploadImage>) in
            if let response = response.result.value{
                completion?(response)
            }
        }
    }
    
    //MARK:uploadToStroage
    class func uploadToStroage(api:String,image:URL,completion:(([FileResponse]) -> Void)?){
        Alamofire.upload(multipartFormData: { (formData) in
            formData.append(image, withName: "file")
        }, to: api, method:.post) { (encodingResult) in
            switch encodingResult{
            case .success(let upload, _, _):
                upload.responseArray(completionHandler: { (response:DataResponse<[FileResponse]>) in
                    if let response = response.result.value{
                        completion?(response)
                    }
                })
            case .failure(let encodingError):
                print(encodingError.localizedDescription)
            }
        }
    }
}
