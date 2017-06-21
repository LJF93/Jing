//
//  FindTabViewController.m
//  Jing
//
//  Created by Mac on 2017/5/24.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "FindTabViewController.h"
#import "FindSubTitleView.h"
#import "FindSubFactory.h"
#import "FindBaseViewController.h"

#define kXMLYBGGray [UIColor colorWithRed:0.92f green:0.93f blue:0.93f alpha:1.00f]

@interface FindTabViewController () <UIPageViewControllerDelegate,UIPageViewControllerDataSource, FindSubTitleViewIndexDelegate>

@property (weak, nonatomic) IBOutlet FindSubTitleView *subTitleView;
@property (nonatomic, strong) NSMutableArray     *subTitleArray;
@property (nonatomic, strong) NSMutableArray     *controllers;
@property (nonatomic, weak) UIPageViewController *pageViewController;

@end

@implementation FindTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kXMLYBGGray;
    self.subTitleView.delegate = self;
    self.subTitleView.titleArray = self.subTitleArray;
    [self configSubViews];
}

- (void)configSubViews {
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.subTitleView.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
}

#pragma mark - FindSubTitleViewIndexDelegate
- (void)findSubTitleViewDidSelected:(UIButton *)btn atIndex:(NSInteger)index title:(NSString *)title {
    [self.pageViewController setViewControllers:@[[self.controllers objectAtIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

#pragma mark - UIPageViewControllerDelegate/UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self indexForViewController:viewController];
    if (index <= 0 || index == NSNotFound) {

        return nil;
    }
    return [self.controllers objectAtIndex:index - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self indexForViewController:viewController];
    if (index > self.controllers.count-1 || index == NSNotFound) {
        return nil;
    }
    return [self.controllers objectAtIndex:index + 1];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.controllers.count;
}

//- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
//    UIViewController *con = pendingViewControllers.firstObject;
//    NSInteger index = [self indexForViewController:con];
//    [self.subTitleView trans2ShowAtIndex:index];
//}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    UIViewController *viewcontroller = self.pageViewController.viewControllers[0];
    NSInteger index = [self indexForViewController:viewcontroller];
    [self.subTitleView trans2ShowAtIndex:index];
}

#pragma mark - private
- (NSInteger)indexForViewController:(UIViewController *)controller {
    return [self.controllers indexOfObject:controller];
}

#pragma mark - getter
- (UIPageViewController *)pageViewController {
    if(!_pageViewController) {
        NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationNone] forKey:UIPageViewControllerOptionSpineLocationKey];
        UIPageViewController *page = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        page.delegate = self;
        page.dataSource = self;
        [page setViewControllers:@[[self.controllers firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        [self addChildViewController:page];
        [self.view addSubview:page.view];
        _pageViewController = page;
    }
    return _pageViewController;
}

- (NSMutableArray *)controllers {
    if(!_controllers) {
        _controllers = [[NSMutableArray alloc] init];
        for(NSString *title in self.subTitleArray) {
            FindBaseViewController *con = [FindSubFactory findSubViewControllerWithIdentifier:title];
            [_controllers addObject:con];
        }
    }
    return _controllers;
}

/**
 *  分类标题数组
 */
- (NSMutableArray *)subTitleArray {
    if(!_subTitleArray) {
        _subTitleArray = [[NSMutableArray alloc] initWithObjects:@"推荐",@"分类",@"广播",@"榜单",@"主播",nil];
    }
    return _subTitleArray;
}

@end
