//
//  ViewController.swift
//  testTextfield
//
//  Created by 陳鍵群 on 2018/6/22.
//  Copyright © 2018年 陳鍵群. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
//       let tt = UITextField(frame: CGRect.init(x: 20, y: 20, width: 200, height: 40))
//        tt.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
//        tt.delegate = self
//        tt.units = .second
//        print(tt.units)
//        self.view.addSubview(tt)
        let unicodeData = "\\u" + "53F0"
        let data = unicodeData.data(using: String.Encoding.utf8)
        let value = String(data: data!, encoding: String.Encoding.nonLossyASCII)
        print("=====================")
        print(value)
        
//        let customTest = CustomText.init(unit: .low)
//        customTest.frame = CGRect.init(x: 10, y: 10, width: 200, height: 40)
//        customTest.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
//        self.view.addSubview(customTest)
        
//        if let unit = customTest.unit{
//            switch unit{
//                case .hight
//
//            }
//        }
        // Do any additional setup after loading the view, typically from a nib.
    }
   
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 1 {return true}
        guard let text = textField.text else{return true}
        let total = text + string
        switch textField.units {
        case .second:
            if text.contains("."){
                if string == "."{
                    return false
                }
                if text.split(separator: ".").count == 1{
                    if total.isOverMaximun(type: .second){
                        return false
                    }
                    return true
                }else if text.split(separator: ".").count == 2{
                    return false
                }
                return true
            }
            if text.count == 3{
                if total.isOverMaximun(type: .second){
                    return false
                }
            }else if text.count == 4{
                if total.isOverMaximun(type: .noSecond){
                    return false
                }
                if string == "."{
                    return true
                }
                textField.text = text + "."
                return true
            }
            return true
        case .noSecond:
            if (total.isOverMaximun(type: .noSecond)){
                return false
            }
            return true
        case .unset:
            return true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension String{
    func isOverMaximun(type:Units) -> Bool{
        if type == .noSecond{
            if let double = Double(self){
                return double > 65535.0
            }
            return false
        }else if type == .second{
            if let double = Double(self){
                return double > 6553.5
            }
            return false
        }
        return false
    }

    
}



struct AssociatedKeys {
    static var toggleState: UInt8 = 0
}
extension UITextField {
    var units:Units{
        get{
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.toggleState) as? Units else {
                return .unset
            }
            return value
        }
        set(new){
           objc_setAssociatedObject(self, &AssociatedKeys.toggleState, new, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
enum Units {
    case second
    case noSecond
    case unset
}

