
#import <Foundation/Foundation.h>

@interface MPRunTimeTest : NSObject<NSCopying> {
    NSString *_schoolName;
}

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *address;

+ (void)showAddressInfo;

- (NSString *)showUserName:(NSString *)name;

@end
