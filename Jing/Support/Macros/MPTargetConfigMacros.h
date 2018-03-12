//
//  MPTargetConfigMacros.h
//  MobileProject  target配置管理
//

#ifndef MPTargetConfigMacros_h
#define MPTargetConfigMacros_h


#if PRODUCT  //产品环境

//输出转换成DDLog
#define NSLog(...) DDLogVerbose(__VA_ARGS__)
#define Log(...) DDLogVerbose(__VA_ARGS__)

#else   //其它环境

//输出转换成DDLog
#define NSLog(...) DDLogVerbose(__VA_ARGS__)
#define Log(...) DDLogVerbose(__VA_ARGS__)

#endif


#endif /* MPTargetConfigMacros_h */
