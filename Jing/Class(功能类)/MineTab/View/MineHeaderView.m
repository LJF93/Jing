//
//  MineHeaderView.m
//  Jing
//
//  Created by Mac on 2017/5/31.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "MineHeaderView.h"
#import "UIResponder+Router.h"

@interface MineHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIView *alphaView;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *userNameButton;
@property (weak, nonatomic) IBOutlet UIButton *managerButton;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;

@end

@implementation MineHeaderView

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat hspace = (self.frame.size.width - Main_Screen_Width) / 2.0f;
    CGFloat centx = self.frame.size.width / 2.0f;

    //背景视图
    self.backImageView.frame = CGRectMake(hspace, 0, Main_Screen_Width, self.frame.size.height);

    //节目管理
    self.managerButton.frame = CGRectMake(centx-10 - 104.0f, self.frame.size.height-36.0-37.0f, 104.0f, 37.0f);

    //录音按钮
    self.recordButton.frame = CGRectMake(centx+10, self.managerButton.frame.origin.y, 104.0f, 37.0f);

    //子标题
    self.subTitleLabel.frame = CGRectMake(centx-150.0f, self.recordButton.frame.origin.y-24.0f-15.0f, 300, 15);

    //点击登录按钮
    self.userNameButton.frame = CGRectMake(centx-100.0f, self.subTitleLabel.frame.origin.y-10-18.0, 200.0f, 18.0f);

    self.avatarImageView.frame = CGRectMake(centx-50.0, self.userNameButton.frame.origin.y-10-100.0, 100, 100);

    //设置按钮
    self.settingButton.frame = CGRectMake(hspace+4, self.avatarImageView.frame.origin.y-40, 40, 40);
}

- (IBAction)SettingAction:(id)sender {
    [self routerEvent:Event_Mine_Setting userInfo:sender];
}

@end
