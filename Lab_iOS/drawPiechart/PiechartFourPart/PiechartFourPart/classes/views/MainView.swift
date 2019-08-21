//
//  MainView.swift
//  PiechartFourPart
//
//  Created by 陳鍵群 on 2017/11/24.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit

class MainView: UIView {
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var yellowSlider: UISlider!
    
    @IBOutlet weak var redRate: UILabel!
    @IBOutlet weak var greenRate: UILabel!
    @IBOutlet weak var blueRate: UILabel!
    @IBOutlet weak var yellowRate: UILabel!
    
    override func awakeFromNib() {
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
