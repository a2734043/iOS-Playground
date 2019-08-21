//
//  MainViewController.swift
//  HamburgerTest
//
//  Created by 陳鍵群 on 2019/1/18.
//  Copyright © 2019年 陳鍵群. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    let viewControllers: [String:UIViewController] = ["Setting":SettingViewController(), "Introduce":IntroduceViewController(), "Choose":ChooseViewController()]
    lazy var settingsLauncher: SettingsLauncher = {
        let settingLauncher = SettingsLauncher()
        settingLauncher.mainViewController = self
        return settingLauncher
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let mainView = UIView(frame: view.bounds)
        mainView.backgroundColor = UIColor.white
        self.view = mainView
        let leftScreenEdgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgePan(_:)))
        leftScreenEdgeGesture.edges = .left
        self.view.addGestureRecognizer(leftScreenEdgeGesture)
        let hamburger = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(hamburgerAction))
        self.navigationItem.leftBarButtonItem = hamburger
        

        // Do any additional setup after loading the view.
    }
    
    @objc func screenEdgePan(_ sender:UIScreenEdgePanGestureRecognizer){
        switch sender.state {
        case .began:
            print("began")
            print(sender.location(in: self.view))
        case .changed:
            _ = sender.location(in: self.view)
        //            print("changes")
        case .ended:
            print("ended")
            settingsLauncher.showSettings()
        default:
            break
        }
    }
    
    @objc func hamburgerAction(){
        settingsLauncher.showSettings()
    }
    
    func pushViewController(viewController:String){
        let nextViewController = self.viewControllers[viewController]!
        navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.pushViewController(nextViewController, animated: false)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
