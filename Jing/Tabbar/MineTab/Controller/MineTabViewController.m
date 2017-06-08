//
//  MineTabViewController.m
//  Jing
//
//  Created by Mac on 2017/5/27.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "MineTabViewController.h"
#import "MineHeaderView.h"
#import "SettingViewController.h"
#import "KnowledgeController.h"
#import "BaseKnowledgeController.h"
#import "SVWebViewController.h"

static NSString *const kFreeTraficURL = @"http://hybrid.ximalaya.com/api/telecom/index?app=iting&device=iPhone&impl=com.gemd.iting&telephone=%28null%29&version=5.4.27";

static NSString *const k0 = @"基础知识点";

static NSString *const k1 = @"知识点";
static NSString *const k2 = @"随便看";

static NSString *const k3 = @"设置";
static NSString *const k4 = @"免流量服务";
static NSString *const k5 = @"意见反馈";

static NSString *const k6 = @"喜马拉雅商城";
static NSString *const k7 = @"我的商城订单";
static NSString *const k8 = @"我的优惠券";
static NSString *const k9 = @"游戏中心";
static NSString *const k10 = @"智能硬件设备";

@interface MineTabViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) MineHeaderView *headerView;
@property (nonatomic, strong) NSArray *sectionsIcon;
@property (nonatomic, strong) NSArray *sectionsTitle;
@property (nonatomic, weak) UIView *statusBarView;

@end

@implementation MineTabViewController {
    BOOL _StatusBarLightFlag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _StatusBarLightFlag = YES;
    [self.tableView bringSubviewToFront:self.headerView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (_StatusBarLightFlag)
        return UIStatusBarStyleLightContent;
    else
        return UIStatusBarStyleDefault;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        tv.delegate = self;
        tv.dataSource = self;
        // ！！！！！！！！！！！
        // ！！！！！！！！！！！
        // ！！！！！！！！！！！
        [self.view addSubview:tv];
        // ！！！！！！！！！！！
        // ！！！！！！！！！！！
        // ！！！！！！！！！！！
        _tableView = tv;
    }
    return _tableView;
}

- (MineHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"MineHeaderView" owner:nil options:nil].lastObject;
//        _headerView.frame = CGRectMake(0, 0, Main_Screen_Width, HeaderViewHeight);
        self.tableView.tableHeaderView = [[MineHeaderView alloc] initWithFrame:_headerView.frame];
        [self.tableView addSubview:_headerView];
    }
    return _headerView;
}

- (UIView *)statusBarView {
    if (!_statusBarView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 20)];
        view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95f];
        [self.view addSubview:view];
        [self.view bringSubviewToFront:view];
        _statusBarView = view;
    }
    return _statusBarView;
}

- (NSArray *)sectionsIcon {
    if(!_sectionsIcon){
        _sectionsIcon = @[@[@"me_setting_favAlbum"],@[@"me_setting_playhis",@"me_setting_playhis"],@[@"me_setting_setting",@"me_setting_union",@"me_setting_feedback"],@[@"me_setting_store",@"me_setting_myorder",@"me_setting_coupon",@"me_setting_game",@"me_setting_device"]
                          ];
    }
    return _sectionsIcon;
}

- (NSArray *)sectionsTitle {
    if(!_sectionsTitle) {
        _sectionsTitle = @[@[k0],
                           @[k1, k2],
                           @[k3, k4, k5],
                           @[k6, k7, k8, k9, k10]
                           ];
    }
    return _sectionsTitle;
}

- (void)setStatusBarLight:(BOOL)flag {
    if (flag && _StatusBarLightFlag) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    else {
        _StatusBarLightFlag = NO;
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)trans2SettingVC {
    SettingViewController *vc = [[SettingViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIResponder
- (void)routerEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:Event_Mine_Setting]) {
        [self trans2SettingVC];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;

    if (offsetY <= 0) {
        self.headerView.frame = CGRectMake(0, offsetY, Main_Screen_Width, HeaderViewHeight - offsetY);
    }

    if (offsetY < 200) {
        self.statusBarView.alpha = 0.f;
        _StatusBarLightFlag = YES;
        [self setStatusBarLight:YES];
    }
    else if (offsetY >= 200 && offsetY < 220) {//状态栏背景色的渐变过程
//        [self.view bringSubviewToFront:self.statusBarView];
        self.statusBarView.alpha = (offsetY-200)/20;
    }
    else {
        self.statusBarView.alpha = 1.f;
//        [self.view bringSubviewToFront:self.statusBarView];
        [self setStatusBarLight:NO];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionsTitle[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionsTitle.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *subIcons = self.sectionsIcon[indexPath.section];
    NSArray *subTitles = self.sectionsTitle[indexPath.section];

    NSInteger index = indexPath.row;
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.imageView.image = [UIImage imageNamed:subIcons[index]];
    cell.textLabel.text = subTitles[index];
    cell.textLabel.font = [UIFont systemFontOfSize:15.f];
    cell.textLabel.textColor = [UIColor colorWithRed:0.00f green:0.00f blue:0.00f alpha:1.00f];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *str = cell.textLabel.text;

    if ([str isEqualToString:k0]) {
        BaseKnowledgeController *vc = [[BaseKnowledgeController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([str isEqualToString:k1]) {
        KnowledgeController *vc = [[KnowledgeController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([str isEqualToString:k3]) {
        [self trans2SettingVC];
        return;
    }
    else if ([str isEqualToString:k4]) {
        SVWebViewController *vc = [[SVWebViewController alloc] initWithAddress:kFreeTraficURL];
        vc.showToolBar = YES;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
