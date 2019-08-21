//
//  userInfo.swift
//  FoodMap
//
//  Created by 陳鍵群 on 2018/1/4.
//  Copyright © 2018年 陳鍵群. All rights reserved.
//

import UIKit
import RealmSwift

class userInfo: Object {
    @objc dynamic var account:String = ""
    @objc dynamic var name:String = ""
    @objc dynamic var password:String = ""
    @objc dynamic var token:String = ""
    override static func primaryKey() -> String? {
        return "account"
    }
}
