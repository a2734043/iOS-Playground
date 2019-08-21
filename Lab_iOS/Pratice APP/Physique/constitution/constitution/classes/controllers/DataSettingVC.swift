//
//  DataSettingVC.swift
//  constitution
//
//  Created by 陳鍵群 on 2017/8/9.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit

class DataSettingVC: UIViewController {
    @IBOutlet var dataSettingView: DataSettingView!
    var condition = ""
    var loginuserID:String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
 
    
    @IBAction func symTap(_ sender: UIButton) {
        self.condition = "sym"
        self.performSegue(withIdentifier: "setTV", sender: nil)
    }

    @IBAction func phyTap(_ sender: UIButton) {
        self.condition = "phy"
        self.performSegue(withIdentifier: "setTV", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SettingVC
        vc.recieve = self.condition
        vc.loginuserID = loginuserID
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
