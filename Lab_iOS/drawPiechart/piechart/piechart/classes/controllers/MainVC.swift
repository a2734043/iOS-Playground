//
//  MainVC.swift
//  piechart
//
//  Created by 陳鍵群 on 2017/11/17.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet var mainView: MainView!
    let layer_Red = CAShapeLayer()
    let layer_Green = CAShapeLayer()
    let layer_Blue = CAShapeLayer()
    let layer_Yellow = CAShapeLayer()
    let path = UIBezierPath()
    let circleCenter = CGPoint(x: 200, y: 500)
    let circleRadius:CGFloat = 125
    let pi = Float(Double.pi)
    var angle_Yellow:CGFloat?
    var angle_Red:CGFloat?
    var angle_Green:CGFloat?
    var angle_Blue:CGFloat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        angle_Yellow = 0
        angle_Red = CGFloat(pi * 0.5)
        angle_Green = CGFloat(pi)
        angle_Blue = CGFloat(pi * 1.5)
        
        updatePieChart()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeSlider_Red(_ sender: UISlider) {
        var greenValue = self.mainView.slider_Green.value
        var blueValue = self.mainView.slider_Blue.value
        var yellowValue = self.mainView.slider_Yellow.value
        var otherScale = greenValue + blueValue + yellowValue
        let otherAngle = (1 - sender.value)
        if otherScale == 0{
            greenValue = 1;blueValue = 1;yellowValue = 1;otherScale = 3
        }
        self.mainView.slider_Green.value = otherAngle * greenValue / otherScale
        self.mainView.slider_Blue.value = otherAngle * blueValue / otherScale
        self.mainView.slider_Yellow.value = otherAngle * yellowValue / otherScale
        angle_Red = CGFloat(2 * pi * sender.value)
        angle_Green = angle_Red! + CGFloat(2 * pi * otherAngle * greenValue / otherScale)
        angle_Blue = angle_Green! + CGFloat(2 * pi * otherAngle * blueValue / otherScale)
        angle_Yellow = angle_Blue! + CGFloat(2 * pi * otherAngle * yellowValue / otherScale)
        self.mainView.redScale.text = "\(sender.value * 100)%"
        self.mainView.greenScale.text = String(format: "%.2f", self.mainView.slider_Green.value * 100) + "%"
        self.mainView.blueScale.text = String(format: "%.2f", self.mainView.slider_Blue.value * 100) + "%"
        self.mainView.yellowScale.text = String(format: "%.2f", self.mainView.slider_Yellow.value * 100) + "%"
        updatePieChart()
    }
    
    @IBAction func changeSlider_Green(_ sender: UISlider) {
        var redValue = self.mainView.slider_Red.value
        var blueValue = self.mainView.slider_Blue.value
        var yellowValue = self.mainView.slider_Yellow.value
        var otherScale = redValue + blueValue + yellowValue
        let otherAngle = (1 - sender.value)
        if otherScale == 0{
            redValue = 1;blueValue = 1;yellowValue = 1;otherScale = 3
        }
        self.mainView.slider_Red.value = otherAngle * redValue / otherScale
        self.mainView.slider_Blue.value = otherAngle * blueValue / otherScale
        self.mainView.slider_Yellow.value = otherAngle * yellowValue / otherScale
        angle_Red = CGFloat(2 * pi * otherAngle * redValue / otherScale)
        angle_Green = angle_Red! + CGFloat(2 * pi * sender.value)
        angle_Blue = angle_Green! + CGFloat(2 * pi * otherAngle * blueValue / otherScale)
        angle_Yellow = angle_Blue! + CGFloat(2 * pi * otherAngle * yellowValue / otherScale)
        self.mainView.redScale.text = String(format: "%.2f", self.mainView.slider_Red.value * 100) + "%"
        self.mainView.greenScale.text = "\(sender.value * 100)%"
        self.mainView.blueScale.text = String(format: "%.2f", self.mainView.slider_Blue.value * 100) + "%"
        self.mainView.yellowScale.text = String(format: "%.2f", self.mainView.slider_Yellow.value * 100) + "%"
        updatePieChart()
    }
    
    @IBAction func changeSlider_Blue(_ sender: UISlider) {
        var redValue = self.mainView.slider_Red.value
        var greenValue = self.mainView.slider_Green.value
        var yellowValue = self.mainView.slider_Yellow.value
        var otherScale = redValue + greenValue + yellowValue
        let otherAngle = (1 - sender.value)
        if otherScale == 0{
            redValue = 1;greenValue = 1;yellowValue = 1;otherScale = 3
        }
        self.mainView.slider_Red.value = otherAngle * redValue / otherScale
        self.mainView.slider_Green.value = otherAngle * greenValue / otherScale
        self.mainView.slider_Yellow.value = otherAngle * yellowValue / otherScale
        angle_Red = CGFloat(2 * pi * otherAngle * redValue / otherScale)
        angle_Green = angle_Red! + CGFloat(2 * pi * otherAngle * greenValue / otherScale)
        angle_Blue = angle_Green! + CGFloat(2 * pi * sender.value)
        angle_Yellow = angle_Blue! + CGFloat(2 * pi * otherAngle * yellowValue / otherScale)
        self.mainView.redScale.text = String(format: "%.2f", self.mainView.slider_Red.value * 100) + "%"
        self.mainView.greenScale.text = String(format: "%.2f", self.mainView.slider_Green.value * 100) + "%"
        self.mainView.blueScale.text = "\(sender.value * 100)%"
        self.mainView.yellowScale.text = String(format: "%.2f", self.mainView.slider_Yellow.value * 100) + "%"
        updatePieChart()
    }
    
    @IBAction func changeSlider_Yellow(_ sender: UISlider) {
        var redValue = self.mainView.slider_Red.value
        var greenValue = self.mainView.slider_Green.value
        var blueValue = self.mainView.slider_Blue.value
        var otherScale = redValue + greenValue + blueValue
        let otherAngle = (1 - sender.value)
        if otherScale == 0{
            redValue = 1;greenValue = 1;blueValue = 1;otherScale = 3
        }
        self.mainView.slider_Red.value = otherAngle * redValue / otherScale
        self.mainView.slider_Green.value = otherAngle * greenValue / otherScale
        self.mainView.slider_Blue.value = otherAngle * blueValue / otherScale
        angle_Red = CGFloat(2 * pi * otherAngle * redValue / otherScale)
        angle_Green = angle_Red! + CGFloat(2 * pi * otherAngle * greenValue / otherScale)
        angle_Blue = angle_Green! + CGFloat(2 * pi * otherAngle * blueValue / otherScale)
        angle_Yellow = angle_Blue! + CGFloat(2 * pi * sender.value)
        self.mainView.redScale.text = String(format: "%.2f", self.mainView.slider_Red.value * 100) + "%"
        self.mainView.greenScale.text = String(format: "%.2f", self.mainView.slider_Green.value * 100) + "%"
        self.mainView.blueScale.text = String(format: "%.2f", self.mainView.slider_Blue.value * 100) + "%"
        self.mainView.yellowScale.text = "\(sender.value * 100)%"
        updatePieChart()
    }
    
    
    func updatePieChart(){
        path.move(to: circleCenter)
        path.addArc(withCenter: circleCenter, radius: circleRadius, startAngle: 0, endAngle: angle_Red!, clockwise: true)
        path.close()
        layer_Red.path = path.cgPath
        layer_Red.fillColor = UIColor.red.cgColor
        path.removeAllPoints()
        self.mainView.layer.addSublayer(layer_Red)
        
        
        path.move(to: circleCenter)
        path.addArc(withCenter: circleCenter, radius: circleRadius, startAngle: angle_Red!, endAngle: angle_Green!, clockwise: true)
        path.close()
        layer_Green.path = path.cgPath
        layer_Green.fillColor = UIColor.green.cgColor
        path.removeAllPoints()
        self.mainView.layer.addSublayer(layer_Green)
        
        
        path.move(to: circleCenter)
        path.addArc(withCenter: circleCenter, radius: circleRadius, startAngle: angle_Green!, endAngle: angle_Blue!, clockwise: true)
        path.close()
        layer_Blue.path = path.cgPath
        layer_Blue.fillColor = UIColor.blue.cgColor
        path.removeAllPoints()
        self.mainView.layer.addSublayer(layer_Blue)
        
        
        path.move(to: circleCenter)
        path.addArc(withCenter: circleCenter, radius: circleRadius, startAngle: angle_Blue!, endAngle: angle_Yellow!, clockwise: true)
        path.close()
        layer_Yellow.path = path.cgPath
        layer_Yellow.fillColor = UIColor.yellow.cgColor
        path.removeAllPoints()
        self.mainView.layer.addSublayer(layer_Yellow)
        
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
