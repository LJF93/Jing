//
//  FindSubTitleView.h
//  Jing
//
//  Created by Mac on 2017/6/5.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FindSubTitleViewIndexDelegate <NSObject>

- (void)findSubTitleViewDidSelected:(UIButton *)btn atIndex:(NSInteger)index title:(NSString *)title;

@end

@interface FindSubTitleView : UIView

/**
 *  字标题视图的数据源
 */
@property (nonatomic, strong) NSMutableArray<NSString *> *titleArray;

@property (nonatomic, weak) id<FindSubTitleViewIndexDelegate> delegate;

- (void)trans2ShowAtIndex:(NSInteger)index;

@end
