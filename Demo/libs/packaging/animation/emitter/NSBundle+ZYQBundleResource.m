//
//  NSBundle+ZYQBundleResource.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/21.
//  Copyright © 2019年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "NSBundle+ZYQBundleResource.h"
#import <objc/message.h>

@implementation NSBundle (ZYQBundleResource)
+(void)load {
    Method originMethod = class_getInstanceMethod(self, @selector(pathForResource:ofType:));
    Method chanegMethod = class_getInstanceMethod(self, @selector(tempPathForResource:ofType:));
    method_exchangeImplementations(originMethod, chanegMethod);
}
- (NSString *)tempPathForResource:(NSString *)name ofType:(NSString *)ext {
    NSString *path = [self tempPathForResource:name ofType:ext];
    CGFloat scale = [UIScreen mainScreen].scale;
    if (ABS(scale-3) <= 0.001) {
        path = [self tempPathForResource_3x:name ofType:ext];
        if (!path) {
            path = [self tempPathForResource_2x:name ofType:ext];
            if (!path) {
                path = [self tempPathForResource_x:name ofType:ext];
            }
        }
    }
    else if (ABS(scale-2) <= 0.001) {
        path = [self tempPathForResource_2x:name ofType:ext];
        if (!path) {
            path = [self tempPathForResource_x:name ofType:ext];
        }
    }
    else {
        path = [self tempPathForResource_x:name ofType:ext];
    }
    return path;
}
- (NSString *)tempPathForResource_3x:(NSString *)name ofType:(NSString *)ext {
    NSString *path = nil;
    NSString *teampName = nil;
    
    if ([name hasSuffix:@"@3x"]) {
        teampName = name;
    }
    else if ([name hasSuffix:@"@2x"]) {
        teampName = [name stringByReplacingOccurrencesOfString:@"@2x" withString:@"@3x"];
    }
    else {
        teampName = [self joinStr:@"@3x" path:name];
    }
    path = [self tempPathForResource:teampName ofType:ext];
    return path;
}
- (NSString *)tempPathForResource_2x:(NSString *)name ofType:(NSString *)ext {
    NSString *path = nil;
    NSString *teampName = nil;
    
    if ([name hasSuffix:@"@3x"]) {
        teampName = [name stringByReplacingOccurrencesOfString:@"@3x" withString:@"@2x"];
    }
    else if ([name hasSuffix:@"@2x"]) {
        teampName = name;
    }
    else {
        teampName = [self joinStr:@"@2x" path:name];
    }
    path = [self tempPathForResource:teampName ofType:ext];
    
    return path;
}
- (NSString *)tempPathForResource_x:(NSString *)name ofType:(NSString *)ext {
    NSString *path = nil;
    NSString *teampName = nil;
    
    if ([name hasSuffix:@"@3x"]) {
        teampName = [name stringByReplacingOccurrencesOfString:@"@3x" withString:@""];
    }
    else if ([name hasSuffix:@"@2x"]) {
        teampName = [name stringByReplacingOccurrencesOfString:@"@2x" withString:@""];
    }
    else {
        teampName = name;
    }
    path = [self tempPathForResource:teampName ofType:ext];
    
    return path;
}
- (NSString *)joinStr:(NSString *)joinStr path:(NSString *)path {
    NSString *teampName = @"";
    NSArray *arr = [path componentsSeparatedByString:@"."];
    for (NSString *str in arr) {
        if ([arr.firstObject isEqualToString:str]) {
            teampName = str;
        }
        else if ([arr.lastObject isEqualToString:str]) {
            teampName = [teampName stringByAppendingString:[NSString stringWithFormat:@"%@.%@",joinStr ,str]];
        }
        else {
            teampName = [teampName stringByAppendingString:[NSString stringWithFormat:@".%@" ,str]];
        }
    }
    return teampName;
}

@end
