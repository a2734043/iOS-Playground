//
//  MainVC.swift
//  Calculater
//
//  Created by 陳鍵群 on 2017/12/4.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet var mainView: MainView!
    var inputValue:Double = 0
    var calculateValue:Double = 0
    var valueStr = "0"
    var digits = 1
    var aheadValueDirectCalculate = false
    var startOperate = false
    var inputNewValue = false
    var nowOperate:operate = .operateNotYet

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        setValue()
        
    
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapNumber(_ sender: UIButton) {
        if inputNewValue{
            self.mainView.answer.text = "0"
            valueStr = "0"
            inputNewValue = false
        }
        if valueStr == "0"{
            if sender.tag != 0{self.mainView.clear.setTitle("C", for: .normal)}
            valueStr = "\(sender.tag)"
            inputValue = Double(valueStr)!
            setValue()
        }else if digits < 9{
            self.mainView.clear.setTitle("C", for: .normal)
            valueStr.append("\(sender.tag)")
            inputValue = Double(valueStr)!
            digits += 1
            setValue()
        }
    }
    
    @IBAction func allClear(_ sender: UIButton) {
        self.mainView.clear.setTitle("AC", for: .normal)
        self.mainView.answer.text = "0"
        startOperate = false
        aheadValueDirectCalculate = false
        inputNewValue = false
        nowOperate = .operateNotYet
        digits = 1
        inputValue = 0
        calculateValue = 0
        valueStr = "0"
    }
    
    @IBAction func addPoint(_ sender: Any) {
        if self.valueStr.contains(".") != true{
            self.mainView.clear.setTitle("C", for: .normal)
            self.valueStr.append(".")
            setValue()
        }
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        if startOperate{
            switch nowOperate{
            case .plus:
                calculateValue = calculateValue + inputValue
            case .minus:
                calculateValue = calculateValue - inputValue
            case .multiplication:
                calculateValue = calculateValue * inputValue
            case .divison:
                calculateValue = calculateValue / inputValue
            default:
                print("=")
            }
            valueStr = "\(calculateValue)"
            aheadValueDirectCalculate = false
            print(calculateValue)
            setValue()
        }else{
            calculateValue = inputValue
            inputValue = 0
            valueStr = "0"
            startOperate = true
        }
        switch sender.tag {
        case 1:
            print("加")
            nowOperate = .plus
        case 2:
            print("減")
            nowOperate = .minus
        case 3:
            print("乘")
            nowOperate = .multiplication
        case 4:
            print("除")
            nowOperate = .divison
        default:
            print("等於")
            aheadValueDirectCalculate = true
            nowOperate = .equal
        }
        inputNewValue = true
    }
    
    @IBAction func directCalculate(_ sender: UIButton) {
        if sender.tag == 11{
            if valueStr.contains("-"){
                valueStr.remove(at: valueStr.startIndex)
                setValue()
            }else{
                valueStr.insert("-", at: valueStr.startIndex)
                setValue()
            }
            if aheadValueDirectCalculate{
                calculateValue = Double(valueStr)!
            }else{
                inputValue = Double(valueStr)!
            }
        }else if sender.tag == 12{
            
        }
    }
    
    
    func setValue(){
        print(valueStr)
        let afterDotNoNumber = "^-?[0-9]{1,9}\\.0+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", afterDotNoNumber)
        if predicate.evaluate(with: valueStr){
            valueStr = "\(Int(calculateValue))"
        }
        if self.valueStr.contains("."){
            let integerDigitsAry = self.valueStr.components(separatedBy: ".")
            guard var integerDigits = integerDigitsAry.first else{
                print("小數點前是空值")
                return
            }
            if integerDigits.count > 3 && integerDigits.count < 7{
                integerDigits.insert(",", at: integerDigits.index(integerDigits.endIndex, offsetBy: -3))
            }else if integerDigits.count >= 7{
                integerDigits.insert(",", at: integerDigits.index(integerDigits.endIndex, offsetBy: -3))
                integerDigits.insert(",", at: integerDigits.index(integerDigits.endIndex, offsetBy: -6))
            }
            self.mainView.answer.text = integerDigits + "." + integerDigitsAry.last!
        }else{
            var showValue = valueStr
            if valueStr.count > 3 && valueStr.count < 7{
                showValue.insert(",", at: valueStr.index(valueStr.endIndex, offsetBy: -3))
            }else if valueStr.count >= 7{
                showValue.insert(",", at: valueStr.index(valueStr.endIndex, offsetBy: -3))
                showValue.insert(",", at: valueStr.index(valueStr.endIndex, offsetBy: -6))
            }
            self.mainView.answer.text = showValue
        }
    }
    
    enum operate {
        case plus
        case minus
        case multiplication
        case divison
        case equal
        case operateNotYet
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
