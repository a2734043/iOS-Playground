//
//  MainVC.swift
//  FoodMap
//
//  Created by 陳鍵群 on 2017/12/20.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit
import GoogleMaps
import AVFoundation
import Photos
import RealmSwift
import Alamofire

class MainVC: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet var mainView: MainView!
    @IBOutlet var uploadImageView: UploadImageView!
    let locationManager = CLLocationManager()
    var presentLoc : CLLocationCoordinate2D?
    var uploadLoc : CLLocationCoordinate2D?
    var image : UIImage?
    var userAccount = ""
    var password = ""
    var token = ""
    var imageUrl:URL?

    //MARK:viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.mapView.delegate = self
        self.locationManager.delegate = self
        let camera = GMSCameraPosition.camera(withLatitude: 24.151352,longitude: 120.683554,zoom: 10)
        self.mainView.mapView.camera = camera
        self.mainView.mapView.isMyLocationEnabled = true
        
        // Do any additional setup after loading the view.
    }
    //MARK:viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.mainView.itemView.layer.cornerRadius = 10
        self.mainView.itemView.layer.masksToBounds = true
        locationManager.requestLocation()
        //地圖資訊
        ApiTask.getMapApi { (response) in
            response.datas.forEach({ (data) in
                self.recieveImage(image_url: data.images[0], name: data.name, description: data.description, lat: data.lat, lng: data.lng)
            })
        }
        //使用者資訊
        let realm = try! Realm()
        if let user = realm.objects(userInfo.self).first{
            userAccount = user.account
            password = user.password
        }
        //uploadImageView
        self.uploadImageView.center = self.mainView.center
        self.mainView.addSubview(self.uploadImageView)
        self.uploadImageView.isHidden = true
    }
    //MARK:viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    //MARK:userInfo
    @IBAction func informationTap(_ sender: Any) {
        
        if userAccount == ""{
            AlertTask.alertLoginNotYet(title: "尚未登入", message: "登入上傳照片並檢視資訊", delegate: self)
        }else{
            ApiTask.authApi(email: userAccount, password: password) { (response) in
                guard response.status == "success" else{
                    return
                }
                self.token = "bearer \(response.token)"
                self.performSegue(withIdentifier: "userInfo", sender: self.token)
            }
        }
    }
    
    //MARK:choosePhotoTap
    @IBAction func choosePhotoTap(_ sender: UIButton) {
        guard userAccount != "" else{
            AlertTask.alertLoginNotYet(title: "尚未登入", message: "登入上傳照片並檢視資訊", delegate: self)
            return
        }
        ApiTask.authApi(email: userAccount, password: password) { (response) in
            guard response.status == "success" else{
                return
            }
            self.token = "bearer \(response.token)"
        }
        guard checkGPSandAllow() && presentLoc != nil else{
            return
        }

//        let cameraAuth:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
//        guard cameraAuth == .authorized else{
//            AlertTask.alertGotoAPPSetting(title: "提示", message: "請允許取用你的相機", delegate: self)
//            return
//        }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image  = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            return
        }
        self.uploadLoc = self.presentLoc
        self.uploadImageView.imageView.image = image

        picker.dismiss(animated: true) {
            self.buildImage(image: image)
            self.uploadImageView.isHidden = false
        }
    }
    @IBAction func cancelBtnTap(_ sender: Any) {
        self.uploadImageView.isHidden = true
    }
    
    @IBAction func uploadBtnTap(_ sender: Any) {
        ApiTask.uploadImage(token: token, name: self.uploadImageView.storeNameText.text!, description: self.uploadImageView.descriptionText.text!, lat: (uploadLoc?.latitude)!, lng: (uploadLoc?.longitude)! ){ (response) in
//            print("========================")
//            print(response.imageUrl)
//            print("圖片位置")
            ApiTask.uploadToStroage(api: response.imageUrl[0], image: self.imageUrl!, completion: { (response) in
                print(response[0].origin)
            })
        }
        self.tapMarker(lat: uploadLoc!.latitude, lng: uploadLoc!.longitude, image: self.uploadImageView.imageView.image!, name: self.uploadImageView.storeNameText.text!, description: self.uploadImageView.descriptionText.text!)
        self.uploadImageView.isHidden = true
    }
    
    
    //MARK:updateLocationTap
    @IBAction func updateLocationTap(_ sender: UIButton) {
        guard checkGPSandAllow() && presentLoc != nil else{
            return
        }
        let camera = GMSCameraPosition.camera(withLatitude: (presentLoc?.latitude)!,longitude:(presentLoc?.longitude)!,zoom: 12)
        self.mainView.mapView.animate(to: camera)
        
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        performSegue(withIdentifier: "showPicture", sender: marker)
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        presentLoc = locations.first?.coordinate
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("call request")
        if checkGPSandAllow(){
            self.locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    //MARK:tapMarker
    func tapMarker(lat:Double,lng:Double,image:UIImage,name:String,description:String){
        let marker = GMSMarker()
        marker.title = name
        marker.snippet = description
        marker.position.latitude = lat
        marker.position.longitude = lng
        marker.appearAnimation = .pop
        marker.map = self.mainView.mapView
        let markerview = UIImageView(frame:CGRect(x: 0, y: 0, width: 50, height: 50))
        markerview.image = image
        marker.iconView = markerview
    }
    
    //MARK:checkGPSandAllow
    func checkGPSandAllow() -> Bool{
        if CLLocationManager.locationServicesEnabled(){
            if CLLocationManager.authorizationStatus() == .notDetermined || CLLocationManager.authorizationStatus() == .denied{
                AlertTask.alertGotoAPPSetting(title: "提示", message: "請允許取用你的位置", delegate: self)
            }else{
                return true
            }
        }else{
            AlertTask.alertGotoSetting(title: "已關閉定位服務", message: "開啟設定>「隱私權」>「定位服務」來允許確認你目前的位置", delegate: self)
        }
        return false
    }
    
    func buildImage(image:UIImage) {
        //取得路徑
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        //檔名
        let interval = Date.timeIntervalSinceReferenceDate
        let name = "\(interval).png"
        let url = docUrl?.appendingPathComponent(name)
        //把圖片存在手機裡
        let data = UIImageJPEGRepresentation(image, 0.1)
        try! data?.write(to: url!)
        
        imageUrl = url
    }
    
    //MARK:Url接下照片
    func recieveImage(image_url:String,name:String,description:String,lat:Double,lng:Double){
        Alamofire.request(image_url, method: .get).responseData { (response) in
            let data = response.result.value
            let image = UIImage(data: data! as Data)
            var location:CLLocationCoordinate2D?
            location?.latitude = lat
            location?.longitude = lng
            
            if let picture = image{
                self.tapMarker(lat: lat, lng: lng, image: picture, name: name, description: description)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userInfo"{
            let userInfoVC = segue.destination as! UserInfoVC
            userInfoVC.token = sender as! String
        }else if segue.identifier == "showPicture"{
            let showPictureVC = segue.destination as! ShowPictureVC
            showPictureVC.marker = sender as! GMSMarker
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


