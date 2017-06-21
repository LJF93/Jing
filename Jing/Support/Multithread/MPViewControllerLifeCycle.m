//
//  MPViewControllerLifeCycle.m
//  MobileProject
//
//  Created by wujunyang on 2016/11/10.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "MPViewControllerLifeCycle.h"

@interface MPViewControllerLifeCycle ()

@property(nonatomic,strong) UIView *redView, *yellowView;

@end

@implementation MPViewControllerLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"第一个VC viewDidLoad");

    self.view.backgroundColor = [UIColor whiteColor];
    
    if (!self.redView) {
        self.redView = [[UIView alloc]init];
        self.redView.backgroundColor = [UIColor redColor];
        self.redView.frame = CGRectMake(110, 164, 100, 100);
        [self.view addSubview:self.redView];
    }
    
    if (!self.yellowView) {
        self.yellowView = [[UIView alloc]init];
        self.yellowView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:self.yellowView];
    }
    
    NSLog(@"redView当前的坐标：: %@",NSStringFromCGRect(self.redView.frame));
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"第一个VC viewWillAppear");
    
    NSLog(@"redView当前的坐标：: %@",NSStringFromCGRect(self.redView.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"第一个VC didReceiveMemoryWarning");
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    NSLog(@"第一个VC viewWillDisappear");
}

-(void)loadView
{
    [super loadView];
    NSLog(@"第一个VC loadView");
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    NSLog(@"第一个VC viewWillLayoutSubviews");
    
    NSLog(@"redView当前的坐标：: %@",NSStringFromCGRect(self.redView.frame));
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSLog(@"第一个VC viewDidLayoutSubviews");
    
    NSLog(@"redView当前的坐标：: %@",NSStringFromCGRect(self.redView.frame));
    
    NSLog(@"---------------");
    NSLog(@"坐标值，要到viewDidLayoutSubviews 才正确。根视图的大小改变了，子视图必须相应做出调整才可以正确显示，这就是为什么要在 viewDidLayoutSubviews 中调整动态视图的frame");
    NSLog(@"---------------");
    
    CGRect redViewFrame = self.redView.frame;
    
    CGFloat yellowViewY = CGRectGetMaxY(redViewFrame)+20;
    redViewFrame.origin.y = yellowViewY;
    
    self.yellowView.frame = redViewFrame;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    NSLog(@"第一个VC viewDidAppear");
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    NSLog(@"第一个VC viewDidDisappear");
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"第一个VC awakeFromNib");
}

#pragma mark 重写BaseViewController设置内容

//设置导航栏背景色
-(UIColor*)set_colorBackground
{
    return [UIColor whiteColor];
}

//是否隐藏导航栏底部的黑线 默认也为NO
-(BOOL)hideNavigationBottomLine
{
    return NO;
}

////设置标题
-(NSMutableAttributedString*)setTitle
{
    return [self changeTitle:@"ViewController生命周期"];
}

//设置左边按键
-(UIButton*)set_leftButton
{
    UIButton *left_button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [left_button setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [left_button setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateHighlighted];
    return left_button;
}

//设置左边事件
-(void)left_button_event:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 自定义代码

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x333333) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:CHINESE_SYSTEM(18) range:NSMakeRange(0, title.length)];
    return title;
}

@end
