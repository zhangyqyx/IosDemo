//
//  ZYQTool.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/11/2.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQTool.h"
#include <CommonCrypto/CommonDigest.h>

@implementation ZYQTool
#pragma mark -- 正则表达式判断相关
/**
 手机号码合法判断（所有的号码，排除11111111111）
 
 @param phoneStr 手机号
 @return 是否合法
 */
+(BOOL)ZYQ_judgePhoneIsLegalWithPhoneStr:(NSString *)phoneStr
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,184
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,177,180,189,181
     */
    
    //手机号以13,14,15,18,17开头，八个 \d 数字字符
    //    NSString *pattern = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-345-9]|7[013678])\\d{8}$";
    BOOL isMatch = NO;
    if (phoneStr.length != 11) {
        return isMatch;
    }
    if ([phoneStr isEqualToString:@"11111111111"]) {
        return isMatch;
    }
    NSString *pattern = @"^[1][0-9]{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    isMatch = [pred evaluateWithObject:phoneStr];
    return isMatch;
}
/**
 判断密码，只由数字和字母组成
 
 @param pwdStr 判断字符串
 @param from 从多长
 @param to 到多长
 @return   返回密码是否符合格式
 */
+ (BOOL)ZYQ_judgePasswordWithStr:(NSString *)pwdStr from:(int)from to:(int)to {
    
    NSString *regular = [NSString stringWithFormat:@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{%d,%d}$" , from , to];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    return [pred evaluateWithObject:pwdStr];
}
/**
 判断名字，只由汉字和字母组成
 @param nameStr 判断字符串
 @param length  名字的长度
 @return   返回名字是否符合格式
 */
+ (BOOL)ZYQ_judgeNameWithStr:(NSString *)nameStr length:(int)length {
    
    NSString *regular = [NSString stringWithFormat:@"([a-zA-Z]|[\u4e00-\u9fa5]|[a-zA-Z\u4e00-\u9fa5]){0,%d}",length];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    return [pred evaluateWithObject:nameStr];
}
+ (BOOL)ZYQ_judgeFileNameWithStr:(NSString *)fileNamStr
                         length:(int)length  {
    NSString *regular = [NSString stringWithFormat:@"([0-9a-zA-Z_\u3E00-\u9FA5]){0,%d}",length];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    return [pred evaluateWithObject:fileNamStr];
}

+ (BOOL)ZYQ_isValidateEmail:(NSString *)emial {
    //    NSString *emailRegex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+ \\.([a-zA-Z0-9_-]+)+$";
    NSString *emailRegex = @"^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\\.[a-zA-Z0-9_-]{2,3}){1,2})$";
    NSPredicate *emailPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@" , emailRegex];
    return [emailPre evaluateWithObject: emial];
}
+ (BOOL)ZYQ_isCorrecZYQormatWithRegularExpression:(NSString *)regular withStr:(NSString *)str{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@" , regular];
    return [pred evaluateWithObject:str];
}
+ (BOOL)ZYQ_isValidCar:(NSString *)carStr{
    NSString *regular = @"^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$";
    return [ZYQTool ZYQ_isCorrecZYQormatWithRegularExpression:regular withStr:carStr];
}


#pragma mark -- 表情符号判断
/**
 判断输入的是否为表情符号
 
 @param string 输入字符串
 @return 是否为表情
 */
+ (BOOL)ZYQ_stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}
#pragma mark - 特殊符号判断
+ (BOOL)ZYQ_isIncludeSpecialCharact: (NSString *)str {
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$€ • ´卍 ㊣ "]];
    if (urgentRange.location == NSNotFound){
        return NO;
    }
    return YES;
}
#pragma mark -- 获取当前控制器
/**
 获取当前控制器
 
 @return 当前控制器
 */
+(UIViewController *)ZYQ_getCurrentController{
    
    UIViewController *reController = nil;
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    if (window.windowLevel!= UIWindowLevelNormal) {
        NSArray *array = [[UIApplication sharedApplication]windows];
        for (UIWindow *win in array) {
            if (win.windowLevel == UIWindowLevelNormal) {
                window = win;
                break;
            }
        }
    }
    UIView *cuView = [[window subviews]objectAtIndex:0];
    id responder = [cuView nextResponder];
    if ([responder isKindOfClass:[UIViewController class]]) {
        reController = responder;
    }
    else{
        reController = window.rootViewController;
    }
    return reController;
}

