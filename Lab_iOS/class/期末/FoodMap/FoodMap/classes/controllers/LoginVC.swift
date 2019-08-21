//
//  LoginVC.swift
//  FoodMap
//
//  Created by 陳鍵群 on 2018/1/4.
//  Copyright © 2018年 陳鍵群. All rights reserved.
//

import UIKit
import RealmSwift

class LoginVC: UIViewController {

    @IBOutlet var loginView: LoginView!
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
    
    //MARK:loginBtn
    @IBAction func loginBtn(_ sender: Any) {
        guard self.loginView.accountText.text != "" else{
            self.loginView.accountText.text = ""
            AlertTask.alertOnlyConfirm(title: "登入失敗", message: "請輸入帳號", delegate: self)
            return
        }
        guard self.loginView.passwordText.text != "" else{
            self.loginView.passwordText.text = ""
            AlertTask.alertOnlyConfirm(title: "登入失敗", message: "請輸入密碼", delegate: self)
            return
        }
        ApiTask.authApi(email: self.loginView.accountText.text!, password: self.loginView.passwordText.text!) { (response) in
            guard response.status == "success" else{
                //登入失敗
                self.loginView.accountText.text = ""
                self.loginView.passwordText.text = ""
                AlertTask.alertOnlyConfirm(title: "登入失敗", message: "請輸入正確的帳號密碼", delegate: self)
                return
            }
//            let realm = try! Realm()
//            realm.beginWrite()
//            if let user = realm.objects(userInfo.self).filter("account = '\(self.loginView.accountText.text!)'").first{
//                user.token = response.token
//                realm.add(user, update: true)
//            }
//            try! realm.commitWrite()
            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let rootVC = storyboard.instantiateViewController(withIdentifier: "main") as! MainVC
//            rootVC.account = account
//            self.navigationController?.pushViewController(rootVC, animated: true)
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        
    }
    
    //MARK:gotoRegister
    @IBAction func gotoRegisterBtn(_ sender: Any) {
        performSegue(withIdentifier: "gotoRegister", sender: nil)
    }
    //MARK:cancel
    @IBAction func cancelBtn(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
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
