//
//  ViewController.swift
//  ZipTest
//
//  Created by 陳鍵群 on 2019/1/19.
//  Copyright © 2019年 陳鍵群. All rights reserved.
//

import UIKit
import SSZipArchive
import Zip

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        self.view.addSubview(imageView)
        
        let fileManager = FileManager()
        let documentUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let toUrl = documentUrl.appendingPathComponent("Models")
        
        print("documentUrl:\(documentUrl)")
        print("toUrl:\(toUrl)")
        
        do {
            let filePath = Bundle.main.url(forResource: "aaa", withExtension: "zip")!
            print("filePath:\(filePath)")
            let unzipDirectory = try Zip.quickUnzipFile(filePath) // Unzip
            print("unzipDirectory:\(unzipDirectory)")
            let file = unzipDirectory.appendingPathComponent("aaa/b.png")
            let image1 = UIImage(contentsOfFile: file.path)
            imageView.image = image1
        }
        catch {
            print("Something went wrong")
        }
        print(Bundle.main.bundlePath)
        // Do any additional setup after loading the view, typically from a nib.
    }


}

