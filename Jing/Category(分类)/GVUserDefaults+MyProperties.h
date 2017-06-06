//
//  GVUserDefaults+MyProperties.h
//  Jing
//
//  Created by Mac on 2017/4/26.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "GVUserDefaults.h"

#define BBUserDefault [GVUserDefaults standardUserDefaults]

@interface GVUserDefaults (MyProperties)

#pragma mark --是否是第一次启动APP程序
@property (nonatomic,assign) BOOL isNoFirstLaunch;

@end
