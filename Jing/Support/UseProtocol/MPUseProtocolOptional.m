
#import "MPUseProtocolOptional.h"


@implementation MPUseProtocolOptional

- (void)connetcomWithConnetionProtocol:(id<MPDataBaseConnectionProtocol>) service withIndentifier:(NSString *)indentifier {
    NSLog(@"开始执行MPUseProtocolOptional");
    [service connect];
    NSLog(@"结束执行MPUseProtocolOptional");
}

@end
