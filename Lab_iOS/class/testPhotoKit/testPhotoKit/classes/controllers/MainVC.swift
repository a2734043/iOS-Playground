//
//  MainVC.swift
//  testPhotoKit
//
//  Created by 陳鍵群 on 2017/12/18.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit
import Photos

class MainVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var mainView: MainView!
    var albums:[Album] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.tableView.dataSource = self
        self.mainView.tableView.delegate = self
        
        PHPhotoLibrary.requestAuthorization { (status) in
            guard status == PHAuthorizationStatus.authorized else{
                return
            }
            let options = PHFetchOptions()
            let smartAlbum = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.albumRegular, options: options)
            self.convertCollectionsToAlbums(collections: smartAlbum)
            DispatchQueue.main.async(execute: {
                self.mainView.tableView.reloadData()
            })
            
        }
        
        // Do any additional setup after loading the view.
    }

    
    func convertCollectionsToAlbums(collections:PHFetchResult<PHAssetCollection>){
        let resultsOptions = PHFetchOptions()
        resultsOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
//        resultsOptions.predicate = NSPredicate(format: "mediaType = %d",PHAssetMediaType.video.rawValue)
        for i in 0 ..< collections.count{
            let collection = collections[i]
            let assetsFetchResult = PHAsset.fetchAssets(in: collection, options: resultsOptions)
            albums.append(Album(title: collection.localizedTitle, fetchResult: assetsFetchResult))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        let album = albums[indexPath.row]
        cell.textLabel?.text = album.title
        cell.detailTextLabel?.text = "\(album.fetchResult.count)張照片"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DisplayImage", sender: indexPath.row)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC:SecondVC = segue.destination as! SecondVC
        secondVC.assetFetchResults = albums[sender as! Int].fetchResult
        
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

//NEW一個Album類別
class Album {
    var title:String?
    var fetchResult:PHFetchResult<PHAsset>
    init(title:String?,fetchResult:PHFetchResult<PHAsset>) {
        self.title = title
        self.fetchResult = fetchResult
    }
}

