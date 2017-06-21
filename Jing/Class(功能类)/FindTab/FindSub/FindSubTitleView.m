//
//  FindSubTitleView.m
//  Jing
//
//  Created by Mac on 2017/6/5.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "FindSubTitleView.h"

#define kSystemOriginColor [UIColor colorWithRed:0.96f green:0.39f blue:0.26f alpha:1.00f]
#define kSystemBlackColor  [UIColor colorWithRed:0.38f green:0.39f blue:0.40f alpha:1.00f]

@interface FindSubTitleView()

@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, weak) UIView *sliderView;
@property (nonatomic, weak) UIButton *currentSelectedButton;

@end

@implementation FindSubTitleView

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)setTitleArray:(NSMutableArray *)titleArray {
    _titleArray = titleArray;
    [self configView];
}

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}

- (UIView *)sliderView {
    if (!_sliderView) {
        UIView *view = [UIView new];
        view.backgroundColor = kSystemOriginColor;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.mas_left);
            make.bottom.equalTo(self.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(30, 2));
        }];
        _sliderView = view;
    }
    return _sliderView;
}

- (void)configView {

    self.backgroundColor = [UIColor whiteColor];

    NSUInteger count = _titleArray.count;
    CGFloat btnWidth = Main_Screen_Width / count;

    for (int i = 0; i<count; i++) {
        NSString *title = _titleArray[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:kSystemOriginColor forState:UIControlStateSelected];
        [btn setTitleColor:kSystemBlackColor forState:UIControlStateNormal];
        [btn setTitleColor:kSystemOriginColor forState:UIControlStateHighlighted | UIControlStateSelected];
        [btn setFrame:CGRectMake(btnWidth*i, 0, btnWidth, 38)];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.adjustsImageWhenHighlighted = NO;
        [btn addTarget:self action:@selector(subTitleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:btn];
        [self addSubview:btn];
    }
    
    UIButton *firstBtn = [self.btnArray firstObject];
    [self selectedAtButton:firstBtn isFirstStart:YES];
}

- (void)subTitleBtnClick:(UIButton *)btn {
    if (btn == self.currentSelectedButton) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(findSubTitleViewDidSelected:atIndex:title:)]) {
        [self.delegate findSubTitleViewDidSelected:btn atIndex:[self.btnArray indexOfObject:btn] title:btn.titleLabel.text];
    }

    [self selectedAtButton:btn isFirstStart:NO];
}

- (void)trans2ShowAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.btnArray.count) {
        return;
    }

    UIButton *btn = [self.btnArray objectAtIndex:index];
    [self selectedAtButton:btn isFirstStart:NO];
}

- (void)selectedAtButton:(UIButton *)btn isFirstStart:(BOOL)first{
    btn.selected = YES;
    self.currentSelectedButton = btn;
    [self.sliderView mas_updateConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.mas_left).offset(btn.frame.origin.x + btn.frame.size.width/2-15);
    }];
    if(!first) {
        [UIView animateWithDuration:0.25 animations:^{
            [self layoutIfNeeded];
        }];
    }
    [self unselectedAllButton:btn];
}

- (void)unselectedAllButton:(UIButton *)senderBtn {
    for (UIButton *btn in self.btnArray) {
        if (btn == senderBtn) {
            continue;
        }
        btn.selected = NO;
    }
}

@end
