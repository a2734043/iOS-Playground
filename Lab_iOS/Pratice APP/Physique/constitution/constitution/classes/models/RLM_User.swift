//
//  RLM_User.swift
//  constitution
//
//  Created by 陳鍵群 on 2017/8/16.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit
import RealmSwift

class RLM_User: Object {
    dynamic var userid = ""
    dynamic var name = ""
    dynamic var password = ""
    let physiques = List<physique>()
    let symptoms = List<symptom>()
    
    override static func primaryKey() -> String {
        return "userid"
    }
}

class physique: Object{
    dynamic var physiqueNames = ""
}

class symptom: Object{
    dynamic var symptomNames = ""
}












