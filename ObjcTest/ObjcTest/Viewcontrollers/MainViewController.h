//
//  MainViewController.h
//  ObjcTest
//
//  Created by 陳鍵群 on 2018/4/18.
//  Copyright © 2018年 陳鍵群. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainView.h"
@interface MainViewController : UIViewController
@property (nonatomic,strong)MainView *mainView;

-(void)calculateButtonTap;

@end
