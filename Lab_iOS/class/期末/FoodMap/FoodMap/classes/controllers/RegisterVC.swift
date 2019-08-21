//
//  RegisterVC.swift
//  FoodMap
//
//  Created by 陳鍵群 on 2018/1/4.
//  Copyright © 2018年 陳鍵群. All rights reserved.
//

import UIKit
import RealmSwift

class RegisterVC: UIViewController {

    @IBOutlet var registerView: RegisterView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //MARK:viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    //MARK:viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //MARK:cancelBtn
    @IBAction func cancelBtn(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    //MARK:registerBtn
    @IBAction func registerBtn(_ sender: Any) {
        guard self.registerView.accountText.text != "" else{
            self.registerView.accountText.text = ""
            AlertTask.alertOnlyConfirm(title: "提示", message: "請輸入帳號", delegate: self)
            return
        }
        guard self.registerView.userNameText.text != "" else{
            self.registerView.userNameText.text = ""
            AlertTask.alertOnlyConfirm(title: "提示", message: "請輸入名稱", delegate: self)
            return
        }
        guard self.registerView.passwordText.text != "" else{
            self.registerView.passwordText.text = ""
            AlertTask.alertOnlyConfirm(title: "提示", message: "請輸入密碼", delegate: self)
            return
        }
        guard self.registerView.confirmPasswordText.text != "" else{
            self.registerView.confirmPasswordText.text = ""
            AlertTask.alertOnlyConfirm(title: "提示", message: "請輸入確認密碼", delegate: self)
            return
        }
        guard self.registerView.passwordText.text! == self.registerView.confirmPasswordText.text! else{
            self.registerView.passwordText.text = ""
            self.registerView.confirmPasswordText.text = ""
            AlertTask.alertOnlyConfirm(title: "提示", message: "確認密碼與密碼不符", delegate: self)
            return
        }
        
        ApiTask.registerApi(name: self.registerView.userNameText.text!, email: self.registerView.accountText.text!, password: self.registerView.passwordText.text!) { (response) in
            guard response.status == "success" else{
                //註冊失敗 請輸入有效電子郵件
                self.registerView.userNameText.text = ""
                self.registerView.accountText.text = ""
                self.registerView.passwordText.text = ""
                self.registerView.confirmPasswordText.text = ""
                AlertTask.alertOnlyConfirm(title: "提示", message: "註冊失敗，請輸入有效電子郵件", delegate: self)
                return
            }
            let realm = try! Realm()
            let user = userInfo()
            user.name = self.registerView.userNameText.text!
            user.account = self.registerView.accountText.text!
            user.password = self.registerView.passwordText.text!
            try! realm.write {
                realm.add(user)
            }
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let rootVC = storyboard.instantiateViewController(withIdentifier: "main") as! MainVC
//            rootVC.account = account
            self.navigationController?.popToRootViewController(animated: true)
            
        }
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
