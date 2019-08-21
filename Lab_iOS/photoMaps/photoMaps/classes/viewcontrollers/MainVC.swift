//
//  MainVC.swift
//  photoMaps
//
//  Created by 陳鍵群 on 2017/11/8.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit
import Photos

class MainVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet var mainView: MainView!
//    var assetsFetchResults:PHFetchResult<PHAsset>?
    var assetsFetchResults = PHAsset.fetchAssets(with: nil)
    let size = CGSize(width: 50, height: 50)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.mainCVCell.delegate = self
        self.mainView.mainCVCell.dataSource = self
        PHPhotoLibrary.requestAuthorization { (status) in
            guard status == .authorized else{
                let alert = UIAlertController(title: "提示", message: "請允許取用你的相簿", preferredStyle: .alert)
                let setting = UIAlertAction(title: "設定", style: .cancel, handler: { action in
                    let allowAccess = URL(string: UIApplicationOpenSettingsURLString)
                    UIApplication.shared.open(allowAccess!, options: [:], completionHandler: nil)
                })
                let cancel = UIAlertAction(title: "好", style: .default, handler: nil)
                alert.addAction(setting)
                alert.addAction(cancel)
                self.present(alert, animated: true)
                return
            }
//            let options = PHFetchOptions()
//            options.sortDescriptors = [NSSortDescriptor(key: "creationDate",ascending: false)]
//            options.predicate = NSPredicate(format: "mediaType = %d",PHAssetMediaType.image.rawValue)
//            self.assetsFetchResults = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: options)
            
            print(self.assetsFetchResults.count)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assetsFetchResults.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MainCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell", for: indexPath) as! MainCVCell
        
        let asset = self.assetsFetchResults[indexPath.row]
        PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: nil) { (image, _: [AnyHashable : Any]? ) in
            cell.cellImage.image = image
            
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let assettoNext = self.assetsFetchResults[indexPath.row]
        performSegue(withIdentifier: "gotoSecondView", sender: assettoNext)
//        let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
//        secondVC.asset = assettoNext
//        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! SecondVC
        secondVC.asset = sender as! PHAsset
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
