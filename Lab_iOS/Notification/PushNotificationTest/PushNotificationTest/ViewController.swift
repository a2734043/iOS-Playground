//
//  ViewController.swift
//  PushNotificationTest
//
//  Created by 陳鍵群 on 2018/1/22.
//  Copyright © 2018年 陳鍵群. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func notificationTap(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.body = "your Notification"
        content.title = "Message"
        content.badge = 1
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

