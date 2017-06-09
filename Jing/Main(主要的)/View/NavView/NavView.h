//
//  NavView.h
//  Jing
//
//  Created by Mac on 2017/6/8.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavView : UIView

@property (nonatomic, strong) void(^subNavViewItemClick)(NavView *view, NSInteger index);

- (void)trans2ControllerAtIndex:(NSInteger)index;

+ (instancetype)initNavViewWithTitles:(NSArray *)titles;

@end
