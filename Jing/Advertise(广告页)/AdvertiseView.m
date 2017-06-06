//
//  AdvertiseView.m
//  Jing
//
//  Created by Mac on 2017/4/27.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "AdvertiseView.h"

static NSInteger const showTime = 3;

@interface AdvertiseView()

@property (nonatomic, strong) UIImageView *adImageView;
@property (nonatomic, strong) UIButton *skipBtn;

@property (nonatomic, assign) NSInteger countTime;

@property (nonatomic, strong) NSTimer *countdownTimer;

@end

@implementation AdvertiseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _adImageView = [[UIImageView alloc] initWithFrame:frame];
        _adImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _adImageView.contentMode = UIViewContentModeScaleAspectFill;
        _adImageView.clipsToBounds = YES;
        _adImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAD)];
        [_adImageView addGestureRecognizer:tap];

        _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipBtn.frame = CGRectMake(Main_Screen_Width-80, 64+20, 60, 28);
        _skipBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _skipBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
        _skipBtn.layer.cornerRadius = 4;
        [_skipBtn setTitle:[NSString stringWithFormat:@"跳过%ld", (long)showTime] forState:UIControlStateNormal];
        [_skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_skipBtn addTarget:self action:@selector(dismissAdvertiseView) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:_adImageView];
        [self addSubview:_skipBtn];

    }
    return self;
}

- (void)setFilePath:(NSString *)filePath {
    _filePath = filePath;
    _adImageView.image = [UIImage imageWithContentsOfFile:filePath];
}

- (NSTimer *)countdownTimer {
    if (!_countdownTimer) {
        _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    }
    return _countdownTimer;
}

- (void)countdown {
    _countTime --;
    [_skipBtn setTitle:[NSString stringWithFormat:@"跳过%ld", (long)_countTime] forState:UIControlStateNormal];

    if (_countTime <= 0) {
        [_countdownTimer invalidate];
        _countdownTimer = nil;
        [self dismissAdvertiseView];
    }
}

- (void)show{

    [self startTimer];

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

/**
 开始倒计时
 */
- (void)startTimer {
    _countTime = showTime;
    [[NSRunLoop currentRunLoop] addTimer:self.countdownTimer forMode:NSDefaultRunLoopMode];
}

- (void)pushToAD {
    [self dismissAdvertiseView];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationContants_Advertise_Key" object:nil userInfo:nil];
}

- (void)dismissAdvertiseView {
    [self removeFromSuperview];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
