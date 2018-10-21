//
//  ZYQHash.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/21.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQHash.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonHMAC.h>
//md5加盐
#define Salting @"kdsabhndndovja390i4890325uv./a,/j892u3ndkabhiort34"

@implementation ZYQHash
#pragma mark -- md5加密
+ (NSString *)ZYQ_md5WithSttring:(NSString *)str {
    const char *plainStr    = str.UTF8String;
    unsigned char *space    = malloc(CC_SHA1_DIGEST_LENGTH);
    CC_MD5(plainStr, (CC_LONG)strlen(plainStr), space);
    NSString *encodeStr     = [self stringFromBytes:space length:CC_MD5_DIGEST_LENGTH];
    free(space);
    return encodeStr;
}
+ (NSString *)ZYQ_md5SaltingWithSttring:(NSString *)str {
    NSString *saltingStr = [NSString stringWithFormat:@"%@%@" , str , Salting];
    return [self ZYQ_md5WithSttring:saltingStr];
}
+ (NSString *)ZYQ_md5SaltingWithSttring:(NSString *)str salting:(NSString *)salting {
    NSString *saltingStr = [NSString stringWithFormat:@"%@%@" , str , salting];
   return [self ZYQ_md5WithSttring:saltingStr];
}
#pragma mark -- SHA
+ (NSString *)ZYQ_sha1WithString:(NSString *)str {
    const char *plainStr    = str.UTF8String;
    unsigned char *spece    = malloc(CC_SHA1_DIGEST_LENGTH);
    CC_SHA1(plainStr, (CC_LONG)strlen(plainStr), spece);
    NSString *encodeStr     = [self stringFromBytes:spece length:CC_SHA1_DIGEST_LENGTH];
    free(spece);
    return encodeStr;
}
+ (NSString *)ZYQ_sha224WithString:(NSString *)str {
    const char *plainStr    = str.UTF8String;
    unsigned char *spece    = malloc(CC_SHA224_DIGEST_LENGTH);
    CC_SHA224(plainStr, (CC_LONG)strlen(plainStr), spece);
    NSString *encodeStr     = [self stringFromBytes:spece length:CC_SHA224_DIGEST_LENGTH];
    free(spece);
    return encodeStr;
}
+ (NSString *)ZYQ_sha256WithString:(NSString *)str {
    const char *plainStr    = str.UTF8String;
    unsigned char *spece    = malloc(CC_SHA256_DIGEST_LENGTH);
    CC_SHA256(plainStr, (CC_LONG)strlen(plainStr), spece);
    NSString *encodeStr     = [self stringFromBytes:spece length:CC_SHA256_DIGEST_LENGTH];
    free(spece);
    return encodeStr;
}
+ (NSString *)ZYQ_sha384WithString:(NSString *)str {
    const char *plainStr    = str.UTF8String;
    unsigned char *spece    = malloc(CC_SHA384_DIGEST_LENGTH);
    CC_SHA384(plainStr, (CC_LONG)strlen(plainStr), spece);
    NSString *encodeStr     = [self stringFromBytes:spece length:CC_SHA384_DIGEST_LENGTH];
    free(spece);
    return encodeStr;
}
+ (NSString *)ZYQ_sha512WithString:(NSString *)str {
    const char *plainStr    = str.UTF8String;
    unsigned char *spece    = malloc(CC_SHA512_DIGEST_LENGTH);
    CC_SHA512(plainStr, (CC_LONG)strlen(plainStr), spece);
    NSString *encodeStr     = [self stringFromBytes:spece length:CC_SHA512_DIGEST_LENGTH];
    free(spece);
    return encodeStr;
}
#pragma mark - HMAC
+ (NSString *)ZYQ_hmacMD5WithString:(NSString *)str
                               Key:(NSString *)key {
    const char *keyData     = key.UTF8String;
    const char *strData     = str.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgMD5, keyData, strlen(keyData), strData, strlen(strData), buffer);
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}
+ (NSString *)ZYQ_hmacSHA1WithString:(NSString *)str
                                key:(NSString *)key {
    NSData *hashData        = [str dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char *spece    = malloc(CC_SHA1_BLOCK_BYTES);
    const char *keyStr      = key.UTF8String;
    CCHmac(kCCHmacAlgSHA1, keyStr, strlen(keyStr), [hashData bytes], [hashData length], spece);
    NSString *encode        = [self stringFromBytes:spece length:CC_SHA1_DIGEST_LENGTH];
    free(spece);
    return encode;
}
+ (NSString *)ZYQ_hmacSHA224WithString:(NSString *)str
                                  key:(NSString *)key {
    NSData *hashData        = [str dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char *spece    = malloc(CC_SHA224_DIGEST_LENGTH);
    const char *keyStr      = key.UTF8String;
    CCHmac(kCCHmacAlgSHA224, keyStr, strlen(keyStr), [hashData bytes], [hashData length], spece);
    NSString *encode        = [self stringFromBytes:spece length:CC_SHA224_DIGEST_LENGTH];
    free(spece);
    return encode;
}
+ (NSString *)ZYQ_hmacSHA256WithString:(NSString *)str
                                  key:(NSString *)key {
    NSData *hashData        = [str dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char *spece    = malloc(CC_SHA256_DIGEST_LENGTH);
    const char *keyStr      = key.UTF8String;
    CCHmac(kCCHmacAlgSHA256, keyStr, strlen(keyStr), [hashData bytes], [hashData length], spece);
    NSString *encode        = [self stringFromBytes:spece length:CC_SHA256_DIGEST_LENGTH];
    free(spece);
    return encode;
}
+ (NSString *)ZYQ_hmacSHA384WithString:(NSString *)str
                                  key:(NSString *)key {
    NSData *hashData        = [str dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char *spece    = malloc(CC_SHA384_DIGEST_LENGTH);
    const char *keyStr      = key.UTF8String;
    CCHmac(kCCHmacAlgSHA384, keyStr, strlen(keyStr), [hashData bytes], [hashData length], spece);
    NSString *encode        = [self stringFromBytes:spece length:CC_SHA384_DIGEST_LENGTH];
    free(spece);
    return encode;
}
+ (NSString *)ZYQ_hmacSHA512WithString:(NSString *)str
                                  key:(NSString *)key {
    NSData *hashData        = [str dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char *spece    = malloc(CC_SHA512_DIGEST_LENGTH);
    const char *keyStr      = key.UTF8String;
    CCHmac(kCCHmacAlgSHA512, keyStr, strlen(keyStr), [hashData bytes], [hashData length], spece);
    NSString *encode        = [self stringFromBytes:spece length:CC_SHA512_DIGEST_LENGTH];
    free(spece);
    return encode;
}

+ (NSString *)stringFromBytes:(uint8_t *)bytes
                       length:(int)length  {
    NSMutableString *muStr = [NSMutableString string];
    for (int i = 0; i < length; i++) {
        [muStr appendFormat:@"%02x",bytes[i]];
    }
    return muStr;
}


@end
