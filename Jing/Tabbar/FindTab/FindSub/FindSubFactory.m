//
//  FindSubFactory.m
//  Jing
//
//  Created by Mac on 2017/6/5.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "FindSubFactory.h"
#import "FindRecommendController.h"
#import "FindSub2Controller.h"
#import "FindSub3Controller.h"
#import "FindSub4Controller.h"
#import "FindSub5Controller.h"

@implementation FindSubFactory

+ (FindBaseViewController *)findSubViewControllerWithIdentifier:(NSString *)identifier {

    FindSubType type = [FindSubFactory typeWithIdentifier:identifier];

    FindBaseViewController *viewController = nil;
    if (type == FindSubTypeRecommend) {
        viewController = [[FindRecommendController alloc] init];
    }
    else if (type == FindSubTypeCategory) {
        viewController = [[FindSub2Controller alloc] init];
    }
    else if (type == FindSubTypeRadio) {
        viewController = [[FindSub3Controller alloc] init];
    }
    else if (type == FindSubTypeRank) {
        viewController = [[FindSub4Controller alloc] init];
    }
    else if (type == FindSubTypeAnchor) {
        viewController = [[FindSub5Controller alloc] init];
    }
    else {
        viewController = [[FindBaseViewController alloc] init];
    }

    return viewController;
}

+ (FindSubType)typeWithIdentifier:(NSString *)str {
    if ([str isEqualToString:@"推荐"]) {
        return FindSubTypeRecommend;
    }
    else if([str isEqualToString:@"分类"]) {
        return FindSubTypeCategory;
    }
    else if([str isEqualToString:@"广播"]) {
        return FindSubTypeRadio;
    }
    else if([str isEqualToString:@"榜单"]) {
        return FindSubTypeRank;
    }
    else if([str isEqualToString:@"主播"]) {
        return FindSubTypeAnchor;
    }
    else {
        return FindSubTypeUnknown;
    }
}

@end
