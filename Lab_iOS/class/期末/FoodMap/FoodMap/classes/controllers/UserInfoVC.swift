//
//  UserInfoVC.swift
//  FoodMap
//
//  Created by 陳鍵群 on 2018/1/4.
//  Copyright © 2018年 陳鍵群. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    @IBOutlet var userInfoView: UserInfoView!
    var token = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.token)
        ApiTask.userInfoApi(token: self.token) { (response) in
            guard let user = response.user else{
                return
            }
            self.userInfoView.userInfoText.text = "使用者名稱：\(user.name)\n" + "帳號：\(user.email)"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
