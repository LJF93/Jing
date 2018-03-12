
#import <UIKit/UIKit.h>

typedef void(^successBlock)(NSInteger buttonIndex);

@interface UIAlertView (MPBlock)

- (void)showWithBlock:(successBlock)block;

@end
