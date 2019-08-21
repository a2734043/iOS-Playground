//
//  UntarManager.m
//  TarTest
//
//  Created by 陳鍵群 on 2019/1/18.
//  Copyright © 2019年 陳鍵群. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UntarManager.h"
#import "DCTar.h"

@implementation UntarManager

-(void) untar: (NSString*)dataPath : (NSString*)toPath {
    NSLog(@"%@",dataPath);
    NSLog(@"%@",toPath);
    [DCTar decompressFileAtPath:dataPath toPath:toPath error:nil];
}

@end

