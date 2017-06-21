//
//  AdvertiseHelper.m
//  Jing
//
//  Created by Mac on 2017/4/27.
//  Copyright © 2017年 Sanvio. All rights reserved.
//

#import "AdvertiseHelper.h"
#import "AdvertiseView.h"

@implementation AdvertiseHelper

+ (instancetype)sharedInstance {
    static AdvertiseHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AdvertiseHelper alloc] init];
    });

    return sharedInstance;
}

+ (void)showAdvertiseView:(NSArray *)imageArray {

    NSString *path = [[AdvertiseHelper sharedInstance] getFilePathWithName:[kAdUserDefaults valueForKey:AdvertiseImageKey]];
    BOOL isExist = [[AdvertiseHelper sharedInstance] isFileExistWithPath:path];
    // 判断沙盒中是否存在广告图片，如果存在，直接显示
    if (isExist) {
        AdvertiseView *advertiseView = [[AdvertiseView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
        advertiseView.filePath = path;
        [advertiseView show];
    }
    // 无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    [[AdvertiseHelper sharedInstance] getAdvertiseImage:imageArray];
}

- (void)getAdvertiseImage:(NSArray *)imageArray {
    NSString *imageURL = imageArray[arc4random() % imageArray.count];//随机获取一张广告图片的URL
    NSArray *stringArr = [imageURL componentsSeparatedByString:@"/"];
    NSString *imageName = [stringArr lastObject];

    BOOL isExist = [self isFileExistWithPath:[self getFilePathWithName:imageName]];
    if (!isExist) {//若本地沙盒不存在广告图片，则下载新图并保存成功之后，删除旧图片。
        [self downloadAdvertiseImageWithURL:imageURL ImageName:imageName];
    }
}

- (void)downloadAdvertiseImageWithURL:(NSString *)imageURL ImageName:(NSString *)imageName{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
        UIImage *image = [UIImage imageWithData:data];
        NSString *filePath = [self getFilePathWithName:imageName];

        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {
            NSLog(@"广告图片保存成功！");
            [self deleteOldImage];
            [kAdUserDefaults setValue:imageName forKey:AdvertiseImageKey];
            [kAdUserDefaults synchronize];
        }
        else {
            NSLog(@"广告图片保存失败！");
        }
    });
}

- (NSString *)getFilePathWithName:(NSString *)imageName {
    if (imageName) {
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/%@", imageName]];
        return filePath;
    }
    return nil;
}

/**
 判断文件是否存在沙盒

 @param path 文件路径
 @return YES:存在；NO:不存在
 */
- (BOOL)isFileExistWithPath:(NSString *)path {
    BOOL isDirectory = FALSE;
    return [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
}

/**
 删除旧图片
 */
- (void)deleteOldImage {
    NSString *imageName = [kAdUserDefaults valueForKey:AdvertiseImageKey];
    NSString *filePath = [self getFilePathWithName:imageName];
    if (filePath) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}

@end
