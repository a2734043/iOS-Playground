//
//  ViewController.swift
//  WebViewTest
//
//  Created by 陳鍵群 on 2018/1/24.
//  Copyright © 2018年 陳鍵群. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKUIDelegate,WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var webInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.webInput.text = String(describing: webView.url!)
        
    }

    @IBAction func goBackBtnTap(_ sender: Any) {
        //跳至safari
        if let url = URL(string:"https://www.google.com.tw/") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
        self.webView.goBack()
    }
    
    @IBAction func goToBtnTap(_ sender: Any) {
        let url = self.webInput.text
        let request = URLRequest.init(url: URL.init(string: url!)! )
        self.webView.load(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

