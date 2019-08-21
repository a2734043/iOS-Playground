//
//  LoginVC.swift
//  constitution
//
//  Created by 陳鍵群 on 2017/8/8.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit
import RealmSwift

class LoginVC: UIViewController {
    @IBOutlet var loginView: LoginView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginTap(_ sender: UIButton) {
        
        inputalart()
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainstoryboard.instantiateViewController(withIdentifier: "userhomeid")as! UserHomeVC
        self.navigationController?.pushViewController(vc, animated: true)
        vc.loginuserID = loginView.userID.text!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        cleartext()
    }
    
    func inputalart(){
        let ok = UIAlertAction(title: "確認", style: .default, handler: nil)
        if loginView.userID.text == ""{
            let alert = UIAlertController(title: "提示", message: "請輸入登入帳號", preferredStyle: .alert)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }else if loginView.passWord.text == ""{
            let alert = UIAlertController(title: "提示", message: "請輸入密碼", preferredStyle: .alert)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        switch existcheck(userid:loginView.userID.text!,password:loginView.passWord.text!) {
        case 1:
            let alert = UIAlertController(title: "提示", message: "帳號不存在", preferredStyle: .alert)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: cleartext)
        case 2:
            let alert = UIAlertController(title: "提示", message: "密碼錯誤", preferredStyle: .alert)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: cleartext)
        default:
            break
        }

    }
    
    func existcheck(userid:String,password:String)->Int{
        let realm = try! Realm()
        let user = realm.objects(RLM_User.self)
        for i in 0..<user.count{
            if userid == user[i].userid{
                if password == user[i].password{
                    return 0
                }
                return 2
            }
        }
    return 1
    }
    
    func cleartext(){
        self.loginView.userID.text = ""
        self.loginView.passWord.text = ""
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
