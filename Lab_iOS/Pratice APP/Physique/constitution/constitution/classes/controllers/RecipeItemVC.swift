//
//  RecipeItemVC.swift
//  constitution
//
//  Created by 陳鍵群 on 2017/8/9.
//  Copyright © 2017年 陳鍵群. All rights reserved.
//

import UIKit

class RecipeItemVC: UIViewController {
    @IBOutlet var recipeItemView: RecipeItemView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.recipeItemView.dishImage.image = #imageLiteral(resourceName: "pic1")
        self.recipeItemView.materialTitleLabel.text = "材料："
        self.recipeItemView.materialLabel.text = "【材料】\n甜豆碗半碗、白飯一碗、紫高麗菜(切小片)半碗、豬肉片四片～六片、新鮮核桃\n【調味料】\n薑汁醬油、蠔油"
        self.recipeItemView.wayTitleLabel.text = "作法："
        self.recipeItemView.wayLabel.text = "【作法】\nＡ甜豆莢燙熟切小塊，紫高麗菜切小塊，肉片用薑汁醬油醃十五分鐘。\nＢ燒熱平底鍋，倒入些許薑汁醬油，肉片炒熟後盛起備用，在鍋中加入甜豆莢拌炒後，再將肉片與米飯加入鍋中。\nＣ為了維持紫高麗菜的口感與風味，最後再加入拌炒一下馬上關火。起鍋後可加點搗碎的核桃莉裝飾題味"

        // Do any additional setup after loading the view.
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
