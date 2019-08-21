//
//  SettingLauncher.swift
//  HamburgerTest
//
//  Created by 陳鍵群 on 2019/1/22.
//  Copyright © 2019年 陳鍵群. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject, UITableViewDataSource, UITableViewDelegate {
    var mainViewController: MainViewController?
    let setting = ["Setting","Introduce","Choose"]
    let width: CGFloat = 200
    let blackView = UIView()
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.backgroundColor = UIColor.white
        tv.separatorStyle = .none
        return tv
    }()
    
    override init() {
        super.init()
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBlackView)))
            window.addSubview(blackView)
            window.addSubview(tableView)
            tableView.frame = CGRect(x: -width, y: 0, width: width, height: window.frame.height)
            blackView.frame = window.frame
            blackView.alpha = 0
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "cell")
        //start doing something here maybe....
    }

    
    func showSettings() {
        //show menu
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 1
            self.tableView.frame.origin = CGPoint(x: 0, y: 0)
//            self.tableView.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height)
        }, completion: nil)
    }
    
    @objc func tapBlackView(){
        handleDismiss("")
    }
    
    func handleDismiss(_ viewController:String) {
        print(viewController)
        UIView.animate(withDuration: 0.5
            , animations: {
                self.blackView.alpha = 0
                self.tableView.frame.origin = CGPoint(x: -self.width, y: 0)
//                if let window = UIApplication.shared.keyWindow {
//                    self.tableView.frame = CGRect(x: -200, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height)
//                    print(window)
//                }
        }) { (_) in
            if viewController != ""{
                self.mainViewController?.pushViewController(viewController: viewController)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingTableViewCell
        cell.textLabel?.text = setting[indexPath.row]
        cell.detailTextLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleDismiss(setting[indexPath.row])
    }
}
