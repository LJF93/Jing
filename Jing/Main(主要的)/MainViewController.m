//
//  MainViewController.m
//  Jing
//
//  Created by Mac on 2017/4/26.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "MainViewController.h"
#import "BaseNavigationViewController.h"

#define FindStory           @"Find"
#define SoundStory        @"Sound"
#define PlayStory            @"Play"
#define DownloadStory   @"Download"
#define MineStory           @"Mine"

@interface MainViewController()<UITabBarControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *controllerArray;

@end

@implementation MainViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createTabBar];
    }
    return self;
}

- (void)createTabBar {
    self.tabBarItemsAttributes = [self tabBarItemAttributesForController];

    [self configViewControllers];

    self.moreNavigationController.navigationBarHidden = YES;//隐藏掉系统自动添加的moreNavigationController的导航栏，即点击more按钮显示的那个页面。
}

- (void)configViewControllers {
    NSMutableArray *arr = [NSMutableArray new];
    [self.controllerArray enumerateObjectsUsingBlock:^(NSString *identifier, NSUInteger index, BOOL * _Nonnull stop){
        BaseNavigationViewController *navi = [self navigationControllerWithIdentifier:identifier];
        navi.delegate = self;
        [arr addObject:navi];
    }];
    self.viewControllers = arr;
}

- (NSArray *)tabBarItemAttributesForController {

    NSDictionary *findTabBarItemsAttributes = @{
                                                 CYLTabBarItemImage : @"tabbar_find_n",
                                                 CYLTabBarItemSelectedImage : @"tabbar_find_h",
                                                 };
    NSDictionary *soundTabBarItemsAttributes = @{
                                                  CYLTabBarItemImage : @"tabbar_sound_n",
                                                  CYLTabBarItemSelectedImage : @"tabbar_sound_h",
                                                  };
    NSDictionary *playTabBarItemsAttributes = @{
                                                 CYLTabBarItemImage : @"tabbar_np_playnon",
                                                 CYLTabBarItemSelectedImage : @"tabbar_np_playnon",
                                                 };
    NSDictionary *downloadTabBarItemsAttributes = @{
                                                 CYLTabBarItemImage : @"tabbar_download_n",
                                                 CYLTabBarItemSelectedImage : @"tabbar_download_h",
                                                 };
    NSDictionary *meTabBarItemsAttributes = @{
                                                 CYLTabBarItemImage : @"tabbar_me_n",
                                                 CYLTabBarItemSelectedImage : @"tabbar_me_h",
                                                 };
    NSArray *tabBarItemsAttributes = @[
                                       findTabBarItemsAttributes,
                                       soundTabBarItemsAttributes,
                                       playTabBarItemsAttributes,
                                       downloadTabBarItemsAttributes,
                                       meTabBarItemsAttributes
                                       ];

    return tabBarItemsAttributes;
}

- (NSArray *)controllerArray {
    if (!_controllerArray) {
        _controllerArray = @[FindStory, SoundStory, PlayStory, DownloadStory, MineStory];
    }
    return _controllerArray;
}

/**
 *  根据StoryBoard的名称生成控制器
 */
- (BaseNavigationViewController *)navigationControllerWithIdentifier:(NSString *)identifier {
    BaseNavigationViewController *nav = [[UIStoryboard storyboardWithName:identifier bundle:nil] instantiateInitialViewController];
    return nav;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

@end
