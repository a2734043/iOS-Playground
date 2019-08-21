//
//  VC.swift
//  Flashlight
//
//  Created by 陳鍵群 on 2017/10/30.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit

class VC: UIViewController {

    @IBOutlet var views: Views!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func slider(_ sender: Any) {
        updateUI()
    }
    
    @IBAction func switchtap(_ sender: Any) {
        updateUI()
    }
    
    @IBAction func changecolor(_ sender: Any) {
        updateUI()
    }
    func updateUI(){
        if self.views.switchs.isOn{
            self.views.flashlightview.alpha = CGFloat(self.views.sliders.value)
            switch self.views.segmentcontroller.selectedSegmentIndex{
            case 0:
                self.views.flashlightview.backgroundColor = UIColor.white
            case 1:
                self.views.flashlightview.backgroundColor = UIColor.yellow
            case 2:
                self.views.flashlightview.backgroundColor = UIColor.red
            default:
                self.views.flashlightview.backgroundColor = UIColor.white
            }
        }else{
            self.views.flashlightview.alpha = 0
        }
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
