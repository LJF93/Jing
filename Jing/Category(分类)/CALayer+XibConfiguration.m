//
//  CALayer+XibConfiguration.m
//  Jing
//
//  Created by Mac on 2017/6/1.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)

//- (void)setBorderColor:(UIColor *)borderColor {
//    self.borderColor = borderColor.CGColor;
//}
//
//- (UIColor *)borderColor {
//    return [UIColor colorWithCGColor:self.borderColor];
//}

- (void)setBorderColorFromUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

@end
