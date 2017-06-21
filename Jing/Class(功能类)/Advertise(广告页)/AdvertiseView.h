//
//  AdvertiseView.h
//  Jing
//
//  Created by Mac on 2017/4/27.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAdUserDefaults [NSUserDefaults standardUserDefaults]

static NSString *const AdvertiseImageKey = @"AdvertiseImageKey";

@interface AdvertiseView : UIView

/**
 广告图片路径
 */
@property (nonatomic, strong) NSString *filePath;

- (void)show;

@end
