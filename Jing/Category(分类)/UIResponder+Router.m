//
//  UIResponder+Router.m
//  Jing
//
//  Created by Mac on 2017/6/1.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    [self.nextResponder routerEvent:eventName userInfo:userInfo];
}

@end
