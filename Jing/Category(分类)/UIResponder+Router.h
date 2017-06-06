//
//  UIResponder+Router.h
//  Jing
//
//  Created by Mac on 2017/6/1.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (Router)

- (void)routerEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end
