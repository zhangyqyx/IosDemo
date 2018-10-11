//
//  ZYQHealthManager.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/11.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>

typedef NS_ENUM(NSUInteger , ZYQQuantityType){
   ZYQQuantityTypeStep                   = 1 << 0, //步行
   ZYQQuantityTypeWalking                = 1 << 1,//跑步 + 步行
   ZYQQuantityTypeCycling                = 1 << 2,//骑行
   ZYQQuantityTypeSwimming               = 1 << 3,//游泳
   ZYQQuantityTypeHeight                 = 1 << 4,//身高
   ZYQQuantityTypeBodyMass               = 1 << 5 ,//体重
   ZYQQuantityTypeActiveEnergyBurned     = 1 << 6,//活动能量
   ZYQQuantityTypeBasalEnergyBurned      = 1 << 7,//膳食能量
   ZYQQuantityTypeBloodGlucose           = 1 << 8,//血糖
   ZYQQuantityTypeBloodPressureSystolic  = 1 << 9, // 收缩压
   ZYQQuantityTypeBloodPressureDiastolic = 1 << 10 //舒张压
};

typedef NS_ENUM(NSUInteger, ZYQHealthIntervalUnit) {
    ZYQHealthIntervalUnitDay,
    ZYQHealthIntervalUnitWeek,
    ZYQHealthIntervalUnitMonth,
    ZYQHealthIntervalUnitYear
};



@interface ZYQHealthManager : NSObject
+ (instancetype)ZYQ_standardHealthManager;

/**
 *  判断设备是否支持健康应用
 *
 *  @return YES 支持  NO 不支持
 */
+ (BOOL)ZYQ_isHealthDataAvailable;

/**
 判断是否授权分享数据
 @param type 设备类型
 @return 是否授权
 */
+ (BOOL)ZYQ_isAuthorizationStatusForType:(HKObjectType *)type;


/**
 应用授权
 @param type 授权类型
 @param resultBlock 结果
 */
+ (void)ZYQ_authorizeHealthKitWithType:(ZYQQuantityType)type
                               result:(void(^)(BOOL isAuthorizateSuccess ,NSError *error))resultBlock;
/**
 *  获得当天获取所有健康数据 (一个小时一次统计)  startDate:开始时间key 、endDate:结束时间key 、stepCount步数key
 */
+ (void)ZYQ_fetchAllHealthDataByDay:(void (^)(NSArray *modelArray))queryResultBlock;
/**
 获得当天的所有步数
 */
+ (void)ZYQ_getAllStepCount:(void(^)(NSUInteger stepCount))stepCountBlock;

/**
 获取健康应用步数信息
 @param unit 数据段类型
 @param queryResultBlock 返回数据 
 */
+ (void)ZYQ_fetchAllHealthType:(ZYQHealthIntervalUnit)unit
             queryResultBlock:(void (^)(NSArray *queryResults))queryResultBlock;
/**
 获取健康应用步数信息
 @param startDate 开始时间
 @param endDate 结束时间
 @param hComponents NSDateComponents   例如： hComponents = [calendar components:NSCalendarUnitHour fromDate:endDate];  [hComponents setHour:1];  是每个小时统计一次
 @param queryResultBlock 返回数据
 */
+ (void)ZYQ_fetchAllHealthStartDate:(NSDate *)startDate
                           endDate:(NSDate *)endDate
                       hComponents:(NSDateComponents *)hComponents
                  queryResultBlock:(void (^)(NSArray *queryResults))queryResultBlock;

#pragma mark -- 获取12点到现在的数据
/**
 获得今天0点到现在每个小时的步数
 @param queryResultBlock 返回结果
 */
+ (void)ZYQ_getStepCountWithHourOf0ClockBlock:(void (^)(NSArray *queryResults))queryResultBlock;

#pragma mark -- 获取当天的数据

/**
 获取当天的数据
 @param unit 数据段类型
 @param queryResultBlock 返回数据
 */
+ (void)ZYQ_getDayHealthWithType:(ZYQQuantityType)unit
               queryResultBlock:(void (^)(NSArray *queryResults))queryResultBlock;


#pragma mark -- 写入数据

/**
 保存healthKit数据

 @param type 要保存的类型
 @param startDate 开始时间
 @param endDate 结束时间
 @param number 数值
 @param block 是否成功回调
 */
+ (void)ZYQ_saveHealthKitDataType:(ZYQQuantityType )type
                       startDate:(NSDate *)startDate
                         endDate:(NSDate *)endDate
                          number:(CGFloat)number
                         success:(void(^)(BOOL isSuccess , NSError *error))block;
@end
