//
//  BaseNavigationViewController.m
//  Jing
//
//  Created by Mac on 2017/5/19.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }

    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
