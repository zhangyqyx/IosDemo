//
//  ZYQMacroDefinition.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/11/2.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#ifndef ZYQMacroDefinition_h
#define ZYQMacroDefinition_h
#pragma mark -- 手机判断
#define kiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhoneXs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhoneXs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#pragma mark -- 高度
#define ZYQ_NavigationH     44
#define ZYQ_iphoneXBAddH    34
#define ZYQ_TopH            (ZYQ_iPhoneX == true ?(64 + 24):(64))
#define ZYQ_StatusBarH      (ZYQ_iPhoneX == true ?(20 + 24):(20))


#define ZYQ_ScreenWidth     ([UIScreen mainScreen].bounds.size.width)
#define ZYQ_ScreenHeight    ([UIScreen mainScreen].bounds.size.height)
#define ZYQ_ScreenSize      ([UIScreen mainScreen].bounds.size)

#pragma mark -- 打印日志
#ifdef DEBUG
# define ZYQLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
# define ZYQLog(...)
#endif

#pragma mark -- 强弱引用
#define ZYQWeakSelf(type)    __weak typeof(type) weak##type = type;
#define ZYQStrongSelf(type)  __strong typeof(type) type     = weak##type;

#pragma mark -- 角度和弧度之间的转换
#define ZYQDegreesToRadian(x)        (M_PI * (x) / 180.0)
#define ZYQRadianToDegrees(radian)   (radian*180.0)/(M_PI)
#pragma mark -- 获取图片资源
#define ZYQGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

#pragma mark -- 获取系统版本
#define ZYQ_IOSVersion            [[[UIDevice currentDevice] systemVersion] floatValue]
#define ZYQ_currentSysetmVersion  [[UIDevice currentDevice] systemVersion]
#pragma mark -- 获取当前语言
#define ZYQ_CurrentLanguage   ([[NSLocale preferredLanguages] objectAtIndex:0])
#pragma mark -- 设备判断
//判断是否为iPhone
#define ZYQ_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//#define IS_IPHONE ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"])
//判断是否为iPad
#define ZYQ_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//#define IS_IPAD ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"])
//判断是否为ipod
#define ZYQ_IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
// 判断是否为 iPhone 5SE
#define ZYQ_iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f
// 判断是否为iPhone 6/6s
#define ZYQ_iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
// 判断是否为iPhone 6Plus/6sPlus
#define ZYQ_iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f
#pragma mark -- 判断是真机还是模拟器
//真机模拟器返回
#define ZYQ_ISIPHONEORSIMULATOR TARGET_OS_IPHONE?TARGET_OS_IPHONE:TARGET_IPHONE_SIMULATOR

#if TARGET_OS_IPHONE
//真机
#endif
#if TARGET_IPHONE_SIMULATOR
//模拟器
#endif

#pragma mark -- 为空的判断
//字符串是否为空
#define ZYQ_StringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define ZYQ_ArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define ZYQ_DictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define ZYQ_ObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

#pragma mark --  获取路径
//获取沙盒Document路径
#define ZYQ_DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒temp路径
#define ZYQ_TempPath NSTemporaryDirectory()
//获取沙盒Cache路径
#define ZYQ_CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]



#endif /* ZYQMacroDefinition_h */
