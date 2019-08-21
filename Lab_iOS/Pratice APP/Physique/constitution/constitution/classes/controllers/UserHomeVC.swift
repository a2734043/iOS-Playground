//
//  UserHomeVC.swift
//  constitution
//
//  Created by 陳鍵群 on 2017/8/9.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit
import RealmSwift

class UserHomeVC: UIViewController {
    @IBOutlet var userHomeView: UserHomeView!
    var userphysique:[String] = []
    var usersymptom:[String] = []
    var text:String = ""
    var loginuserID:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        getrealm()
        addtext()
        self.userHomeView.userhometext.text = text

        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        //textview從第一行開始顯示
        self.userHomeView.userhometext.setContentOffset(CGPoint.zero, animated: true)
    }
    
    //從Realm取出使用者的體質
    func getrealm(){
        let realm = try! Realm()
        let user = realm.objects(RLM_User.self).filter("userid == '\(loginuserID)'").first
        for i in 0..<(user?.physiques.count)!{
            userphysique.append((user?.physiques[i].physiqueNames)!)
        }
    }
    
    
    //寫入體質分析的文字
    func addtext(){
        if self.userphysique.count == 0 {
            self.text.append("您的體質分析為：\n\n可能要注意的食物與作息有：\n\n該怎麼吃呢？\n=====================\n")
        }else {
            for i in 0..<userphysique.count{
                self.text.append("您的體質分析為：\n\(userphysique[i])\n\n可能要注意的食物與作息有：\n\(getallergy(phy: userphysique[i]))\n\n該怎麼吃呢？\n\(eatnote(phy: userphysique[i]))\n\n=====================\n\n")
            }
        }
    }
    
    @IBAction func recipeTap(_ sender: UIButton) {
        performSegue(withIdentifier: "goRecipe", sender: nil)
    }
    
    @IBAction func datasettingTap(_ sender: UIButton) {
        performSegue(withIdentifier: "goDatasetting", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDatasetting"{
            let vc = segue.destination as! DataSettingVC
            vc.loginuserID = loginuserID
        }
    }
    
    //可能要注意的食物與作息
    func getallergy(phy:String)->String{
        switch phy {
        case "寒性體質":
            return Data().allergyArray[0]
        case "上肝火體質":
            return Data().allergyArray[1]
        case "陰虛火旺體質":
            return Data().allergyArray[2]
        case "上胃火體質":
            return Data().allergyArray[3]
        case "上腸火體質":
            return Data().allergyArray[4]
        case "心臟無力體質":
            return Data().allergyArray[5]
        case "鈣質流失體質":
            return Data().allergyArray[6]
        case "腎虛體質":
            return Data().allergyArray[7]
        case "奶類及其加工製品過敏體質":
            return Data().allergyArray[8]
        case "蛋過敏體質":
            return Data().allergyArray[9]
        case "黃豆及其加工製品過敏體質":
            return Data().allergyArray[10]
        case "五穀雜糧過敏體質":
            return Data().allergyArray[11]
        case "牛肉過敏體質":
            return Data().allergyArray[12]
        default:
            break
        }
        return ""
    }
    
    //該怎麼吃？
    func eatnote(phy:String)->String{
        switch phy {
        case "寒性體質":
            return Data().howtoeat[0]
        case "上肝火體質":
            return Data().howtoeat[1]
        case "陰虛火旺體質":
            return Data().howtoeat[2]
        case "上胃火體質":
            return Data().howtoeat[3]
        case "上腸火體質":
            return Data().howtoeat[4]
        case "心臟無力體質":
            return Data().howtoeat[5]
        case "鈣質流失體質":
            return Data().howtoeat[6]
        case "腎虛體質":
            return Data().howtoeat[7]
        case "奶類及其加工製品過敏體質":
            return Data().howtoeat[8]
        case "蛋過敏體質":
            return Data().howtoeat[9]
        case "黃豆及其加工製品過敏體質":
            return Data().howtoeat[10]
        case "五穀雜糧過敏體質":
            return Data().howtoeat[11]
        case "牛肉過敏體質":
            return Data().howtoeat[12]
        default:
            break
        }
        return ""
    }
    
    @IBAction func logoutTap(_ sender: UIButton) {
        //push
//                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = mainStoryboard.instantiateViewController(withIdentifier: "mainStoryboardId")
//                self.navigationController?.pushViewController(vc, animated: true)
        //pop
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    @IBAction func logoutBtnTap(_ sender: UIButton) {
        self.navigationController?.navigationBar.isHidden = true
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
