
#import "Person+MutipleName.h"
#import <objc/runtime.h>

@implementation Person (MutipleName)

char eName;

- (void)setEnglishName:(NSString *)englishName {
    objc_setAssociatedObject(self, &eName, englishName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)englishName {
    return objc_getAssociatedObject(self, &eName);
}

@end
