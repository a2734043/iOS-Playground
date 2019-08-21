//
//  MainViewController.m
//  ObjcTest
//
//  Created by 陳鍵群 on 2018/4/18.
//  Copyright © 2018年 陳鍵群. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainView = [[MainView alloc] initWithFrame:self.view.frame];
    self.view = self.mainView;
    self.mainView.heightTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.mainView.weightTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.mainView.calculateButton addTarget:self action:@selector(calculateButtonTap) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)calculateButtonTap{
    double height = [self.mainView.heightTextField.text doubleValue];
    double weight = [self.mainView.weightTextField.text doubleValue];
    double result = 0.0;
    result = weight / pow(height, 2.0);
    self.mainView.resultLabel.text = [NSString stringWithFormat:@"結果：%f",result];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
