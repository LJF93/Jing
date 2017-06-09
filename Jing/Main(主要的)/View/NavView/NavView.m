//
//  NavView.m
//  Jing
//
//  Created by Mac on 2017/6/8.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "NavView.h"

#define kTitleColorNormal [UIColor colorWithRed:0.40f green:0.40f blue:0.41f alpha:1.00f]
#define kTitleColorSelect [UIColor colorWithRed:0.86f green:0.39f blue:0.30f alpha:1.00f]

@interface NavView()

@property (nonatomic, weak) UIView *sliderView;

@property (nonatomic, weak) NSArray *titles;
@property (nonatomic, strong) NSMutableArray <UIButton *> *buttonArray;

@end

@implementation NavView

@synthesize subNavViewItemClick;

+ (instancetype)initNavViewWithTitles:(NSArray *)titles {
    NavView *view = [[NavView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
    view.titles = titles;

    [view titlesView];
    [view sliderView];

    return view;
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger count = self.titles.count;
    CGFloat btnWidth = Main_Screen_Width/count;
    for (int i=0; i<count; i++) {
        self.buttonArray[i].frame = CGRectMake(btnWidth*i, 0, btnWidth, 44);
    }

    self.sliderView.frame = CGRectMake(2, self.frame.size.height-2, btnWidth-2*2, 2);
}

- (void)titlesView {
    self.buttonArray = [[NSMutableArray alloc] init];
    for (int i=0; i<self.titles.count; i++) {
        NSString *title = self.titles[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:kTitleColorNormal forState:UIControlStateNormal];
        [btn setTitleColor:kTitleColorSelect forState:UIControlStateSelected];
        [btn setTitleColor:kTitleColorSelect forState:UIControlStateHighlighted | UIControlStateSelected];
        [btn setTitle:title forState:UIControlStateNormal];
        if (i==0) {
            btn.selected = YES;
        }
        [btn addTarget:self action:@selector(subButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
        [self addSubview:btn];
        [self.buttonArray addObject:btn];
    }
}

- (UIView *)sliderView {
    if (!_sliderView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = kTitleColorSelect;
        [self addSubview:view];
        _sliderView = view;
    }
    return _sliderView;
}

- (void)trans2ControllerAtIndex:(NSInteger)index {
    UIButton *btn = [self.buttonArray objectAtIndex:index];
    btn.selected = YES;
    [self unSelectedOtherBtn:btn];
    [self sliderViewAnimation:btn];
}

- (void)subButtonSelected:(UIButton *)senderBtn{
    senderBtn.selected = YES;
    [self unSelectedOtherBtn:senderBtn];
    [self sliderViewAnimation:senderBtn];
    
    if (subNavViewItemClick) {
        subNavViewItemClick(self, senderBtn.tag-100);
    }
}

- (void)unSelectedOtherBtn:(UIButton *)btn {
    [self.buttonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop){
        if ([btn isKindOfClass:[UIButton class]] && obj != btn) {
            ((UIButton *)obj).selected = NO;
        }
    }];
}

- (void)sliderViewAnimation:(UIButton *)btn {
    [UIView animateWithDuration:0.25f animations:^{
        CGRect frame = self.sliderView.frame;
        frame.origin.x = btn.frame.origin.x+2;
        //！！！！！！！！！！！！！！//
        self.sliderView.frame = frame;
        //！！！！！！！！！！！！！！//
    }];
}

@end
