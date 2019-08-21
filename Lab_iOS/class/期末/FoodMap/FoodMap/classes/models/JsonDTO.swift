//
//  JsonDTO.swift
//  FoodMap
//
//  Created by 陳鍵群 on 2018/1/5.
//  Copyright © 2018年 陳鍵群. All rights reserved.
//

import UIKit
import ObjectMapper
class RegistResult:Codable{
    var status:String?
    var message:String?
    
}
class registerResponse:Mappable{
    var status = ""
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        status <- map["status"]
    }
}

class authResponse:Mappable{
    var status = ""
    var token = ""
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        status <- map["status"]
        token <- map["token"]
    }
}

class userInfoResponse:Mappable{
    var status = ""
    var user:User?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        status <- map["status"]
        user <- map["user"]
    }
}
class User:Mappable{
    var id:Int?
    var name = ""
    var email = ""
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
    }
}

class MapResponse:Mappable{
    var status = ""
    var datas:[Datas] = []
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        status <- map["status"]
        datas <- map["map"]
    }
}
class Datas:Mappable{
    var name = ""
    var description = ""
    var images = [""]
    var lat:Double = 0.0
    var lng:Double = 0.0
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        name <- map["name"]
        description <- map["description"]
        images <- map["images"]
        lat <- map["lat"]
        lng <- map["lng"]
    }
}

class uploadImage:Mappable{
    var status = ""
    var imageUrl = [""]
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        status <- map["status"]
        imageUrl <- map["image_urls"]
    }
}

class FileResponse: Mappable {
    var origin = ""
    var url = ""
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        origin <- map["origin"]
        url <- map["url"]
    }
}


//class Email: Mappable {
//    var email:[String] = []
//    required init?(map: Map) {
//    }
//    func mapping(map: Map) {
//        email <- map["email"]
//    }
//}
//class registerInvalid:Mappable{
//    var message = ""
//    var errors:Email? = nil
//    required init?(map: Map) {
//    }
//    func mapping(map: Map) {
//        message <- map["message"]
//        errors <- map["errors"]
//    }
//}



