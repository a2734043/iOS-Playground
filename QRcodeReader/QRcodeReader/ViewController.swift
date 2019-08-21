//
//  ViewController.swift
//  QRcodeReader
//
//  Created by 陳鍵群 on 2017/11/2.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    var video = AVCaptureVideoPreviewLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create Session
        let session = AVCaptureSession()
        
        //Define Capture Device
        let captureDevice = AVCaptureDevice.default(for: .video)
        
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        }
        catch{
            print("ERROR")
        }
        //session.canAdd()
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
//        video.bounds = CGRect(x: 0, y: 0, width: 300, height: 300)
        
        
//        video.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        view.layer.addSublayer(video)
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

