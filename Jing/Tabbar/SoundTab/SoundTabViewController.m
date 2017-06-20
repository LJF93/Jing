//
//  SoundTabViewController.m
//  Jing
//
//  Created by Mac on 2017/5/19.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "SoundTabViewController.h"
#import "NavView.h"
#import "FindSubFactory.h"
#import "FindBaseViewController.h"
#import "DYRecomController.h"
#import "DYSubscriptionController.h"
#import "DYHistoryController.h"

@interface SoundTabViewController()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) NavView *navView;

@property (nonatomic, strong) NSArray *titles, *controllers;

@property (nonatomic, weak) UIPageViewController *pageViewController;

@end

@implementation SoundTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.navView;

    [self configPageView];
}

- (void)configPageView {
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
}

- (NavView *)navView {
    if (!_navView) {
        _navView = [NavView initNavViewWithTitles:self.titles];
        __weak typeof (self) weakSelf = self;
        [_navView setSubNavViewItemClick:^(NavView *view, NSInteger index){
            [weakSelf subControllerWithIndex:index];
        }];
    }
    return _navView;
}

- (UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationNone] forKey:UIPageViewControllerOptionSpineLocationKey];
        UIPageViewController *page = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:dic];
        page.delegate = self;
        page.dataSource = self;
        //！！！！！！！！！！！！！！！！！！！！//
//        [page willMoveToParentViewController:self];
        //！！！！！！！！！！！！！！！！！！！！//
        [self.view addSubview:page.view];
        [self addChildViewController:page];
        [page setViewControllers:@[self.controllers.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        _pageViewController = page;
    }
    return _pageViewController;
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = [[NSArray alloc] init];
        _titles = [NSArray arrayWithObjects:@"推荐",@"订阅",@"历史", nil];
    }
    return _titles;
}

- (NSArray *)controllers {
    if (!_controllers) {
        _controllers = [[NSArray alloc] init];
        _controllers = @[[[DYRecomController alloc] init],
                         [[DYSubscriptionController alloc] init],
                         [[DYHistoryController alloc] init]
                         ];
    }
    return _controllers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)subControllerWithIndex:(NSInteger)index {
    [self.pageViewController setViewControllers:@[self.controllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (NSInteger)indexWithController:(UIViewController *)controller {
    return [self.controllers indexOfObject:controller];
}

#pragma mark - UIPageViewControllerDelegate & UIPageViewControllerDataSource
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.controllers.count;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    UIViewController *controller = self.pageViewController.viewControllers.firstObject;
    NSInteger index = [self indexWithController:controller];
    [self.navView trans2ControllerAtIndex:index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self indexWithController:viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    return [self.controllers objectAtIndex:index-1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self indexWithController:viewController];
    if (index == self.controllers.count-1 || index == NSNotFound) {
        return nil;
    }
    return [self.controllers objectAtIndex:index+1];
}

@end

