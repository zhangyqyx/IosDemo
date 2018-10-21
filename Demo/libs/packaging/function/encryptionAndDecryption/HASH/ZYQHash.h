//
//  ZYQHash.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/21.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYQHash : NSObject
#pragma mark -- md5加密
/**
 最基本的MD5加密  终端命令：md5 -s "123"
 @param str 要加密的字符串
 @return 加密后的字符串
 */
+ (NSString *)ZYQ_md5WithSttring:(NSString *)str;

/**
 MD5加盐加密
 @param str 要加密的字符串
 @return 加密后的字符串
 */
+ (NSString *)ZYQ_md5SaltingWithSttring:(NSString *)str;

/**
  MD5加盐加密
 @param str 要加密的字符串
 @param salting 盐
 @return 加密后的字符串
 */
+ (NSString *)ZYQ_md5SaltingWithSttring:(NSString *)str salting:(NSString *)salting;


#pragma mark -- SHA
/**
 sha加密
 @param str 要加密的字符串
 @return 加密后的字符串
 */
//终端命令：echo -n "123" | openssl sha -sha1
+ (NSString *)ZYQ_sha1WithString:(NSString *)str;
//终端命令：echo -n "123" | openssl sha -sha224
+ (NSString *)ZYQ_sha224WithString:(NSString *)str;
//终端命令：echo -n "123" | openssl sha -sha256
+ (NSString *)ZYQ_sha256WithString:(NSString *)str;
//终端命令：echo -n "123" | openssl sha -sha384
+ (NSString *)ZYQ_sha384WithString:(NSString *)str;
//终端命令：echo -n "123" | openssl sha -sha256
+ (NSString *)ZYQ_sha512WithString:(NSString *)str;

#pragma mark - HMAC
/**
 HMACmd5加密
 @param str 要加密的字符串
 @param key 用到的key
 @return 加密后的字符串
 */
//终端命令：echo -n "123" | openssl dgst -md5 -hmac "123"
+ (NSString *)ZYQ_hmacMD5WithString:(NSString *)str
                               Key:(NSString *)key;
/**
  HMACsha加密
 @param str 要加密的字符串
 @param key 用到的key
 @return 加密后的字符串
 */
//终端命令：echo -n "123" | openssl sha -sha1 -hmac "123"
+ (NSString *)ZYQ_hmacSHA1WithString:(NSString *)str
                                key:(NSString *)key;
//终端命令：echo -n "123" | openssl sha -sha224 -hmac "123"
+ (NSString *)ZYQ_hmacSHA224WithString:(NSString *)str
                                  key:(NSString *)key;
//终端命令：echo -n "123" | openssl sha -sha256 -hmac "123"
+ (NSString *)ZYQ_hmacSHA256WithString:(NSString *)str
                                  key:(NSString *)key;
//终端命令：echo -n "123" | openssl sha -sha384 -hmac "123"
+ (NSString *)ZYQ_hmacSHA384WithString:(NSString *)str
                                  key:(NSString *)key;
//终端命令：echo -n "123" | openssl sha -sha512 -hmac "123"
+ (NSString *)ZYQ_hmacSHA512WithString:(NSString *)str
                                  key:(NSString *)key;



@end
