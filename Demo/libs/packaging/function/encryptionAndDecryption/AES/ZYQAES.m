//
//  ZYQAES.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/21.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQAES.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCrypto.h>

// 默认使用kCCOptionPKCS7Padding填充
#define kPaddingMode kCCOptionPKCS7Padding

@implementation ZYQAES
#pragma mark -- AES-CBC加密
+ (NSString *)ZYQ_encrptyWithNSString:(NSString *)str key:(NSString *)key iv:(NSString *)iv {
    NSData *data        = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData     = [key dataUsingEncoding:NSUTF8StringEncoding];
    if (iv == nil) {
        iv              = @"00000000000000000000000000000000";
    }
    NSData *ivData      = [iv dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encrptData  = [self ZYQ_encrptyWithData:data dataKey:keyData dataIv:ivData];
    return [encrptData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
+ (NSString *)ZYQ_encrptyWithNSString:(NSString *)str hexKey:(NSString *)key hexiv:(NSString *)iv {
    NSData *keyData     = [self dataFromHexString:key];
    NSData *data        = [str dataUsingEncoding:NSUTF8StringEncoding];
    if (iv == nil) {
        iv              = @"00000000000000000000000000000000";
    }
    NSData *ivData      = [self dataFromHexString:iv];
    NSData *encrptData  = [self ZYQ_encrptyWithData:data dataKey:keyData dataIv:ivData];
    return [encrptData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
+ (NSData *)ZYQ_encrptyWithData:(NSData *)data dataKey:(NSData *)key dataIv:(NSData *)iv{
    return [self aesEncryptOrDecrypt:kCCEncrypt data:data dataKey:key dataIv:iv mode:kPaddingMode];
}
#pragma mark -- AES-ECB加密
+ (NSString *)ZYQ_encrptyWithString:(NSString *)str key:(NSString *)key {
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *strData = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [[self ZYQ_encrptyWithData:strData dataKey:keyData] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
+ (NSString *)ZYQ_encrptyWithString:(NSString *)str hexKey:(NSString *)key {
    NSData *keyData = [self dataFromHexString:key];
    NSData *strData = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [[self ZYQ_encrptyWithData:strData dataKey:keyData] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
+ (NSString *)ZYQ_encrptyWithString:(NSString *)str base64Key:(NSString *)key {
    NSData *keyData = [[NSData alloc] initWithBase64EncodedString:key options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *strData = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [[self ZYQ_encrptyWithData:strData dataKey:keyData] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
+ (NSData *)ZYQ_encrptyWithData:(NSData *)data dataKey:(NSData *)key {
    NSData *aesIv = [self dataFromHexString:@"00000000000000000000000000000000"];
    return [self aesEncryptOrDecrypt:kCCEncrypt data:data dataKey:key dataIv:aesIv mode:kPaddingMode | kCCOptionECBMode];
}

+ (NSData *)aesEncryptOrDecrypt:(CCOperation)option data:(NSData *)data dataKey:(NSData *)key dataIv:(NSData *)iv mode:(int)mode{
    if ([iv length] != 16) {
        @throw [NSException exceptionWithName:@"加密或解密"
                                       reason:@"iv长度错误，长度应该为16字节(128bits)"
                                     userInfo:nil];
    }
    if ([key length] != 16 && [key length] != 24 && [key length] != 32 ) {
        @throw [NSException exceptionWithName:@"加密或解密"
                                       reason:@"key长度错误，长度应该为16字节、24字节、32字节(128bits、192bits、256bits)"
                                     userInfo:nil];
    }
    // 设置输出字节
    size_t bufferSize           = [data length] + kCCBlockSizeAES128;
    void *buffer                = malloc(bufferSize);
    //加密解密
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(option,
                                          kCCAlgorithmAES128,
                                          mode,
                                          [key bytes],     // Key
                                          [key length],    // kCCKeySizeAES
                                          [iv bytes],      // IV
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    NSData *resultData = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *resultData      = [NSData dataWithBytes:buffer length:encryptedSize];
        free(buffer);
        return resultData;
    } else {
        free(buffer);
        @throw [NSException exceptionWithName:@"加密或者解密"
                                       reason:@"加解密出现问题"
                                     userInfo:nil];
        return resultData;
    }
   
    
    return resultData;
}

/**
 hex形式的字符串转换为data
 */
+ (NSData *)dataFromHexString:(NSString *)str {
    
    if (str.length == 0) {
        return nil;
    }
    
    static const unsigned char HexDecodeChars[] = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, //49
        2, 3, 4, 5, 6, 7, 8, 9, 0, 0, //59
        0, 0, 0, 0, 0, 10, 11, 12, 13, 14,
        15, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //79
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 10, 11, 12,   //99
        13, 14, 15
    };
    
    // convert data(NSString) to CString
    const char *source  = [str cStringUsingEncoding:NSUTF8StringEncoding];
    // malloc buffer
    unsigned char *buffer;
    NSUInteger length   = strlen(source) / 2;
    buffer              = malloc(length);
    for (NSUInteger index = 0; index < length; index++) {
        buffer[index]   = (HexDecodeChars[source[index * 2]] << 4) + (HexDecodeChars[source[index * 2 + 1]]);
    }
    // init result NSData
    NSData *result      = [NSData dataWithBytes:buffer length:length];
    free(buffer);
    source              = nil;
    return  result;
}
#pragma mark -- AES-CBC解密
+ (NSData *)ZYQ_decrptyWithData:(NSData *)data dataKey:(NSData *)key dataIv:(NSData *)iv {
    return [self aesEncryptOrDecrypt:kCCDecrypt data:data dataKey:key dataIv:iv mode:kPaddingMode];
}
+ (NSString *)ZYQ_decrptyWithString:(NSString *)str key:(NSString *)key iv:(NSString *)iv {
    NSData *keyData     = [key dataUsingEncoding:NSUTF8StringEncoding];
    if (iv == nil) {
        // 32长度
        iv = @"00000000000000000000000000000000";
    }
    NSData *aesIv       = [iv dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data        = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *resultData  = [self ZYQ_decrptyWithData:data dataKey:keyData dataIv:aesIv];
    return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
}
+ (NSString *)ZYQ_decrptyWithString:(NSString *)str hexkey:(NSString *)key hexIv:(NSString *)iv {
    NSData *keyData     = [self dataFromHexString:key];
    if (iv == nil) {
        // 32长度
        iv = @"00000000000000000000000000000000";
    }
    NSData *ivData      = [self dataFromHexString:iv];
    NSData *data        = [[NSData alloc] initWithBase64EncodedString:str options:0];
    NSData *resultData  = [self ZYQ_decrptyWithData:data dataKey:keyData dataIv:ivData ];
    return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
}
#pragma mark -- AES-ECB解密
+ (NSData *)ZYQ_decrptyWithData:(NSData *)data dataKey:(NSData *)key{
    NSData *aesIv       = [self dataFromHexString:@"00000000000000000000000000000000"];
    NSData *resultData  = [self aesEncryptOrDecrypt:kCCDecrypt data:data dataKey:key dataIv:aesIv mode:kPaddingMode | kCCOptionECBMode];
    
    return resultData;
}
+ (NSString *)ZYQ_decrptyWithString:(NSString *)str hexkey:(NSString *)key {
    NSData *keyData     = [self dataFromHexString:key];
    NSData *strData     = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *resultData  = [self ZYQ_decrptyWithData:strData dataKey:keyData];
    return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
}
+ (NSString *)ZYQ_decrptyWithString:(NSString *)str key:(NSString *)key {
    NSData *keyData     = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *strData     = [[NSData alloc]initWithBase64EncodedString:str options:0];
    return [[NSString alloc] initWithData:[self ZYQ_decrptyWithData:strData dataKey:keyData] encoding:NSUTF8StringEncoding];
}
+ (NSString *)ZYQ_decrptyWithString:(NSString *)str base64Key:(NSString *)key {
    NSData *keyData     = [[NSData alloc] initWithBase64EncodedString:key options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *strData     = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc] initWithData:[self ZYQ_decrptyWithData:strData dataKey:keyData] encoding:NSUTF8StringEncoding];
}

#pragma mark -- AES256加密解密
+ (NSString *)ZYQ_AES256EncryptWithString:(NSString *)str key:(NSString *)key {
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [[self encryptOrDecryptWithData:data key:key option:kCCEncrypt] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
+ (NSString *)ZYQ_AES256DecryptWithString:(NSString *)str key:(NSString *)key {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *deData = [self encryptOrDecryptWithData:data key:key option:kCCDecrypt];
    return [[NSString alloc] initWithData:deData encoding:NSUTF8StringEncoding];
}
+ (NSData *)encryptOrDecryptWithData:(NSData *)data key:(NSString *)key option:(CCOperation)option{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(option, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}


@end
