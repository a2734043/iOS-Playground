//
//  ViewController.swift
//  LocalizeDemo
//
//  Created by 陳鍵群 on 2019/1/17.
//  Copyright © 2019年 陳鍵群. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = UserDefaults.standard.string(forKey: "UserLanguage") ?? "en"
        print(a)
        
        
        let label: UILabel = UILabel()
        label.frame = CGRect(x: self.view.frame.size.width / 2 - 100, y: self.view.frame.size.height / 2 - 25, width: 200, height: 50)
        label.text = LocalizeUtils.shared.localized(withKey: "Test")
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = NSTextAlignment.center
        label.layer.cornerRadius = 10
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.darkGray
        self.view.addSubview(label)
        print(Locale.preferredLanguages)
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