// 获取当前活动的navigationcontroller
+ (UINavigationController *)ZYQ_getNavigationViewController
{
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    if ([window.rootViewController isKindOfClass:[UINavigationController class]]){
        return (UINavigationController *)window.rootViewController;
    }else if ([window.rootViewController isKindOfClass:[UITabBarController class]]){
        UIViewController *selectVc = [((UITabBarController *)window.rootViewController) selectedViewController];
        if ([selectVc isKindOfClass:[UINavigationController class]]){
            return (UINavigationController *)selectVc;
        }
    }
    return nil;
}


#pragma mark -- 字符串是否为空判断
+ (BOOL)ZYQ_isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//根据文件名  返回Document下文件路径
+(NSString *)ZYQ_geZYQilePath:(NSString*)fileName
{
    //    1 找documents
    NSString *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //    2 返回文件的路径
    return [documents stringByAppendingPathComponent:fileName];
}
+ (NSString *)ZYQ_sha256ForAudioFileURL:(NSURL *)audioNetworkFileURL{
    NSString *string = [audioNetworkFileURL absoluteString];
    unsigned char hash[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256([string UTF8String], (CC_LONG)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], hash);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (size_t i = 0; i < CC_SHA256_DIGEST_LENGTH; ++i) {
        [result appendFormat:@"%02x", hash[i]];
    }
    return result;
}
#pragma mark -- 根据字符串获取一个高度
//根据字符串的长度定义cell的高度
+(CGFloat)ZYQ_returnHeightAccordingText:(NSString *)text font:(int)font
{
    CGSize size = CGSizeMake(ZYQ_ScreenWidth, 1000);
    CGFloat heigth = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size.height;
    return heigth;
}

+(CGFloat)ZYQ_returnHeightAccordingText:(NSString *)text
                                  font:(UIFont*)font width:(CGFloat)width{
    CGSize size = CGSizeMake(width, 1000);
    CGFloat heigth = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.height;
    return heigth;
}

+(CGFloat)ZYQ_returnWidthAccordingText:(NSString *)text font:(UIFont *)font height:(CGFloat)height{
    CGSize size = CGSizeMake(1000, height);
    CGFloat width = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width;
    //    CGSize titleSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, height)];
    return width;
}

#pragma mark -- 根据声音时长，获取声音时长字符串
+ (NSString *)ZYQ_getSoundTime:(int)second {
    int allMinute = second/60;
    NSString *allmS;
    if (allMinute<10) {
        allmS = [NSString stringWithFormat:@"0%d",allMinute];
    }else{
        allmS = [NSString stringWithFormat:@"%d",allMinute];
    }
    int allSecond = second % 60;
    NSString *allsecondStr;
    if (allSecond<10) {
        allsecondStr = [NSString stringWithFormat:@"0%d",allSecond];
    }else{
        allsecondStr = [NSString stringWithFormat:@"%d",allSecond];
    }
    return  [NSString stringWithFormat:@"%@:%@",allmS,allsecondStr];
}
#pragma mark - 两个字符串拼接富文
+ (NSMutableAttributedString *)setAtttibuteStringFirst:(NSString *)stringFirst
                                             firsZYQont:(UIFont *)firsZYQont
                                        firstTextColor:(UIColor *)firstTextColor
                                          StringSecond:(NSString *)stringSecond
                                            secondFont:(UIFont *)secondFont
                                       secondTextColor:(UIColor *)secondTextColor{
    NSMutableAttributedString *attSrtName = [[NSMutableAttributedString alloc]initWithString:stringFirst];
    [attSrtName addAttribute:NSForegroundColorAttributeName value:firstTextColor range:NSMakeRange(0,[stringFirst length])];
    [attSrtName addAttribute:NSFontAttributeName value:firsZYQont range:NSMakeRange(0, [stringFirst length])];
    NSMutableAttributedString *attSoundNum = [[NSMutableAttributedString alloc]initWithString:stringSecond];
    [attSoundNum addAttribute:NSForegroundColorAttributeName value:secondTextColor range:NSMakeRange(0,[stringSecond length])];
    [attSoundNum addAttribute:NSFontAttributeName value:secondFont range:NSMakeRange(0, [stringSecond length])];
    [attSrtName appendAttributedString:attSoundNum];
    return attSrtName;
}


#pragma mark - 传入文件大小转换成对应的 KB 或者MB

