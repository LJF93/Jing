//
//  UIViewController+Swizzlng.m
//  Jing
//
//  Created by Mac on 2017/5/23.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "UIViewController+Swizzlng.h"
#import <objc/runtime.h>

@implementation UIViewController (Swizzlng)

//load方法会在类第一次加载的时候被调用,调用的时间比较靠前。当类或分类被添加进运行时机制时就会调用。
//适合在这个方法里做方法交换,方法交换应该被保证在程序中只会执行一次。
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        Class selfClass = [self class];
        SEL oriSel = @selector(viewWillAppear:);
        Method oriMethod = class_getInstanceMethod(selfClass, oriSel);

        //需要替换成能够输出日志的viewWillAppear
        SEL currSel = @selector(logViewWillAppear:);
        Method currMethod = class_getInstanceMethod(selfClass, currSel);

        BOOL addSuccess = class_addMethod(selfClass,
                                          oriSel,
                                          method_getImplementation(currMethod),
                                          method_getTypeEncoding(currMethod)
                                          );
        if (addSuccess) {
            class_replaceMethod(selfClass, currSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }
        else {
            //两方法进行交换
            method_exchangeImplementations(oriMethod, currMethod);
        }
    });
}

- (void)logViewWillAppear:(BOOL)animated {
    NSString *classNameString = NSStringFromClass([self class]);
    if (![classNameString hasPrefix:@"Base"] && ![classNameString hasPrefix:@"Main"]) {
        NSLog(@"当前控制器为：%@", classNameString);
    }

    //下面方法的调用，其实是调用viewWillAppear
    [self logViewWillAppear:animated];
}

@end
