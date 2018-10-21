//
//  ZYQRSA.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/21.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYQRSA : NSObject

#pragma mark -- 加密
/**
 RSA加密
 @param str 要加密的字符串
 @param pubKey 公钥字符串
 @return 加密后的字符串
 */
+ (NSString *)ZYQ_encryptString:(NSString *)str
                     publicKey:(NSString *)pubKey;
/**
  RSA加密
 @param data 要加密的数据
 @param pubKey 公钥字符串
 @return 加密后的数据
 */
+ (NSData *)ZYQ_encryptData:(NSData *)data
                 publicKey:(NSString *)pubKey;
#pragma mark -- 解密
/**
 RSA解密
 @param str 要解密的字符串
 @param privKey 私钥字符串
 @return 解密后的字符串
 */
+ (NSString *)ZYQ_decryptString:(NSString *)str
                    privateKey:(NSString *)privKey;
/**
 RSA解密
 @param data 要解密的数据
 @param privKey 私钥字符串
 @return 解密后的数据
 */
+ (NSData *)ZYQ_decryptData:(NSData *)data
                privateKey:(NSString *)privKey;

#pragma mark -- 文件密钥加解密
/**
 RSA加密
 @param data 要加密的数据
 @param filePath 公钥路径
 @return 加密后的数据
 */
+ (NSData *)ZYQ_encryptData:(NSData *)data
         publicKeyWithPath:(NSString *)filePath;

/**
 RSA加密
 @param str 要加密的字符串
 @param filePath 公钥路径
 @return 加密后的字符串
 */
+ (NSString *)ZYQ_encryptNSString:(NSString *)str
               publicKeyWithPath:(NSString *)filePath;

/**
 RSA解密
 @param data 要解密的数据
 @param filePath P12 私钥文件路径
 @param password  P12 密码
 @return 解密后的数据
 */
+ (NSData *)ZYQ_decryptData:(NSData *)data
                privateKeyWithPath:(NSString *)filePath
                  password:(NSString *)password;

/**
  RSA解密
 @param str 要解密的字符串
 @param filePath P12 私钥文件路径
 @param password  P12 密码
 @return 解密后的字符串
 */
+ (NSString *)ZYQ_decryptNSString:(NSString *)str
                      privateKeyWithPath:(NSString *)filePath
                        password:(NSString *)password;

@end
