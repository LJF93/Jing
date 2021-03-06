//
//  IntroductoryPageView.m
//  Jing
//
//  Created by Mac on 2017/4/27.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "IntroductoryPageView.h"
#import "Utils.h"

@interface IntroductoryPageView() <UIScrollViewDelegate>

@property (nonatomic) NSArray *imageArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation IntroductoryPageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame Images:(NSArray *)imageArray {
    if (self = [super initWithFrame:frame]) {
        self.imageArray = imageArray;
        [self loadPageView];
    }
    return self;
}

- (void)loadPageView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    scrollView.contentSize = CGSizeMake(Main_Screen_Width * (_imageArray.count), Main_Screen_Height);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self addSubview:scrollView];

    _scrollView = scrollView;

//    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"introductoryPage" ofType:@"bundle"];
//    NSArray *arrays = [fileManager contentsOfDirectoryAtPath:path error:nil];

    NSString *imagePath = @"";
    for (int i = 0; i < _imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(i * Main_Screen_Width, 0, Main_Screen_Width, Main_Screen_Height);
        if ([self is3xImage]) {
            imagePath = [path stringByAppendingFormat:@"/%@@3x.png", _imageArray[i]];
        }
        else
            imagePath = [path stringByAppendingFormat:@"/%@@2x.png", _imageArray[i]];

        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        imageView.image = image;

        [scrollView addSubview:imageView];
    }

    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(Main_Screen_Width/2, Main_Screen_Height-60, 0, 40)];
    pageControl.numberOfPages = _imageArray.count;
    [self addSubview:pageControl];

    _pageControl = pageControl;

    //添加手势
    UITapGestureRecognizer *singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapFrom)];
    singleRecognizer.numberOfTapsRequired = 1;
    [scrollView addGestureRecognizer:singleRecognizer];
}

- (void)handleSingleTapFrom {
    if (_pageControl.currentPage == _imageArray.count - 1) {
        [self removeFromSuperview];
    }
}

- (BOOL)is3xImage {
    NSString *mobile = [Utils getCurrentDeviceModel];
    if ([mobile isEqualToString:iPhone6Plus] ||
        [mobile isEqualToString:iPhone6sPlus] ||
        [mobile isEqualToString:iPhone7Plus]) {
        return YES;
    }
    return NO;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _scrollView) {
        CGPoint offset = scrollView.contentOffset;
        _pageControl.currentPage = offset.x / self.bounds.size.width;// 计算当前页
        [_scrollView setContentOffset:CGPointMake(self.bounds.size.width * _pageControl.currentPage, scrollView.contentOffset.y) animated:YES];
    }

    if (scrollView.contentOffset.x == _imageArray.count * Main_Screen_Width) {
        [self removeFromSuperview];
    }
}

@end
