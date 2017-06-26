
#import "Person+MutipleName.h"
#import <objc/runtime.h>

@implementation Person (MutipleName)

static char eName;

/**
 给分类动态添加一个属性

 @param englishName 属性值
 */
- (void)setEnglishName:(NSString *)englishName {
    objc_setAssociatedObject(self, &eName, englishName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)englishName {
    return objc_getAssociatedObject(self, &eName);
}

@end
