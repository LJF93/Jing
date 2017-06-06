//
//  AppDelegate.m
//  Jing
//
//  Created by Mac on 2017/4/26.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "IntroductoryPageHelper.h"
#import "AdvertiseHelper.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    MainViewController *viewController = [[MainViewController alloc] init];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];

    // 加载引导页面
    [self setupIntroductoryPage];

    // 加载广告页面(最后添加，确保显示在UIWindow的最上层！！！)
    [self setupAdvertiseView];

    //键盘统一收回处理
    [self configureBoardManager];

    NSString *pathString = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"pathString:\n%@", pathString);

    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

#pragma mark 引导页
- (void)setupIntroductoryPage {
    if (BBUserDefault.isNoFirstLaunch) {
        return;
    }
    [BBUserDefault setIsNoFirstLaunch:YES];

    NSArray *images = @[@"introductoryPage1",
                        @"introductoryPage2",
                        @"introductoryPage3",
                        @"introductoryPage4"];
    [IntroductoryPageHelper showIntroductoryPageView:images];
}

#pragma mark 广告页
- (void)setupAdvertiseView {
    NSArray *imageArray = @[@"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg",
                            @"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png",
                            @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg",
                            @"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg"];
    [AdvertiseHelper showAdvertiseView:imageArray];
}

#pragma mark 键盘收回管理
- (void)configureBoardManager {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.keyboardDistanceFromTextField=60;
    manager.enableAutoToolbar = NO;
}

@end
