//
//  ViewController.swift
//  segue1113
//
//  Created by 陳鍵群 on 2017/11/13.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit

class BlueCell: UITableViewCell{
    @IBOutlet weak var labels: UILabel!
    
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var firstTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstTV.delegate = self
        self.firstTV.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row)%2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.detailTextLabel?.text = "項目\(indexPath.row)"
            return cell
        }else{
            let cell2: BlueCell = tableView.dequeueReusableCell(withIdentifier: "blueCell", for: indexPath) as! BlueCell
            cell2.labels.text = "\(indexPath.row)"
            return cell2
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("press \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "gotoVC2", sender: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

