//
//  SettingViewController.swift
//  HamburgerTest
//
//  Created by 陳鍵群 on 2019/1/22.
//  Copyright © 2019年 陳鍵群. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        label.text = "setting"
        self.view.addSubview(label)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
