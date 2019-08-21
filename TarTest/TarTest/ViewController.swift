//
//  ViewController.swift
//  TarTest
//
//  Created by 陳鍵群 on 2019/1/18.
//  Copyright © 2019年 陳鍵群. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let dataPath = Bundle.main.path(forResource: "c", ofType: "tar.gz")!
        let fileManager = FileManager()
        let documentUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let toPath = documentUrl.appendingPathComponent("Models")
//        let toPath = Bundle.main.resourceURL!.appendingPathComponent("Untar").path
        let untarManager = UntarManager()
        untarManager.untar(dataPath, toPath.path)
        
        let imageUrl = toPath.appendingPathComponent("c.png")
        
        let check = try! imageUrl.checkResourceIsReachable()
        print(check)
        print(imageUrl)
        let imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        self.view.addSubview(imageView)
        let image1 = UIImage(contentsOfFile: imageUrl.path)
        imageView.image = image1
        
    }


}

