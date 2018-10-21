//
//  ZYQBase64.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/21.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64)

+ (NSData *)ZYQ_dataWithBase64EncodedString:(NSString *)string;
- (NSString *)ZYQ_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)ZYQ_base64EncodedString;

@end


@interface NSString (Base64)

+ (NSString *)ZYQ_stringWithBase64EncodedString:(NSString *)string;
- (NSString *)ZYQ_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)ZYQ_base64EncodedString;
- (NSString *)ZYQ_base64DecodedString;
- (NSData *)ZYQ_base64DecodedData;

@end
