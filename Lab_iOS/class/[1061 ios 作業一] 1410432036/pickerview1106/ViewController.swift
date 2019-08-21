//
//  ViewController.swift
//  pickerview1106
//
//  Created by 陳鍵群 on 2017/11/6.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    let country = ["台中市","彰化縣","南投縣"]
    let area = [["中區","東區","南區","西區","北區","北屯區","西屯區","南屯區","太平區",
                         "大里區","霧峰區","烏日區","豐原區","后里區","石崗區","東勢區","和平區",
                         "新社區","潭子區","大雅區","神岡區","大肚區","沙鹿區","龍井區","梧棲區",
                         "清水區","大甲區","外埔區","大安區"],
                        ["彰化市","芬園鄉","花壇鄉","秀水鄉","鹿港鎮","福興鄉","線西鄉","和美鎮",
                         "伸港鄉","員林鎮","社頭鄉","永靖鄉","埔心鄉","溪湖鎮","大村鄉","埔鹽鄉",
                         "田中鎮","北斗鎮","田尾鄉","埤頭鄉","溪州鄉","竹塘鄉","二林鎮","大城鄉",
                         "芳苑鄉","二水鄉"],
                        ["南投市","中寮鄉","草屯鎮","國姓鄉","埔里鎮","仁愛鄉","名間鄉","集集鎮",
                         "水里鄉","魚池鄉","信義鄉","竹山鎮","鹿谷鄉",]]
    let zip = [["400","401","402","403","404","406","407","408","411","412","413",
               "414","420","421","422","423","424","426","427","428","429","432",
               "433","434","435","436","437","438","439"],
               ["500","502","503","504","505","506","507","508","509","510","511",
                "512","513","514","515","516","520","521","522","523","524","525",
                "526","527","528","530"],
               ["540","541","542","544","545","546","551","552","553","555","556",
                "557","558"]]
    var selectedCountry = 0
    var selectedArea = 0
    var ItemIndex = [0,0]
    
        
    @IBOutlet weak var textBtn: UIButton!
    @IBOutlet weak var firstPickerview: UIPickerView!
    @IBOutlet weak var views: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return country.count
        }else{
            switch selectedCountry{
            case 0 :
                return area[0].count
            case 1:
                return area[1].count
            default:
                return area[2].count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            selectedCountry = self.firstPickerview.selectedRow(inComponent: 0)
            self.firstPickerview.reloadComponent(1)
            self.firstPickerview.selectRow(0, inComponent: 1, animated: true)
            selectedArea = self.firstPickerview.selectedRow(inComponent: 1)
        } else{
            selectedArea = self.firstPickerview.selectedRow(inComponent: 1)
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return country[row]
        }else{
            switch selectedCountry{
            case 0:
                return area[0][row]
            case 1:
                return area[1][row]
            default:
                return area[2][row]
            }
        }
    }
    @IBAction func selectBtnTap(_ sender: Any) {
        self.firstPickerview.selectRow(ItemIndex[0], inComponent: 0, animated: false)
        self.firstPickerview.selectRow(ItemIndex[1], inComponent: 1, animated: false)
        self.views.isHidden = false
    }
    @IBAction func okBtnTAP(_ sender: Any) {
        selectedCountry = self.firstPickerview.selectedRow(inComponent: 0)
        selectedArea = self.firstPickerview.selectedRow(inComponent: 1)
        self.textBtn.setTitle(zip[selectedCountry][selectedArea] + country[selectedCountry] + area[selectedCountry][selectedArea], for: .normal)
        ItemIndex[0] = selectedCountry
        ItemIndex[1] = selectedArea
        self.views.isHidden = true
    }
    @IBAction func cancelBtnTAP(_ sender: Any) {
        self.views.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.views.isHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

