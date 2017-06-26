//
//  Utils.m
//  Jing
//
//  Created by Mac on 2017/6/26.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "Utils.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "Macros.h"

@implementation Utils

+ (NSString *)getCurrentDeviceModel {
    int mib[2];
    size_t len;
    char *machine;

    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);

    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return iPhone2G;
    if ([platform isEqualToString:@"iPhone1,2"]) return iPhone3G;
    if ([platform isEqualToString:@"iPhone2,1"]) return iPhone3GS;
    if ([platform isEqualToString:@"iPhone3,1"]) return iPhone4;
    if ([platform isEqualToString:@"iPhone3,2"]) return iPhone4;
    if ([platform isEqualToString:@"iPhone3,3"]) return iPhone4;
    if ([platform isEqualToString:@"iPhone4,1"]) return iPhone4S;
    if ([platform isEqualToString:@"iPhone5,1"]) return iPhone5;
    if ([platform isEqualToString:@"iPhone5,2"]) return iPhone5;
    if ([platform isEqualToString:@"iPhone5,3"]) return iPhone5c;
    if ([platform isEqualToString:@"iPhone5,4"]) return iPhone5c;
    if ([platform isEqualToString:@"iPhone6,1"]) return iPhone5s;
    if ([platform isEqualToString:@"iPhone6,2"]) return iPhone5s;
    if ([platform isEqualToString:@"iPhone7,2"]) return iPhone6;
    if ([platform isEqualToString:@"iPhone7,1"]) return iPhone6Plus;
    if ([platform isEqualToString:@"iPhone8,1"]) return iPhone6s;
    if ([platform isEqualToString:@"iPhone8,2"]) return iPhone6sPlus;
    if ([platform isEqualToString:@"iPhone8,3"]) return iPhoneSE;
    if ([platform isEqualToString:@"iPhone8,4"]) return iPhoneSE;
    if ([platform isEqualToString:@"iPhone9,1"]) return iPhone7;
    if ([platform isEqualToString:@"iPhone9,2"]) return iPhone7Plus;

    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])   return iPodTouch;
    if ([platform isEqualToString:@"iPod2,1"])   return iPodTouch2G;
    if ([platform isEqualToString:@"iPod3,1"])   return iPodTouch3G;
    if ([platform isEqualToString:@"iPod4,1"])   return iPodTouch4G;
    if ([platform isEqualToString:@"iPod5,1"])   return iPodTouch5G;
    if ([platform isEqualToString:@"iPod7,1"])   return iPodTouch6G;

    //iPad
    if ([platform isEqualToString:@"iPad1,1"])   return iPad;
    if ([platform isEqualToString:@"iPad2,1"])   return iPad2;
    if ([platform isEqualToString:@"iPad2,2"])   return iPad2;
    if ([platform isEqualToString:@"iPad2,3"])   return iPad2;
    if ([platform isEqualToString:@"iPad2,4"])   return iPad2;
    if ([platform isEqualToString:@"iPad3,1"])   return iPad3;
    if ([platform isEqualToString:@"iPad3,2"])   return iPad3;
    if ([platform isEqualToString:@"iPad3,3"])   return iPad3;
    if ([platform isEqualToString:@"iPad3,4"])   return iPad4;
    if ([platform isEqualToString:@"iPad3,5"])   return iPad4;
    if ([platform isEqualToString:@"iPad3,6"])   return iPad4;

    if ([platform isEqualToString:@"i386"])      return iPhoneSimulator;
    if ([platform isEqualToString:@"x86_64"])    return iPhoneSimulator;

    return platform;
}

@end
