//
//  MainView.m
//  ObjcTest
//
//  Created by 陳鍵群 on 2018/4/18.
//  Copyright © 2018年 陳鍵群. All rights reserved.
//

#import "MainView.h"

@implementation MainView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = UIColor.whiteColor;
        
        UILabel *heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 100, 25)];
        heightLabel.text = @"身高(m)";
        [self addSubview:heightLabel];
        UILabel *weightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, 100, 25)];
        weightLabel.text = @"體重(kg)";
        [self addSubview:weightLabel];
        
        self.heightTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 25, 100, 25)];
        [self.heightTextField setBorderStyle:UITextBorderStyleRoundedRect];
        [self addSubview:self.heightTextField];
        self.weightTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 75, 100, 25)];
        [self.weightTextField setBorderStyle:UITextBorderStyleRoundedRect];
        [self addSubview:self.weightTextField];
        
        self.calculateButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 50, 50, 50)];
        [self.calculateButton setTitleColor:UIColor.blueColor forState:normal];
        [self.calculateButton setTitle:@"計算" forState:normal];
        [self addSubview:self.calculateButton];
        
        self.resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 125, 200, 25)];
        self.resultLabel.text = @"結果：";
        [self addSubview:self.resultLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
