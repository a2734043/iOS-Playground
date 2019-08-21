//
//  MainVC.swift
//  PiechartFourPart
//
//  Created by 陳鍵群 on 2017/11/24.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet var mainView: MainView!
    var slideValue_Red:Float = 0.25
    var slideValue_Green:Float = 0.25
    var slideValue_Blue:Float = 0.25
    var slideValue_Yellow:Float = 0.25    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePieChart(redValue: slideValue_Red, greenValue: slideValue_Green, blueValue: slideValue_Blue, yellowValue: slideValue_Yellow)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func slide(_ sender: UISlider) {
        switch sender.tag {
        case 1:
            determineScale(orginalValue: slideValue_Red, slideValue: sender.value, otherValue1: slideValue_Green, otherValue2: slideValue_Blue, otherValue3: slideValue_Yellow, tag: 1)
        case 2:
            determineScale(orginalValue: slideValue_Green, slideValue: sender.value, otherValue1: slideValue_Red, otherValue2: slideValue_Blue, otherValue3: slideValue_Yellow, tag: 2)
        case 3:
            determineScale(orginalValue: slideValue_Blue, slideValue: sender.value, otherValue1: slideValue_Red, otherValue2: slideValue_Green, otherValue3: slideValue_Yellow, tag: 3)
        default:
            determineScale(orginalValue: slideValue_Yellow, slideValue: sender.value, otherValue1: slideValue_Red, otherValue2: slideValue_Green, otherValue3: slideValue_Blue, tag: 4)
        }
    }
    
    //依滑動決定其他顏色的值
    func determineScale(orginalValue:Float,slideValue:Float,otherValue1:Float,otherValue2:Float,otherValue3:Float,tag:Int){
        var beChangedValue1 = otherValue1
        var beChangedValue2 = otherValue2
        var beChangedValue3 = otherValue3
        if slideValue > orginalValue{
            let gap = slideValue - orginalValue
            if otherValue1 == 0{
                if otherValue2 == 0{
                    beChangedValue3 = beChangedValue3 - gap
                }else if otherValue3 == 0{
                    beChangedValue2 = beChangedValue2 - gap
                }else{
                    beChangedValue2 = beChangedValue2 - gap/2
                    beChangedValue3 = beChangedValue3 - gap/2
                    if beChangedValue2 < 0{
                        beChangedValue3 = beChangedValue3 + beChangedValue2
                        beChangedValue2 = 0
                    }else if beChangedValue3 < 0{
                        beChangedValue2 = beChangedValue2 + beChangedValue3
                        beChangedValue3 = 0
                    }
                }
            }else if otherValue2 == 0{
                if otherValue3 == 0{
                    beChangedValue1 = beChangedValue1 - gap
                }else{
                    beChangedValue1 = beChangedValue1 - gap/2
                    beChangedValue3 = beChangedValue3 - gap/2
                    if beChangedValue1 < 0{
                        beChangedValue3 = beChangedValue3 + beChangedValue1
                        beChangedValue1 = 0
                    }else if beChangedValue3 < 0{
                        beChangedValue1 = beChangedValue1 + beChangedValue3
                        beChangedValue3 = 0
                    }
                }
            }else if otherValue3 == 0{
                beChangedValue1 = beChangedValue1 - gap/2
                beChangedValue2 = beChangedValue2 - gap/2
                if beChangedValue1 < 0{
                    beChangedValue2 = beChangedValue2 + beChangedValue1
                    beChangedValue1 = 0
                }else if beChangedValue2 < 0{
                    beChangedValue1 = beChangedValue1 + beChangedValue2
                    beChangedValue2 = 0
                }
            }else{
                beChangedValue1 = beChangedValue1 - gap/3
                beChangedValue2 = beChangedValue2 - gap/3
                beChangedValue3 = beChangedValue3 - gap/3
                if beChangedValue1 < 0{
                    if beChangedValue2 < 0{
                        beChangedValue3 = beChangedValue3 + beChangedValue1 + beChangedValue2
                        beChangedValue1 = 0;beChangedValue2 = 0
                    }else{
                        if beChangedValue3 < 0{
                            beChangedValue2 = beChangedValue2 + beChangedValue1 + beChangedValue3
                            beChangedValue1 = 0;beChangedValue3 = 0
                        }else{
                            beChangedValue2 = beChangedValue2 + (beChangedValue1*(-1)/2)
                            beChangedValue3 = beChangedValue3 + (beChangedValue1*(-1)/2)
                            beChangedValue1 = 0
                        }
                    }
                }else if beChangedValue2 < 0{
                    if beChangedValue3 < 0{
                        beChangedValue1 = beChangedValue1 + beChangedValue2 + beChangedValue3
                        beChangedValue2 = 0;beChangedValue3 = 0
                    }else{
                        beChangedValue1 = beChangedValue1 + (beChangedValue2*(-1)/2)
                        beChangedValue3 = beChangedValue3 + (beChangedValue2*(-1)/2)
                        beChangedValue2 = 0
                    }
                }else if beChangedValue3 < 0{
                    beChangedValue1 = beChangedValue1 + (beChangedValue3*(-1)/2)
                    beChangedValue2 = beChangedValue2 + (beChangedValue3*(-1)/2)
                    beChangedValue3 = 0
                }
            }
        }else if orginalValue > slideValue{
            let gap = orginalValue - slideValue
            beChangedValue1 = beChangedValue1 + gap/3
            beChangedValue2 = beChangedValue2 + gap/3
            beChangedValue3 = beChangedValue3 + gap/3
        }
        if slideValue == 1{
            beChangedValue1 = 0;beChangedValue2 = 0;beChangedValue3 = 0
        }
        switch tag {
        case 1:
            setValue(red: slideValue, green: beChangedValue1, blue: beChangedValue2, yellow: beChangedValue3)
        case 2:
            setValue(red: beChangedValue1, green: slideValue, blue: beChangedValue2, yellow: beChangedValue3)
        case 3:
            setValue(red: beChangedValue1, green: beChangedValue2, blue: slideValue, yellow: beChangedValue3)
        default:
            setValue(red: beChangedValue1, green: beChangedValue2, blue: beChangedValue3, yellow: slideValue)
        }
    }
    
    //設定元件的數值並傳給畫圖的function
    func setValue(red:Float,green:Float,blue:Float,yellow:Float){
        self.mainView.redRate.text = String(format: "%.2f", red * 100) + "%"
        self.mainView.greenRate.text = String(format: "%.2f", green * 100) + "%"
        self.mainView.blueRate.text = String(format: "%.2f", blue * 100) + "%"
        self.mainView.yellowRate.text = String(format: "%.2f", yellow * 100) + "%"
        self.mainView.redSlider.setValue(red, animated: true)
        self.mainView.greenSlider.setValue(green, animated: true)
        self.mainView.blueSlider.setValue(blue, animated: true)
        self.mainView.yellowSlider.setValue(yellow, animated: true)
        slideValue_Red = red
        slideValue_Green = green
        slideValue_Blue = blue
        slideValue_Yellow = yellow
        updatePieChart(redValue: red, greenValue: green, blueValue: blue, yellowValue: yellow)
        print("red : \(slideValue_Red)")
        print("green : \(slideValue_Green)")
        print("blue : \(slideValue_Blue)")
        print("yellow : \(slideValue_Yellow)")
        print("total : \(slideValue_Red+slideValue_Green+slideValue_Blue+slideValue_Yellow)\n")
    }
    
    //MARK:畫圓餅圖
    func updatePieChart(redValue:Float,greenValue:Float,blueValue:Float,yellowValue:Float){
        let redLayer = CAShapeLayer()
        let greenLayer = CAShapeLayer()
        let blueLayer = CAShapeLayer()
        let yellowLayer = CAShapeLayer()
        let path = UIBezierPath()
        let circleCenter = CGPoint(x: 200, y: 500)
        let circleRadius = CGFloat(100)
        redLayer.name = "WillBeRemoved"
        greenLayer.name = "WillBeRemoved"
        blueLayer.name = "WillBeRemoved"
        yellowLayer.name = "WillBeRemoved"
        let redAngle = CGFloat(Float(Double.pi*2) * redValue)
        let greenAngle = redAngle + CGFloat(Float(Double.pi*2) * greenValue)
        let blueAngle = greenAngle + CGFloat(Float(Double.pi*2) * blueValue)
        let yellowAngle = blueAngle + CGFloat(Float(Double.pi*2) * yellowValue)
        let layerType = LayerType.willBeRemoved
        
        //MARK:清除Layer
        self.mainView.layer.sublayers?.forEach({ (layer) in
            if layer.name == layerType.rawValue{
                layer.removeFromSuperlayer()
            }
        })
        
        
        //red
        path.move(to: circleCenter)
        path.addArc(withCenter: circleCenter, radius: circleRadius, startAngle: 0, endAngle: redAngle, clockwise: true)
        path.close()
        redLayer.path = path.cgPath
        redLayer.fillColor = UIColor.red.cgColor
        path.removeAllPoints()
        self.mainView.layer.addSublayer(redLayer)
        //green
        path.move(to: circleCenter)
        path.addArc(withCenter: circleCenter, radius: circleRadius, startAngle: redAngle, endAngle: greenAngle, clockwise: true)
        path.close()
        greenLayer.path = path.cgPath
        greenLayer.fillColor = UIColor.green.cgColor
        path.removeAllPoints()
        self.mainView.layer.addSublayer(greenLayer)
        //blue
        path.move(to: circleCenter)
        path.addArc(withCenter: circleCenter, radius: circleRadius, startAngle: greenAngle, endAngle: blueAngle, clockwise: true)
        path.close()
        blueLayer.path = path.cgPath
        blueLayer.fillColor = UIColor.blue.cgColor
        path.removeAllPoints()
        self.mainView.layer.addSublayer(blueLayer)
        //yellow
        path.move(to: circleCenter)
        path.addArc(withCenter: circleCenter, radius: circleRadius, startAngle: blueAngle, endAngle: yellowAngle, clockwise: true)
        path.close()
        yellowLayer.path = path.cgPath
        yellowLayer.fillColor = UIColor.yellow.cgColor
        path.removeAllPoints()
        self.mainView.layer.addSublayer(yellowLayer)
    }
    
    enum LayerType:String {
        case willBeRemoved = "WillBeRemoved"
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
