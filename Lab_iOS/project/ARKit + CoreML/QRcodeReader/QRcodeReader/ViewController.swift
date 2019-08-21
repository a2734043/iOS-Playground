//
//  ViewController.swift
//  QRcodeReader
//
//  Created by 陳鍵群 on 2017/11/2.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

class ViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate,AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @IBOutlet weak var identityLabel: UILabel!
    var video = AVCaptureVideoPreviewLayer()
    var requests = [VNCoreMLRequest]()
    var classRequest:VNCoreMLRequest!
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.frame = CGRect.init(x: 50, y: 50, width: 300, height: 500)
        self.view.addSubview(imageView)
        //Create Session
        let session = AVCaptureSession()
        
        //Define Capture Device
        guard  let captureDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: AVMediaType.video, position: AVCaptureDevice.Position.back) else{
            return
        }
        //            AVCaptureDevice.default(for: .video)
        
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        }
        catch{
            print("ERROR")
        }
        
        //session.canAdd()
        //        let output = AVCaptureMetadataOutput()
        //        session.addOutput(output)
        //        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        //        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        let output = AVCaptureVideoDataOutput()
        
        output.setSampleBufferDelegate(self, queue: DispatchQueue.global())
        session.addOutput(output)
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        //        video.bounds = CGRect(x: 0, y: 0, width: 300, height: 300)
        
        
        //        video.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        //view.layer.addSublayer(video)
        //        self.view.layer.insertSublayer(video, at: 0)
        setupModel()
        
        session.startRunning()
        
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count != 0{
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject{
                if object.type == .qr{
                    let alert = UIAlertController(title: "QRcode", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        DispatchQueue.main.async {
            let ciImage = CIImage.init(cvPixelBuffer: pixelBuffer)
            let tempCiimage = ciImage.oriented(.right)
            let image = UIImage.init(ciImage: tempCiimage)
            self.imageView.image = image
        }
        
        //
        //        let handler =  VNImageRequestHandler.init(cvPixelBuffer: pixelBuffer, options: [:])
        //        do{
        //            try handler.perform([classRequest])
        //        }catch{
        //            print(error.localizedDescription)
        //        }
        
        
    }
    
    func setupModel(){
        guard let model = try? VNCoreMLModel.init(for: Inceptionv3().model) else {return}
        classRequest = VNCoreMLRequest.init(model: model, completionHandler: handleClassification(request:error:))
        classRequest.imageCropAndScaleOption = .centerCrop
        //        self.requests = [classrequest]
        
    }
    
    func handleClassification(request:VNRequest, error:Error?){
        guard error == nil else {
            print("Error:\(error?.localizedDescription)")
            return
        }
        
        guard let results = request.results  else {
            return
        }
        
        
        let observations = results.prefix(4).flatMap{($0 as? VNClassificationObservation)}.map{("\($0.identifier)- \(String(format:" %.2f", $0.confidence))" )}.joined(separator: "\n")
        print(observations)
        DispatchQueue.main.async {
            
            self.identityLabel.text = observations
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



