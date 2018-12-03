//
//  ZYQRSA.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/21.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQRSA.h"

// 填充模式
#define kTypeOfWrapPadding		kSecPaddingPKCS1

@implementation ZYQRSA
static NSString *base64_encode_data(NSData *data){
    data            = [data base64EncodedDataWithOptions:0];
    NSString *ret   = [[NSString alloc] initWithData:data
                                          encoding:NSUTF8StringEncoding];
    return ret;
}
static NSData *base64_decode(NSString *str){
    NSData *data    = [[NSData alloc] initWithBase64EncodedString:str
                                                       options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}
#pragma mark -- 加密
+ (NSString *)ZYQ_encryptString:(NSString *)str
                     publicKey:(NSString *)pubKey {
    NSData *data    = [self ZYQ_encryptData:[str dataUsingEncoding:NSUTF8StringEncoding]
                              publicKey:pubKey];
    return base64_encode_data(data);
}
+ (NSData *)ZYQ_encryptData:(NSData *)data
                 publicKey:(NSString *)pubKey {
    if (!data|| !pubKey) {
        return nil;
    }
    SecKeyRef keyRef = [self addPublicKey:pubKey];
    if (!keyRef) {
        return nil;
    }
    return [self encryptData:data withKeyRef:keyRef];
}


+ (SecKeyRef)addPublicKey:(NSString *)key{
        NSRange spos        = [key rangeOfString:@"-----BEGIN PUBLIC KEY-----"];
        NSRange epos        = [key rangeOfString:@"-----END PUBLIC KEY-----"];
        if(spos.location != NSNotFound && epos.location != NSNotFound){
            NSUInteger s    = spos.location + spos.length;
            NSUInteger e    = epos.location;
            NSRange range   = NSMakeRange(s, e-s);
            key             = [key substringWithRange:range];
        }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    NSData *data    = base64_decode(key);
    data            = [self stripPublicKeyHeader:data];
    if(!data){
        return nil;
    }
    
    //a tag to read/write keychain storage
    NSString *tag   = @"RSAUtil_PubKey";
    NSData *d_tag   = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *publicKey = [[NSMutableDictionary alloc] init];
    [publicKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [publicKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)publicKey);
    
    // Add persistent version of the key to system keychain
    [publicKey setObject:data forKey:(__bridge id)kSecValueData];
    [publicKey setObject:(__bridge id) kSecAttrKeyClassPublic forKey:(__bridge id)
     kSecAttrKeyClass];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)publicKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    NSAssert(!(status < 0), @"请检查 capabilities keychain sharing 是否打开");
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }
    
    [publicKey removeObjectForKey:(__bridge id)kSecValueData];
    [publicKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef    = nil;
    status              = SecItemCopyMatching((__bridge CFDictionaryRef)publicKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}
+ (NSData *)encryptData:(NSData *)data withKeyRef:(SecKeyRef) keyRef {
    const uint8_t *srcbuf   = (const uint8_t *)[data bytes];
    size_t srclen           = (size_t)data.length;
    
    size_t block_size       = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    void *outbuf            = malloc(block_size);
    size_t src_block_size   = block_size - 11;
    
    NSMutableData *ret      = [[NSMutableData alloc] init];
    for(int idx=0; idx<srclen; idx+=src_block_size){
        //NSLog(@"%d/%d block_size: %d", idx, (int)srclen, (int)block_size);
        size_t data_len     = srclen - idx;
        if(data_len > src_block_size){
            data_len        = src_block_size;
        }
        
        size_t outlen       = block_size;
        OSStatus status     = noErr;
        status              = SecKeyEncrypt(keyRef,
                                            kSecPaddingPKCS1,
                                            srcbuf + idx,
                                            data_len,
                                            outbuf,
                                            &outlen);
        if (status != 0) {
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", (int)status);
            ret = nil;
            break;
        }else{
            [ret appendBytes:outbuf length:outlen];
        }
    }
    
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}
+ (NSData *)stripPublicKeyHeader:(NSData *)d_key {
    // Skip ASN.1 public key header
    if (d_key == nil) return(nil);
    
    unsigned long len = [d_key length];
    if (!len) return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx	 = 0;
    
    if (c_key[idx++] != 0x30) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    // PKCS #1 rsaEncryption szOID_RSA_RSA
    static unsigned char seqiod[] =
    { 0x30,   0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01,
        0x01, 0x05, 0x00 };
    if (memcmp(&c_key[idx], seqiod, 15)) return(nil);
    
    idx += 15;
    
    if (c_key[idx++] != 0x03) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    if (c_key[idx++] != '\0') return(nil);
    
    // Now make a new NSData from this buffer
    return([NSData dataWithBytes:&c_key[idx] length:len - idx]);
}
#pragma mark -- 解密
+ (NSString *)ZYQ_decryptString:(NSString *)str
                    privateKey:(NSString *)privKey{
    NSData *data    = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data            = [self ZYQ_decryptData:data privateKey:privKey];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
+ (NSData *)ZYQ_decryptData:(NSData *)data
                privateKey:(NSString *)privKey{
    if (!data | !privKey) {
        return nil;
    }
    SecKeyRef keyRef = [self addPrivateKey:privKey];
    if(!keyRef){
        return nil;
    }
    return [self decryptData:data withKeyRef:keyRef];
}

+ (SecKeyRef)addPrivateKey:(NSString *)key{
    NSRange spos;
    NSRange epos;
    spos = [key rangeOfString:@"-----BEGIN RSA PRIVATE KEY-----"];
    if(spos.length > 0){
        epos = [key rangeOfString:@"-----END RSA PRIVATE KEY-----"];
    }else{
        spos = [key rangeOfString:@"-----BEGIN PRIVATE KEY-----"];
        epos = [key rangeOfString:@"-----END PRIVATE KEY-----"];
    }
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    NSData *data = base64_decode(key);
    data = [self stripPrivateKeyHeader:data];
    if(!data){
        return nil;
    }
    
    //a tag to read/write keychain storage
    NSString *tag = @"RSAUtil_PrivKey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *privateKey = [[NSMutableDictionary alloc] init];
    [privateKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [privateKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)privateKey);
    
    // Add persistent version of the key to system keychain
    [privateKey setObject:data forKey:(__bridge id)kSecValueData];
    [privateKey setObject:(__bridge id) kSecAttrKeyClassPrivate forKey:(__bridge id)
     kSecAttrKeyClass];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)privateKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }
    
    [privateKey removeObjectForKey:(__bridge id)kSecValueData];
    [privateKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)privateKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}
