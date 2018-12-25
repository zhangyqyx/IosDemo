//
//  ZYQFoundation+Log.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/11/5.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - NSObject分类

@implementation NSObject (SQJSON)
//将obj转换成json字符串。如果失败则返回nil.
- (NSString *)convertToJsonString {
    
    //先判断是否能转化为JSON格式
    if (![NSJSONSerialization isValidJSONObject:self])  return nil;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted  error:&error];
    if (error || !jsonData) return nil;
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
@end


@implementation NSDictionary(Log)

- (NSString *)descriptionWithLocale:(id)locale {
    NSString *result = [self convertToJsonString];
    if (!result) return [self debugDescription];
    return result;
}
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSString *result = [self convertToJsonString];
    if (!result) return [self debugDescription];
    return result;
}

@end


@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale {
    NSString *result = [self convertToJsonString];
    if (!result){
      return [self debugDescription];
    }
    return result;
}
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSString *result = [self convertToJsonString];
    if (!result){
        return [self debugDescription];
    }
    return result;
}


@end