+ (NSString *)ZYQ_fileSizeToString:(unsigned long long)fileSize {
    NSString * fileSizeStr = nil;
    if (fileSize > 1024 * 1024) {
        fileSizeStr =   [NSString stringWithFormat:@"%@G" , [self takeOutZeroWithStr:[NSString stringWithFormat:@"%.1lf" , (double) (fileSize / 1024.00 /1024.00)]]];
    }else if (fileSize  > 1024) {
        fileSizeStr =  [NSString stringWithFormat:@"%@M" , [self takeOutZeroWithStr:[NSString stringWithFormat:@"%.1lf" , (double) (fileSize / 1024.00)]]];
    }else {
        fileSizeStr =  [NSString stringWithFormat:@"%@K" , [self takeOutZeroWithStr:[NSString stringWithFormat:@"%.1lf" , (double)fileSize]]];
    }
    
    return fileSizeStr ;
}
+ (NSString *)ZYQ_geZYQileSize:(unsigned long long)size {
    NSString *sizeText = nil;
    if (size >= 1024 * 1024*1024) { // size >= 1GB
        sizeText =  [NSString stringWithFormat:@"%@G" , [self takeOutZeroWithStr:[NSString stringWithFormat:@"%.1lf" , size / (1024.0 * 1024.0*1024.0)]]];
    } else if (size >= 1024 * 1024) { // 1GB > size >= 1MB
        sizeText =  [NSString stringWithFormat:@"%@M" , [self takeOutZeroWithStr:[NSString stringWithFormat:@"%.1lf" , size /(1024.0 *1024.0)]]];
    } else if (size >= 1024) { // 1MB > size >= 1KB
        sizeText =  [NSString stringWithFormat:@"%@K" , [self takeOutZeroWithStr:[NSString stringWithFormat:@"%.1lf" , size / 1024.0]]];
    } else { // 1KB > size
        sizeText = [NSString stringWithFormat:@"%lluB", size];
    }
    
    
    //    if (size >= pow(10, 9)) { // size >= 1GB
    //       sizeText =  [NSString stringWithFormat:@"%@G" , [self takeOutZeroWithStr:[NSString stringWithFormat:@"%.1lf" , size / pow(10, 9)]]];
    //    } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
    //         sizeText =  [NSString stringWithFormat:@"%@M" , [self takeOutZeroWithStr:[NSString stringWithFormat:@"%.1lf" , size / pow(10, 6)]]];
    //    } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
    //         sizeText =  [NSString stringWithFormat:@"%@K" , [self takeOutZeroWithStr:[NSString stringWithFormat:@"%.1lf" , size / pow(10,  3)]]];
    //    } else { // 1KB > size
    //        sizeText = [NSString stringWithFormat:@"%zdB", size];
    //    }
    return sizeText;
}
+ (NSString *)takeOutZeroWithStr:(NSString *)zeroStr{
    if ([zeroStr rangeOfString:@".0"].location !=NSNotFound) {
        zeroStr = [zeroStr substringToIndex:[zeroStr length]-2];
    }
    return zeroStr;
}
#pragma mark - 获取字符串首字母
+ (NSString *)ZYQ_geZYQirstWithStr:(NSString *)str{
    NSMutableString *ms = [[NSMutableString alloc]initWithString:str];
    if ([[str substringToIndex:1] compare:@"长"] ==NSOrderedSame){
        [ms replaceCharactersInRange:NSMakeRange(0, 1)withString:@"chang"];
    }
    if ([[str substringToIndex:1] compare:@"嗯"] ==NSOrderedSame){
        [ms replaceCharactersInRange:NSMakeRange(0, 1)withString:@"en"];
    }
    if ([[str substringToIndex:1] compare:@"沈"] ==NSOrderedSame){
        [ms replaceCharactersInRange:NSMakeRange(0, 1)withString:@"shen"];
    }
    if ([[str substringToIndex:1] compare:@"厦"] ==NSOrderedSame){
        [ms replaceCharactersInRange:NSMakeRange(0, 1)withString:@"xia"];
    }
    if ([[str substringToIndex:1] compare:@"地"] ==NSOrderedSame){
        [ms replaceCharactersInRange:NSMakeRange(0, 1)withString:@"di"];
    }
    if ([[str substringToIndex:1] compare:@"重"] == NSOrderedSame)  {
        [ms replaceCharactersInRange:NSMakeRange(0, 1) withString:@"chong"];
    }
    //    带声仄 //不能注释掉
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0,kCFStringTransformMandarinLatin, NO)) {
    }
    NSString *cha;
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0,kCFStringTransformStripDiacritics, NO)) {
        
        NSString *bigStr = [ms uppercaseString]; // bigStr 是转换成功后的拼音
        cha = [bigStr substringToIndex:1];
        
    }
    return cha;
}

#pragma mark - json转换成字典
+ (NSDictionary *)ZYQ_dictionaryWithJsonString:(NSString *)jsonString{
    if ([self ZYQ_isBlankString:jsonString]) return nil;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
