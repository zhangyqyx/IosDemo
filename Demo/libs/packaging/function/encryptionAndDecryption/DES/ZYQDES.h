//
//  ZYQDES.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/21.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.

#import <Foundation/Foundation.h>

@interface ZYQDES : NSObject

#pragma mark - DES加密
/**
 DES加密
 @param str 要加密的字符串
 @param key 加密的key
 @return 加密后的字符串
 */
+ (NSString *)ZYQ_encryptWithString:(NSString *)str  key:(NSString *)key;
/**
  DES加密
 @param data 要加密的数据
 @param key 加密的key
 @return 加密后的数据
 */
+ (NSData *)ZYQ_encryptWithData:(NSData *)data dataKey:(NSData *)key;

#pragma mark - DES解密
/**
 DES解密
 @param str 要解密的字符串
 @param key 解密的key
 @return 解密后的字符串
 */
+ (NSString *)ZYQ_decryptWithString:(NSString *)str key:(NSString *)key;
/**
 DES解密
 @param data 要解密的数据
 @param key 解密的key
 @return 解密后的数据
 */
+ (NSData *)ZYQ_decryptWithData:(NSData *)data dataKey:(NSData *)key;



@end
