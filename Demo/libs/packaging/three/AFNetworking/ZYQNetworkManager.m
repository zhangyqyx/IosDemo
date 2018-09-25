//
//  ZYQNetworkManager.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/25.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQNetworkManager.h"
#import "AFNetworking.h"
@implementation ZYQNetworkManager
/**
 *  是否开启https SSL 验证
 *
 *  @return YES为开启，NO为关闭
 */
#define openHttpsSSL NO
/**
 *  SSL 证书名称，仅支持cer格式。“app.bishe.com.cer”,则填“app.bishe.com”
 */
#define certificate @"adn"
/** 默认超时时间 */
#define kTimeOutInterval 30
+ (AFHTTPSessionManager *)ZYQSharedManager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
        manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
        //        manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
        // 声明获取到的数据格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
        //    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
        // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
        // 加上这行代码，https ssl 验证。
        if(openHttpsSSL){
            [manager setSecurityPolicy:[self ZYQCustomSecurityPolicy]];
        }
        // 超时时间
        manager.requestSerializer.timeoutInterval = kTimeOutInterval;
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain", nil];
        // 设置超时时间
        manager.requestSerializer.timeoutInterval = 30.f;
    });
    return manager;
}
+ (AFSecurityPolicy*)ZYQCustomSecurityPolicy{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:certificate ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    securityPolicy.pinnedCertificates = [NSSet setWithArray:@[certData]];
    return securityPolicy;
}

#pragma mark - post请求
+ (void)ZYQ_httpForPOSTWithParam:(NSDictionary *)param
                          urlStr:(NSString *)urlStr
                         success:(void (^)(NSURLSessionDataTask *,  id responseObject))success
                            fail:(void (^)(NSURLSessionDataTask *, NSError *))fail {
    [self ZYQ_httpForPOSTWithParam:param
                            urlStr:urlStr
                           outTime:kTimeOutInterval
                           success:success
                              fail:fail];
}
+ (void)ZYQ_httpForPOSTWithParam:(NSDictionary *)param
                          urlStr:(NSString *)urlStr
                         outTime:(NSTimeInterval)outTime
                         success:(void (^)(NSURLSessionDataTask *,  id responseObject))success
                            fail:(void (^)(NSURLSessionDataTask *, NSError *))fail {
    [self ZYQ_httpForPOSTWithParam:param
                            urlStr:urlStr
                           outTime:outTime
                          progress:nil
                           success:success
                              fail:fail];
}
+ (void)ZYQ_httpForPOSTWithParam:(NSDictionary *)param
                          urlStr:(NSString *)urlStr
                         outTime:(NSTimeInterval)outTime
                        progress:(void(^)(NSProgress *uploadProgress))progress
                         success:(void (^)(NSURLSessionDataTask *,  id responseObject))success
                            fail:(void (^)(NSURLSessionDataTask *, NSError *))fail {
    AFHTTPSessionManager *manager = [self ZYQSharedManager];
    manager.requestSerializer.timeoutInterval = outTime;
    
    [manager POST:urlStr
       parameters:param
         progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task , responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}
#pragma mark - get请求
+ (void)ZYQ_httpForGETWithParam:(NSDictionary *)param
                         urlStr:(NSString *)urlStr
                        success:(void (^)(NSURLSessionDataTask *,  id ))success
                           fail:(void (^)(NSURLSessionDataTask *, NSError *))fail {
    [self ZYQ_httpForGETWithParam:param urlStr:urlStr outTime:kTimeOutInterval success:success fail:fail];
}
+ (void)ZYQ_httpForGETWithParam:(NSDictionary *)param
                         urlStr:(NSString *)urlStr
                        outTime:(NSTimeInterval)outTime
                        success:(void (^)(NSURLSessionDataTask *, id))success
                           fail:(void (^)(NSURLSessionDataTask *, NSError *))fail {
    [self ZYQ_httpForGETWithParam:param
                           urlStr:urlStr
                          outTime:outTime
                         progress:nil
                          success:success
                             fail:fail];
}
+ (void)ZYQ_httpForGETWithParam:(NSDictionary *)param
                         urlStr:(NSString *)urlStr
                        outTime:(NSTimeInterval)outTime
                       progress:(void(^)(NSProgress *uploadProgress))progress
                        success:(void (^)(NSURLSessionDataTask *, id))success
                           fail:(void (^)(NSURLSessionDataTask *, NSError *))fail {
    AFHTTPSessionManager *manager = [self ZYQSharedManager];
    manager.requestSerializer.timeoutInterval = outTime;
    [manager GET:urlStr
      parameters:param
        progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task ,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}
#pragma mark - DELETE请求

+ (void)ZYQ_httpForDELETEWithParam:(NSDictionary *)param
                            urlStr:(NSString *)urlStr
                           success:(void (^)(NSURLSessionDataTask *, id))success
                              fail:(void (^)(NSURLSessionDataTask *, NSError *))fail {
    [self ZYQ_httpForDELETEWithParam:param
                              urlStr:urlStr
                             outTime:kTimeOutInterval
                             success:success
                                fail:fail];
}
+ (void)ZYQ_httpForDELETEWithParam:(NSDictionary *)param
                            urlStr:(NSString *)urlStr
                           outTime:(NSTimeInterval)outTime
                           success:(void (^)(NSURLSessionDataTask *, id))success
                              fail:(void (^)(NSURLSessionDataTask *, NSError *))fail {
    AFHTTPSessionManager *manager = [self ZYQSharedManager];
    manager.requestSerializer.timeoutInterval = outTime;
    [manager DELETE:urlStr
         parameters:param
            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task , responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task , error);
    }];
  
}

