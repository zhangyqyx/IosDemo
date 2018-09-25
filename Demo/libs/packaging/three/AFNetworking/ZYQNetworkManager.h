//
//  ZYQNetworkManager.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/25.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYQNetworkManager : NSObject

#pragma mark - post请求
/**
 POST请求调用方法（默认超时时间）

 @param param 请求参数
 @param urlStr 地址
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)ZYQ_httpForPOSTWithParam:(NSDictionary *)param
                          urlStr:(NSString *)urlStr
                         success:(void (^)(NSURLSessionDataTask *task ,  id responseObject))success
                            fail:(void(^)(NSURLSessionDataTask *task,NSError *error))fail;

/**
 POST请求调用方法 （可设置超时时间）

 @param param 请求参数
 @param urlStr 地址
 @param outTime 超时时间
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)ZYQ_httpForPOSTWithParam:(NSDictionary *)param
                          urlStr:(NSString *)urlStr
                         outTime:(NSTimeInterval)outTime
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            fail:(void(^)(NSURLSessionDataTask *task,NSError *error))fail;

/**
 POST请求调用方法 （可设置超时时间 , 有请求进度）
 
 @param param 参数
 @param urlStr 地址
 @param outTime 超时时间
 @param progress 请求进度
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)ZYQ_httpForPOSTWithParam:(NSDictionary *)param
                          urlStr:(NSString *)urlStr
                         outTime:(NSTimeInterval)outTime
                        progress:(void(^)(NSProgress *uploadProgress))progress
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            fail:(void(^)(NSURLSessionDataTask *task,NSError *error))fail;
#pragma mark - get请求
/**
 GET请求调用方法（默认超时时间）
 
@param param 请求参数
@param urlStr 地址
@param success 成功回调
@param fail 失败回调
*/
+ (void)ZYQ_httpForGETWithParam:(NSDictionary *)param
                         urlStr:(NSString *)urlStr
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           fail:(void(^)(NSURLSessionDataTask *task,NSError *error))fail;

/**
 GET请求调用方法 （可设置超时时间）
 
 @param param 请求参数
 @param urlStr 地址
 @param outTime 超时时间
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)ZYQ_httpForGETWithParam:(NSDictionary *)param urlStr:(NSString *)urlStr
                        outTime:(NSTimeInterval)outTime
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           fail:(void(^)(NSURLSessionDataTask *task,NSError *error))fail;

/**
 GET请求调用方法 （可设置超时时间 , 有请求进度）
 
 @param param 参数
 @param urlStr 地址
 @param outTime 超时时间
 @param progress 请求进度
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)ZYQ_httpForGETWithParam:(NSDictionary *)param
                         urlStr:(NSString *)urlStr
                        outTime:(NSTimeInterval)outTime
                       progress:(void(^)(NSProgress *uploadProgress))progress
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           fail:(void(^)(NSURLSessionDataTask *task,NSError *error))fail;
#pragma mark - DELETE请求
/**
 DELETE请求调用方法（默认超时时间）
 
 @param param 请求参数
 @param urlStr 地址
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)ZYQ_httpForDELETEWithParam:(NSDictionary *)param
                            urlStr:(NSString *)urlStr
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                              fail:(void(^)(NSURLSessionDataTask *task,NSError *error))fail;
/**
 DELETE请求调用方法 （可设置超时时间）
 
 @param param 请求参数
 @param urlStr 地址
 @param outTime 超时时间
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)ZYQ_httpForDELETEWithParam:(NSDictionary *)param
                            urlStr:(NSString *)urlStr
                           outTime:(NSTimeInterval)outTime
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                              fail:(void(^)(NSURLSessionDataTask *task,NSError *error))fail;

#pragma mark - PATCH请求
/**
  PATCH请求调用方法（默认超时时间）
 
 @param param 请求参数
 @param urlStr 地址
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)ZYQ_httpForPATCHWithParam:(NSDictionary *)param
                           urlStr:(NSString *)urlStr
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             fail:(void(^)(NSURLSessionDataTask *task,NSError *error))fail;
/**
 PATCH请求调用方法 （可设置超时时间）
 
 @param param 请求参数
 @param urlStr 地址
 @param outTime 超时时间
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)ZYQ_httpForPATCHWithParam:(NSDictionary *)param
                           urlStr:(NSString *)urlStr
                          outTime:(NSTimeInterval)outTime
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             fail:(void(^)(NSURLSessionDataTask *task,NSError *error))fail;

#pragma mark - PUT请求
/**
 PUT请求调用方法（默认超时时间）
 
 @param param 请求参数
 @param urlStr 地址
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)ZYQ_httpForPUTWithParam:(NSDictionary *)param
                         urlStr:(NSString *)urlStr
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           fail:(void(^)(NSURLSessionDataTask *task,NSError *error))fail;
/**
 PUT请求调用方法 （可设置超时时间）
 
 @param param 请求参数
 @param urlStr 地址
 @param outTime 超时时间
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)ZYQ_httpForPUTWithParam:(NSDictionary *)param
                         urlStr:(NSString *)urlStr
                        outTime:(NSTimeInterval)outTime
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           fail:(void(^)(NSURLSessionDataTask *task,NSError *error))fail;

#pragma mark - 取消所有网络请求

/**
 取消所有网络请求
 */
+ (void)cancleAllNetwork;



@end
