//
//  ZYQTool.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/11/2.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYQTool : NSObject
#pragma mark -- 正则表达式判断相关
/**
 手机号码合法判断（所有的号码，排除11111111111）
 
 @param phoneStr 手机号
 @return 是否合法
 */
+(BOOL)ZYQ_judgePhoneIsLegalWithPhoneStr:(NSString *)phoneStr;

/**
 判断密码，只由数字和字母组成
 
 @param pwdStr 判断字符串
 @param from 从多长
 @param to 到多长
 @return   返回密码是否符合格式
 */
+ (BOOL)ZYQ_judgePasswordWithStr:(NSString *)pwdStr
                           from:(int)from
                             to:(int)to;
/**
 判断名字，只由汉字和字母组成
 
 @param nameStr 判断字符串
 @param length  名字的长度
 @return   返回名称是否符合格式
 */
+ (BOOL)ZYQ_judgeNameWithStr:(NSString *)nameStr
                     length:(int)length;

/**
 判断文件名称，只由汉字、字母、数字、下划线组成
 
 @param fileNamStr 文件名称
 @param length 长度
 @return 是否符合文件名称要求
 */
+ (BOOL)ZYQ_judgeFileNameWithStr:(NSString *)fileNamStr
                         length:(int)length;
/**
 判断邮箱格式
 
 @param emial 判断的字符串
 @return 是否符合格式
 */
+ (BOOL)ZYQ_isValidateEmail:(NSString *)emial;
/**
 判断是否正确
 
 @param regular 正则表达式字符串
 @param str 要判断的字符串
 @return 是否符合格式
 */
+ (BOOL)ZYQ_isCorrecZYQormatWithRegularExpression:(NSString *)regular withStr:(NSString *)str;

/**
 判断车牌号码
 
 @param carStr 车牌号码判断
 @return 是否是车牌号
 */
+ (BOOL)ZYQ_isValidCar:(NSString *)carStr;

#pragma mark -- 获取当前控制器
/**
 获取当前控制器
 @return 当前控制器
 */
+(UIViewController *)ZYQ_getCurrentController;
/**
 获取当前活动的控制器 navigationcontroller
 @return 当前活动的控制器
 */
+ (UINavigationController *)ZYQ_getNavigationViewController;

#pragma mark -- 表情符号判断
/**
 判断输入的是否为表情符号
 
 @param string 输入字符串
 @return 是否为表情
 */
+ (BOOL)ZYQ_stringContainsEmoji:(NSString *)string;

#pragma mark - 特殊符号判断

/**
 判断是否有特殊符号
 需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€ • ´ 卍 ㊣
 @param str 输入字符串
 @return 是否有特殊符号
 */
+ (BOOL)ZYQ_isIncludeSpecialCharact: (NSString *)str;


#pragma mark -- 字符串是否为空判断
/**
 判断字符串是否为空
 
 @param string 输入的字符串
 @return 是否为空
 */
+ (BOOL)ZYQ_isBlankString:(NSString *)string;
#pragma mark -- 获取文件路径

+(NSString *)ZYQ_geZYQilePath:(NSString*)fileName;
#pragma mark -- 根据字符串获取一个高度
/**
 更具字符串获取一个高度
 @param text 字符串
 @param font 字体大小
 @return 高度
 */
+(CGFloat)ZYQ_returnHeightAccordingText:(NSString *)text
                                  font:(int)font;

/**
 根据字符串获取一个高度
 @param text 字符串
 @param font 字体
 @param width text的宽度
 @return 高度
 */
+(CGFloat)ZYQ_returnHeightAccordingText:(NSString *)text
                                  font:(UIFont*)font
                                 width:(CGFloat)width;

/**
 根据字符串获取一个宽度
 @param text 字符串
 @param font 字体
 @param height text的高 度
 @return 高度
 */
+(CGFloat)ZYQ_returnWidthAccordingText:(NSString *)text
                                 font:(UIFont *)font
                               height:(CGFloat)height;
#pragma mark -- 根据声音时长，获取声音时长字符串

/**
 根据声音时长，获取声音时长字符串
 
 @param second 声音时长
 @return 声音时长字符串 13:1 和 14:20
 */
+ (NSString *)ZYQ_getSoundTime:(int)second;
#pragma mark - 两个字符串拼接富文本

/**
 两个字符串富文本拼接
 
 @param stringFirst 第一个字符串
 @param firsZYQont 第一个字符串字体大小
 @param firstTextColor 第一个字符串字体颜色
 @param stringSecond 第二个字符串
 @param secondFont 第二个字符串字体大小
 @param secondTextColor 第二个字符串字体颜色
 @return 拼接后的字符串
 */
+ (NSMutableAttributedString *)setAtttibuteStringFirst:(NSString *)stringFirst
                                             firsZYQont:(UIFont *)firsZYQont
                                        firstTextColor:(UIColor *)firstTextColor
                                          StringSecond:(NSString *)stringSecond
                                            secondFont:(UIFont *)secondFont
                                       secondTextColor:(UIColor *)secondTextColor;

#pragma mark - 传入文件大小转换成对应的 KB 或者MB

/**
 文件大小转换
 @param fileSize 文件大小 KB
 @return 转换后的字符串
 */
+ (NSString *)ZYQ_fileSizeToString:(unsigned long long)fileSize;

/**
 文件大小转换
 
 @param size 文件大小 B
 @return 转换后的字符串
 */
+ (NSString *)ZYQ_geZYQileSize:(unsigned long long)size;
#pragma mark - 获取字符串首字母

/**
 获取字符串首字母
 
 @param str 要获取的字符串
 @return 获取后的字母字符串
 */
+ (NSString *)ZYQ_geZYQirstWithStr:(NSString *)str;
#pragma mark - json转换成字典
/**
 把格式化的JSON格式的字符串转换成字典
 @param jsonString JSON格式的字符串
 @return 返回字典
 */
+ (NSDictionary *)ZYQ_dictionaryWithJsonString:(NSString *)jsonString;


@end

NS_ASSUME_NONNULL_END
