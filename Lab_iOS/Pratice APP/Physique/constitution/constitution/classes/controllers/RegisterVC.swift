//
//  RegisterVC.swift
//  constitution
//
//  Created by 陳鍵群 on 2017/8/9.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit
import RealmSwift

class RegisterVC: UIViewController {
    @IBOutlet var registerView: RegisterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func registerTap(_ sender: UIButton) {
        inputalart()
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainstoryboard.instantiateViewController(withIdentifier: "settingVC")as! SettingVC
        vc.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(vc, animated: true)
        vc.loginuserID = registerView.userID.text!
    }

    
    func inputalart(){
        let ok = UIAlertAction(title: "確認", style: .default, handler: nil)
        if registerView.userName.text == ""{
            let alert = UIAlertController(title: "提示", message: "請輸入使用者名稱", preferredStyle: .alert)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }else if registerView.userID.text == ""{
            let alert = UIAlertController(title: "提示", message: "請輸入登入帳號", preferredStyle: .alert)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }else if registerView.passWord.text == ""{
            let alert = UIAlertController(title: "提示", message: "請輸入密碼", preferredStyle: .alert)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }else if registerView.confirmPassWd.text == ""{
            let alert = UIAlertController(title: "提示", message: "請再次輸入密碼", preferredStyle: .alert)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        if registerView.passWord.text != registerView.confirmPassWd.text{
            let alert = UIAlertController(title: "提示", message: "密碼與確認密碼不符", preferredStyle: .alert)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: {
                self.registerView.passWord.text = ""
                self.registerView.confirmPassWd.text = ""
            })
        }
        
        if existcheck(userid: registerView.userID.text!){
            let alert = UIAlertController(title: "提示", message: "帳號已存在", preferredStyle: .alert)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: {
                self.registerView.userID.text = ""
            })
        }else{
            writenewUserData()
        }
    }
    
    func existcheck(userid:String)->Bool{
        let realm = try! Realm()
        let user = realm.objects(RLM_User.self)
        for i in 0..<user.count{
            if userid == user[i].userid{
                return true
            }
        }
        return false
    }
    
    func writenewUserData(){
        let realm = try! Realm()
        let user = RLM_User()
        user.userid = self.registerView.userID.text!
        user.name = self.registerView.userName.text!
        user.password = self.registerView.passWord.text!
        try! realm.write {
            realm.add(user, update: true)
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
