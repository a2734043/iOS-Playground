//
//  MainVC.swift
//  TestUserDefault
//
//  Created by 陳鍵群 on 2017/12/4.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet var mainView: MainView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let userDefault = UserDefaults.standard
        guard let saveValue = userDefault.object(forKey: "userLogInID") as! String? else{
            print("nil")
            return
        }
        let alert = UIAlertController(title: "Welcome", message: saveValue, preferredStyle: .alert)
        let confirmBtn = UIAlertAction(title: "確認", style: .default, handler: nil)
        let logoutBtn = UIAlertAction(title: "登出", style: .destructive) { (action) in
            userDefault.removeObject(forKey: "userLogInID")
            userDefault.synchronize()
        }
        alert.addAction(confirmBtn)
        alert.addAction(logoutBtn)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func logOut(_ sender: Any) {
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: "userLogInID")
        userDefault.synchronize()
    }
    
    @IBAction func logIn(_ sender: Any) {
        let userDefault = UserDefaults.standard
        userDefault.set(self.mainView.textInput.text, forKey: "userLogInID")
        userDefault.synchronize()
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
