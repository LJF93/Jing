
#import "MPOperation.h"

@implementation MPOperation

/**
 * 需要执行的任务
 */

- (void)main
{
    for (int i = 0; i < 2; ++i) {
        NSLog(@"MPOperation当前的线程-----%@",[NSThread currentThread]);
    }
}

@end
