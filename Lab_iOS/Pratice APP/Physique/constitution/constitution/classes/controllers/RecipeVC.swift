//
//  RecipeVC.swift
//  constitution
//
//  Created by 陳鍵群 on 2017/8/9.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit

class RecipeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var recipeView: RecipeView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recipeView.recipeTV.delegate = self
        self.recipeView.recipeTV.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 99
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RecipeTVCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! RecipeTVCell
        cell.accessoryType = .disclosureIndicator
        cell.recipeLabel.text = "繽紛炒飯"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "selectcell", sender: nil)
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
