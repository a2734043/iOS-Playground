//
//  ShowPictureVC.swift
//  FoodMap
//
//  Created by 陳鍵群 on 2018/1/4.
//  Copyright © 2018年 陳鍵群. All rights reserved.
//

import UIKit
import GoogleMaps

class ShowPictureVC: UIViewController {
    @IBOutlet var showPictureView: ShowPictureView!
    var marker:GMSMarker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = (marker.iconView as! UIImageView).image
        self.showPictureView.imageView.image = image
        self.showPictureView.storeName.text = marker.title
        self.showPictureView.storeDescription.text = marker.snippet
        // Do any additional setup after loading the view.
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
