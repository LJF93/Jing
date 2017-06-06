//
//  IntroductoryPageHelper.m
//  Jing
//
//  Created by Mac on 2017/4/26.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "IntroductoryPageHelper.h"
#import "IntroductoryPageView.h"

@interface IntroductoryPageHelper()

@property (nonatomic) UIWindow *rootView;
@property (nonatomic, strong) IntroductoryPageView *curIntroductoryPageView;

@end

@implementation IntroductoryPageHelper

+ (instancetype)sharedInstance {
    static IntroductoryPageHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedInstance = [[IntroductoryPageHelper alloc] init];
    });

    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

+ (void)showIntroductoryPageView: (NSArray *)images {
    if (![IntroductoryPageHelper sharedInstance].curIntroductoryPageView) {
        [IntroductoryPageHelper sharedInstance].curIntroductoryPageView = [[IntroductoryPageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) Images:images];
    }

    [IntroductoryPageHelper sharedInstance].rootView = [UIApplication sharedApplication].keyWindow;
    [[IntroductoryPageHelper sharedInstance].rootView addSubview:[IntroductoryPageHelper sharedInstance].curIntroductoryPageView];
}

@end
