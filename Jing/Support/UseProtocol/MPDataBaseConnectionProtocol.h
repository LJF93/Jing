
#import <Foundation/Foundation.h>

@protocol MPDataBaseConnectionProtocol <NSObject>

@optional

-(void)connect;

-(void)closeConnect;

@end
