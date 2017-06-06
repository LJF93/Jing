//
//  FindSubFactory.h
//  Jing
//
//  Created by Mac on 2017/6/5.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FindBaseViewController.h"

typedef NS_ENUM(NSInteger, FindSubType){
    FindSubTypeRecommend   =   0,  //推荐
    FindSubTypeCategory    =   1,  //分类
    FindSubTypeRadio       =   2,  //广播
    FindSubTypeRank        =   3,  //榜单
    FindSubTypeAnchor      =   4,  //主播
    FindSubTypeUnknown     =   5,  //未知
};

@interface FindSubFactory : NSObject

+ (FindBaseViewController *)findSubViewControllerWithIdentifier:(NSString *)identifier;

@end
