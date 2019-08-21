//
//  SecondVC.swift
//  photoMaps
//
//  Created by 陳鍵群 on 2017/11/8.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit
import Photos

class SecondVC: UIViewController {

    var asset:PHAsset!
    @IBOutlet var secondView: SecondView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.secondView.text.text = "日期：\(asset.creationDate!)\n"
            + "類型：\(asset.mediaType.rawValue)\n"
            + "位置：\(String(describing: asset.location))\n"
            + "時間：\(asset.duration)\n"
        
        PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: nil) { (image, a) in
            self.secondView.image.image = image
            
        }
        
        
        
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
