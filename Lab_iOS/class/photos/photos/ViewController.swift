//
//  ViewController.swift
//  photos
//
//  Created by 陳鍵群 on 2017/12/18.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit




class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func choosePhoto(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }
    
    @IBAction func choseCamera(_ sender: UIButton) {
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