#pragma mark - PATCH请求
+ (void)ZYQ_httpForPATCHWithParam:(NSDictionary *)param
                           urlStr:(NSString *)urlStr
                          success:(void (^)(NSURLSessionDataTask *task,id))success
                             fail:(void(^)(NSURLSessionDataTask *task,NSError *error))fail {
    [self ZYQ_httpForPATCHWithParam:param
                             urlStr:urlStr
                            outTime:kTimeOutInterval
                            success:success
                               fail:fail];
}
+ (void)ZYQ_httpForPATCHWithParam:(NSDictionary *)param
                           urlStr:(NSString *)urlStr
                          outTime:(NSTimeInterval)outTime
                          success:(void (^)(NSURLSessionDataTask *task,id))success
                             fail:(void(^)(NSURLSessionDataTask *task,NSError *error))fail {
    AFHTTPSessionManager *manager = [self ZYQSharedManager];
    manager.requestSerializer.timeoutInterval = outTime;
    [manager PATCH:urlStr
        parameters:param
           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task , responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task ,error);
    }];
}
#pragma mark - PUT请求

+ (void)ZYQ_httpForPUTWithParam:(NSDictionary *)param
                         urlStr:(NSString *)urlStr
                        success:(void (^)(NSURLSessionDataTask *task,id))success
                           fail:(void(^)(NSURLSessionDataTask *task,NSError *error))fail {
    [self ZYQ_httpForPUTWithParam:param
                           urlStr:urlStr
                          outTime:kTimeOutInterval
                          success:success
                             fail:fail];
}
+ (void)ZYQ_httpForPUTWithParam:(NSDictionary *)param
                         urlStr:(NSString *)urlStr
                        outTime:(NSTimeInterval)outTime
                        success:(void (^)(NSURLSessionDataTask *task,id))success
                           fail:(void(^)(NSURLSessionDataTask *task,NSError *error))fail {
    AFHTTPSessionManager *manager = [self ZYQSharedManager];
    manager.requestSerializer.timeoutInterval = outTime;
    [manager PUT:urlStr
      parameters:param
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task , responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task , error);
    }];
}

#pragma mark - 取消所有网络请求
+ (void)cancleAllNetwork {
    AFHTTPSessionManager *manager  = [self ZYQSharedManager];
    [manager.operationQueue cancelAllOperations];
    
}


@end