+ (NSData *)stripPrivateKeyHeader:(NSData *)d_key{
    // Skip ASN.1 private key header
    if (d_key == nil) return(nil);
    
    unsigned long len = [d_key length];
    if (!len) return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx	 = 22; //magic byte at offset 22
    
    if (0x04 != c_key[idx++]) return nil;
    
    //calculate length of the key
    unsigned int c_len = c_key[idx++];
    int det = c_len & 0x80;
    if (!det) {
        c_len = c_len & 0x7f;
    } else {
        int byteCount = c_len & 0x7f;
        if (byteCount + idx > len) {
            //rsa length field longer than buffer
            return nil;
        }
        unsigned int accum = 0;
        unsigned char *ptr = &c_key[idx];
        idx += byteCount;
        while (byteCount) {
            accum = (accum << 8) + *ptr;
            ptr++;
            byteCount--;
        }
        c_len = accum;
    }
    
    // Now make a new NSData from this buffer
    return [d_key subdataWithRange:NSMakeRange(idx, c_len)];
}
+ (NSData *)decryptData:(NSData *)data withKeyRef:(SecKeyRef) keyRef{
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    
    size_t block_size = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    UInt8 *outbuf = malloc(block_size);
    size_t src_block_size = block_size;
    
    NSMutableData *ret = [[NSMutableData alloc] init];
    for(int idx=0; idx<srclen; idx+=src_block_size){
        //NSLog(@"%d/%d block_size: %d", idx, (int)srclen, (int)block_size);
        size_t data_len = srclen - idx;
        if(data_len > src_block_size){
            data_len = src_block_size;
        }
        
        size_t outlen = block_size;
        OSStatus status = noErr;
        status = SecKeyDecrypt(keyRef,
                               kSecPaddingNone,
                               srcbuf + idx,
                               data_len,
                               outbuf,
                               &outlen
                               );
        if (status != 0) {
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", (int)status);
            ret = nil;
            break;
        }else{
            //the actual decrypted data is in the middle, locate it!
            int idxFirstZero = -1;
            int idxNextZero = (int)outlen;
            for ( int i = 0; i < outlen; i++ ) {
                if ( outbuf[i] == 0 ) {
                    if ( idxFirstZero < 0 ) {
                        idxFirstZero = i;
                    } else {
                        idxNextZero = i;
                        break;
                    }
                }
            }
            
            [ret appendBytes:&outbuf[idxFirstZero+1] length:idxNextZero-idxFirstZero-1];
        }
    }
    
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}
#pragma mark -- 文件密钥加解密
//加密
+ (NSData *)ZYQ_encryptData:(NSData *)data
         publicKeyWithPath:(NSString *)filePath {
    SecKeyRef publicKeyRef;
    NSAssert(filePath.length != 0, @"公钥路径为空");
    // 从一个 DER 表示的证书创建一个证书对象
    NSData *certificateData = [NSData dataWithContentsOfFile:filePath];
    SecCertificateRef certificateRef = SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)certificateData);
    NSAssert(certificateRef != NULL, @"公钥文件错误");
    // 返回一个默认 X509 策略的公钥对象，使用之后需要调用 CFRelease 释放
    SecPolicyRef policyRef = SecPolicyCreateBasicX509();
    // 包含信任管理信息的结构体
    SecTrustRef trustRef;
    // 基于证书和策略创建一个信任管理对象
    OSStatus status = SecTrustCreateWithCertificates(certificateRef, policyRef, &trustRef);
    NSAssert(status == errSecSuccess, @"创建信任管理对象失败");
    // 信任结果
    SecTrustResultType trustResult;
    // 评估指定证书和策略的信任管理是否有效
    status = SecTrustEvaluate(trustRef, &trustResult);
    NSAssert(status == errSecSuccess, @"信任评估失败");
    // 评估之后返回公钥子证书
    publicKeyRef = SecTrustCopyPublicKey(trustRef);
    NSAssert(publicKeyRef != NULL, @"公钥创建失败");
    if (certificateRef) CFRelease(certificateRef);
    if (policyRef) CFRelease(policyRef);
    if (trustRef) CFRelease(trustRef);
    return [self encryptData:data withKeyRef:publicKeyRef];
}
+ (NSData *)encryptData:(NSData *)data
           publicKeyRef:(SecKeyRef)publicKeyRef{
    OSStatus sanityCheck = noErr;
    size_t cipherBufferSize = 0;
    size_t keyBufferSize = 0;
    NSAssert(data, @"明文数据为空");
    NSAssert(publicKeyRef, @"公钥为空");
    NSData *cipher = nil;
    uint8_t *cipherBuffer = NULL;
    // 计算缓冲区大小
    cipherBufferSize = SecKeyGetBlockSize(publicKeyRef);
    keyBufferSize = data.length;
    if (kTypeOfWrapPadding == kSecPaddingNone) {
        NSAssert(keyBufferSize <= cipherBufferSize, @"加密内容太大");
    } else {
        NSAssert(keyBufferSize <= (cipherBufferSize - 11), @"加密内容太大");
    }
    // 分配缓冲区
    cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    memset((void *)cipherBuffer, 0x0, cipherBufferSize);
    // 使用公钥加密
    sanityCheck = SecKeyEncrypt(publicKeyRef,
                                kTypeOfWrapPadding,
                                (const uint8_t *)data.bytes,
                                keyBufferSize,
                                cipherBuffer,
                                &cipherBufferSize
                                );
    NSAssert(sanityCheck == noErr, @"加密错误，OSStatus == %d", (int)sanityCheck);
    // 生成密文数据
    cipher = [NSData dataWithBytes:(const void *)cipherBuffer length:(NSUInteger)cipherBufferSize];
    if (cipherBuffer) free(cipherBuffer);
    return cipher;
}
+ (NSString *)ZYQ_encryptNSString:(NSString *)str
               publicKeyWithPath:(NSString *)filePath {
    if (filePath == nil) {
        return @"";
    }
    NSData *encryptData = [self ZYQ_encryptData:[str dataUsingEncoding:NSUTF8StringEncoding] publicKeyWithPath:filePath];
    return [encryptData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

//解密

+ (NSData *)ZYQ_decryptData:(NSData *)data
                privateKeyWithPath:(NSString *)filePath
                  password:(NSString *)password{
    NSAssert(filePath.length != 0, @"私钥路径为空");
    SecKeyRef privateKeyRef;
    NSData *PKCS12Data = [NSData dataWithContentsOfFile:filePath];
    CFDataRef inPKCS12Data = (__bridge CFDataRef)PKCS12Data;
    CFStringRef passwordRef = (__bridge CFStringRef)password;
    // 从 PKCS #12 证书中提取标示和证书
    SecIdentityRef myIdentity;
    SecTrustRef myTrust;
    const void *keys[] = {kSecImportExportPassphrase};
    const void *values[] = {passwordRef};
    CFDictionaryRef optionsDictionary = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    // 返回 PKCS #12 格式数据中的标示和证书
    OSStatus status = SecPKCS12Import(inPKCS12Data, optionsDictionary, &items);
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex(items, 0);
    myIdentity = (SecIdentityRef)CFDictionaryGetValue(myIdentityAndTrust, kSecImportItemIdentity);
    myTrust = (SecTrustRef)CFDictionaryGetValue(myIdentityAndTrust, kSecImportItemTrust);
    if (optionsDictionary) CFRelease(optionsDictionary);
    NSAssert(status == noErr, @"提取身份和信任失败");
    SecTrustResultType trustResult;
    // 评估指定证书和策略的信任管理是否有效
    status = SecTrustEvaluate(myTrust, &trustResult);
    NSAssert(status == errSecSuccess, @"信任评估失败");
    // 提取私钥
    status = SecIdentityCopyPrivateKey(myIdentity, &privateKeyRef);
    NSAssert(status == errSecSuccess, @"私钥创建失败");
    CFRelease(items);
    return [self decryptData:data privateKeyRef:privateKeyRef];
}

+ (NSData *)decryptData:(NSData *)data
          privateKeyRef:(SecKeyRef)privateKeyRef{
    OSStatus sanityCheck = noErr;
    size_t cipherBufferSize = 0;
    size_t keyBufferSize = 0;
    NSData *key = nil;
    uint8_t *keyBuffer = NULL;
    SecKeyRef privateKey = privateKeyRef;
    NSAssert(privateKey != NULL, @"私钥不存在");
    // 计算缓冲区大小
    cipherBufferSize = SecKeyGetBlockSize(privateKey);
    keyBufferSize = data.length;
    
    NSAssert(keyBufferSize <= cipherBufferSize, @"解密内容太大");
    // 分配缓冲区
    keyBuffer = malloc(keyBufferSize * sizeof(uint8_t));
    memset((void *)keyBuffer, 0x0, keyBufferSize);
    // 使用私钥解密
    sanityCheck = SecKeyDecrypt(privateKey,
                                kTypeOfWrapPadding,
                                (const uint8_t *)data.bytes,
                                cipherBufferSize,
                                keyBuffer,
                                &keyBufferSize
                                );
    NSAssert1(sanityCheck == noErr, @"解密错误，OSStatus == %d", sanityCheck);
    // 生成明文数据
    key = [NSData dataWithBytes:(const void *)keyBuffer length:(NSUInteger)keyBufferSize];
    if (keyBuffer) free(keyBuffer);
    return key;
}
+ (NSString *)ZYQ_decryptNSString:(NSString *)str
                      privateKeyWithPath:(NSString *)filePath
                        password:(NSString *)password{
    NSData *decryptData = [self ZYQ_decryptData:[[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters]  privateKeyWithPath:filePath password:password];
    return [[NSString alloc]initWithData:decryptData encoding:NSUTF8StringEncoding ];
}

@end
