//
//  AlertTask.swift
//  FoodMap
//
//  Created by 陳鍵群 on 2018/1/3.
//  Copyright © 2018年 陳鍵群. All rights reserved.
//

import UIKit

class AlertTask: NSObject {
    class func alertLoginNotYet(title:String? ,message:String?,delegate:UIViewController){
        let title = title ?? ""
        let message = message ?? ""
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let loginBtn = UIAlertAction(title: "登入", style: .default) { (action) in
            delegate.performSegue(withIdentifier: "gotoLogin", sender: nil)
        }
        let cancelBtn = UIAlertAction(title: "不要", style: .destructive, handler: nil)
        alert.addAction(loginBtn)
        alert.addAction(cancelBtn)
        delegate.present(alert, animated: true)
    }
    
    class func alertOnlyConfirm(title:String? ,message:String?,delegate:UIViewController){
        let title = title ?? ""
        let message = message ?? ""
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmBtn = UIAlertAction(title: "確認", style: .default, handler: nil)
        alert.addAction(confirmBtn)
        delegate.present(alert, animated: true)
    }
    
    class func alertGotoAPPSetting(title:String? ,message:String?,delegate:UIViewController){
        let title = title ?? ""
        let message = message ?? ""
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let setting = UIAlertAction(title: "設定", style: .cancel, handler: { action in
            let allowAccess = URL(string: UIApplicationOpenSettingsURLString)
            UIApplication.shared.open(allowAccess!, options: [:], completionHandler: nil)
        })
        let cancel = UIAlertAction(title: "取消", style: .destructive, handler: nil)
        alert.addAction(setting)
        alert.addAction(cancel)
        delegate.present(alert, animated: true)
    }

    class func alertGotoSetting(title:String? ,message:String?,delegate:UIViewController){
        let title = title ?? ""
        let message = message ?? ""
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let setting = UIAlertAction(title: "設定", style: .cancel, handler: { Action in
            let settingforios10 = URL(string: "App-prefs:root=Privacy")
            let setting = URL(string: "prefs:root=Privacy")
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(settingforios10!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.open(setting!, options: [:], completionHandler: nil)
            }
        })
        let cancel = UIAlertAction(title: "取消", style: .destructive, handler: nil)
        alert.addAction(setting)
        alert.addAction(cancel)
        delegate.present(alert, animated: true)
    }
    
}
