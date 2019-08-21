//
//  SettingVC.swift
//  constitution
//
//  Created by 陳鍵群 on 2017/8/9.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit
import RealmSwift

class SettingVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var settingView: SettingView!
    var recieve = "sym"
    
    var selected:[Int] = []
    var userphysique:[String] = []
    var usersymptom:[String] = []
    var loginuserID:String = ""
    let cellid = "setcell"
    var cellTypes:[UITableViewCellAccessoryType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if recieve == "sym"{
            for _ in Data().symptomArray{
                self.cellTypes.append(UITableViewCellAccessoryType.none)
            }
        }else{
            for _ in Data().physiqueArray{
                self.cellTypes.append(UITableViewCellAccessoryType.none)
            }
        }

        self.settingView.settingTV.delegate = self
        self.settingView.settingTV.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let okbar:UIButton = UIButton.init()
//        okbar.setTitle("確認", for: .normal)
//        okbar.backgroundColor = UIColor.black
//        okbar.addTarget(self, action: #selector(okbarTap), for: .touchUpInside)
//        let ok:UIBarButtonItem = UIBarButtonItem.init(customView: okbar)
//        self.navigationController?.navigationBar.topItem?.setRightBarButton(ok, animated: true)
    }
    override func viewDidLayoutSubviews() {
        let okbar:UIButton = UIButton.init()
        okbar.setTitle("確認", for: .normal)
        okbar.backgroundColor = UIColor.black
        okbar.addTarget(self, action: #selector(okbarTap), for: .touchUpInside)
        let ok:UIBarButtonItem = UIBarButtonItem.init(customView: okbar)
        self.navigationController?.navigationBar.topItem?.setRightBarButton(ok, animated: true)
    }
    
    @objc func okbarTap(){
        if selected.count == 0{
            let ok = UIAlertAction(title: "好", style: .default, handler: nil)
            let alert = UIAlertController(title: "提示", message: "請選擇項目", preferredStyle: .alert)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        giveValue()
        
        if userphysique.count == 0{
            whatphy()
        }
            writeUserPhy()
        
        if usersymptom.count != 0{
            writeUserSym()
        }
        
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "userhomeid")as! UserHomeVC
        self.navigationController?.pushViewController(vc, animated: false)

       
        vc.loginuserID = loginuserID
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //把所選的項目加到陣列內
    func giveValue(){
        if recieve == "sym"{
            for i in selected{
                usersymptom.append(Data().symptomArray[i])
            }
        }else{
            for i in selected{
                userphysique.append(Data().physiqueArray[i])
            }
        }
    }
    
    //選擇症狀後判斷符合哪些體質
    func whatphy(){
        for i in 0..<Data().SymInPhy.count{
            if searchArray(InArray: selected, CheckArray: Data().SymInPhy[i]){
                userphysique.append(Data().physiqueArray[i])
            }
        }
    }
    
    //確認症狀是否超過1/3
    func searchArray(InArray:[Int],CheckArray:[Int])->Bool{
        var count:Int = 0
        for x in InArray{
            for y in CheckArray{
                if x == y {
                    count+=1
                    if (count >= (CheckArray.count/3+1)){
                        return true
                    }
                }
            }
        }
        return false
    }
    
    //症狀寫入Realm
    func writeUserSym(){
        let realm = try! Realm()
        let myUser = realm.objects(RLM_User.self).filter("userid == '\(loginuserID)'").first
        
        realm.beginWrite()
            realm.delete((myUser?.symptoms)!)
            for i in 0..<usersymptom.count{
                let sym = symptom()
                sym.symptomNames = usersymptom[i]
                myUser?.symptoms.append(sym)
            }
        try! realm.commitWrite()
    }
    
    //體質寫入Realm
    func writeUserPhy(){
        let realm = try! Realm()
        let myUser = realm.objects(RLM_User.self).filter("userid == '\(loginuserID)'").first
        
        realm.beginWrite()
        
        realm.delete((myUser?.physiques)!)

        for i in 0..<userphysique.count{
            let phy = physique()
            phy.physiqueNames = userphysique[i]
            myUser?.physiques.append(phy)
        }
        try! realm.commitWrite()
    }
    
    //TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if recieve == "sym"{
            return Data().symptomArray.count
        }else{
            return Data().physiqueArray.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DataSettingTVCell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)as! DataSettingTVCell
        cell.accessoryType = cellTypes[indexPath.row]
        cell.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 0.9543628961)
        if recieve == "sym"{
            cell.dataLabel.text = Data().symptomArray[indexPath.row]
        }else{
            cell.dataLabel.text = Data().physiqueArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.settingView.settingTV.cellForRow(at: indexPath)
        if cell?.accessoryType == .checkmark{
            cell?.accessoryType = .none
            cellTypes[indexPath.row] = .none
            self.selected.remove(at: self.selected.index(of: indexPath.row)!)
        }else{
            cell?.accessoryType = .checkmark
            cellTypes[indexPath.row] = .checkmark
            self.selected.append(indexPath.row)
        }
        
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
