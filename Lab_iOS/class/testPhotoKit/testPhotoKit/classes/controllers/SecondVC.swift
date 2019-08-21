//
//  SecondVC.swift
//  testPhotoKit
//
//  Created by 陳鍵群 on 2017/12/25.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit
import Photos

class SecondVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var assetFetchResults:PHFetchResult<PHAsset>?
    var imageManager:PHCachingImageManager!
    
    @IBOutlet var secondView: SecondView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.secondView.collectionView.delegate = self
        self.secondView.collectionView.dataSource = self
        self.imageManager = PHCachingImageManager()
        let manager = PHImageManager()
        manager.requestAVAsset(forVideo: <#T##PHAsset#>, options: <#T##PHVideoRequestOptions?#>) { (<#AVAsset?#>, <#AVAudioMix?#>, <#[AnyHashable : Any]?#>) in
            <#code#>
        }
        self.imageManager.requestAVAsset(forVideo: <#T##PHAsset#>, options: <#T##PHVideoRequestOptions?#>, resultHandler: <#T##(AVAsset?, AVAudioMix?, [AnyHashable : Any]?) -> Void#>)

        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (assetFetchResults?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = assetFetchResults![indexPath.row]
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as! CollectionViewCell
        self.imageManager.requestImage(for: asset, targetSize: cell.imageView.frame.size, contentMode: .aspectFit, options: nil) { (image, _: [AnyHashable : Any]? ) in
            cell.imageView.image = image
        }
        return cell
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
