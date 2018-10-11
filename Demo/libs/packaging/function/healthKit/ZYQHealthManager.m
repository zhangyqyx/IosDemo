//
//  ZYQHealthManager.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/11.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQHealthManager.h"
#import "NSDate+HKDate.h"

@interface ZYQHealthManager ()

/** healthStore */
@property (nonatomic , strong)HKHealthStore *healthStore;

@end

static ZYQHealthManager *_healthManager = nil;

@implementation ZYQHealthManager

- (HKHealthStore *)healthStore {
    if (!_healthStore) {
        _healthStore = [[HKHealthStore alloc] init];
      
    }
    return _healthStore;
}

+ (instancetype)ZYQ_standardHealthManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _healthManager = [[ZYQHealthManager alloc] init];
    });
    return _healthManager;
}
+ (BOOL)ZYQ_isHealthDataAvailable {
    
    return [HKHealthStore isHealthDataAvailable];
}
+ (BOOL)ZYQ_isAuthorizationStatusForType:(HKObjectType *)type {
    HKAuthorizationStatus  authorizationType = [[ZYQHealthManager ZYQ_standardHealthManager].healthStore authorizationStatusForType:type];
    if (authorizationType == HKAuthorizationStatusSharingDenied) {
        return NO;
    }
    return YES;
}
+ (void)ZYQ_authorizeHealthKitWithType:(ZYQQuantityType)type result:(void(^)(BOOL isAuthorizateSuccess ,NSError *error))resultBlock {
    NSMutableSet *readSet = [NSMutableSet set];
    if (type & ZYQQuantityTypeStep) {
       [readSet addObject:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]];
    }
    if (type & ZYQQuantityTypeWalking) {
         [readSet addObject:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning]];
    }
    if (type & ZYQQuantityTypeCycling) {
        [readSet addObject:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling]];
    }
    if (type & ZYQQuantityTypeSwimming) {
        if (@available(iOS 10.0, *)) {
            [readSet addObject:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceSwimming]];
        } else {
            // Fallback on earlier versions
        }
    }
    if (type & ZYQQuantityTypeHeight) {
        [readSet addObject:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight]];
    }
    if (type & ZYQQuantityTypeBodyMass) {
       [readSet addObject:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass]];
    }
    if (type & ZYQQuantityTypeActiveEnergyBurned) {
        [readSet addObject:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned]];
    }
    if (type & ZYQQuantityTypeBasalEnergyBurned) {
        [readSet addObject:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned]];
    }
    
    if (type & ZYQQuantityTypeBloodGlucose) {
        [readSet addObject:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose]];
    }
    if (type & ZYQQuantityTypeBloodPressureSystolic) {
       [readSet addObject:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic]];
    }
    if (type & ZYQQuantityTypeBloodPressureDiastolic) {
       [readSet addObject:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic]];
    }
   
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        [[ZYQHealthManager ZYQ_standardHealthManager].healthStore requestAuthorizationToShareTypes:readSet readTypes:readSet completion:^(BOOL success, NSError * _Nullable error) {
            if (resultBlock) {
                resultBlock(success , error);
            }
        }];
//    });
    
}
#pragma mark -- 获取的数据一天中所有的步数
+ (void)ZYQ_fetchAllHealthDataByDay:(void (^)(NSArray *modelArray))queryResultBlock {
    [self ZYQ_fetchAllHealthType:ZYQHealthIntervalUnitDay queryResultBlock:^(NSArray *queryResults) {
        if (queryResultBlock) {
            queryResultBlock(queryResults);
        }
    }];
}
#pragma mark  获取一天中总共的步数
+ (void)ZYQ_getAllStepCount:(void(^)(NSUInteger stepCount))stepCountBlock{
    [self ZYQ_fetchAllHealthDataByDay:^(NSArray *modelArray) {
        NSUInteger stepCount = 0;
        for (NSDictionary *dic in modelArray) {
            NSNumber *count = dic[@"stepCount"];
            stepCount += [count integerValue];
        }
        stepCountBlock(stepCount);
    }];
}

#pragma mark -- 根据不同类型获取
+ (void)ZYQ_fetchAllHealthType:(ZYQHealthIntervalUnit)unit
             queryResultBlock:(void (^)(NSArray *queryResults))queryResultBlock {
    
        __block NSCalendar *calendar    = [NSDate HK_sharedCalendar];
        NSDate *endDate                 = [NSDate HK_getCurrentDate];
        NSDateComponents *hComponents;
        NSDate *startDate ;
        switch (unit) {
            case ZYQHealthIntervalUnitDay:
            {
    //            间隔一小时统计一次
                startDate               = [NSDate HK_dateAfterDate:endDate day:-1];
                hComponents             = [calendar components:NSCalendarUnitHour fromDate:endDate];
                [hComponents setHour:1];
            }
                break;
            case ZYQHealthIntervalUnitWeek:
            {
    //            间隔一天统计一次
                startDate               = [NSDate HK_dateAfterDate:endDate day:-7];
                hComponents             = [calendar components:NSCalendarUnitDay fromDate:endDate];
                [hComponents setDay:1];
            }
                break;
            case ZYQHealthIntervalUnitMonth:
            {
    //            间隔一周统计一次
                startDate               = [NSDate HK_dateAfterDate:endDate month:-1];
                hComponents             = [calendar components:NSCalendarUnitDay fromDate:endDate];
                [hComponents setDay:6];
            }
                break;
            case ZYQHealthIntervalUnitYear:
            {
    //            间隔一月统计一次
                startDate               = [NSDate HK_dateAfterDate:endDate year:-1];
                hComponents             = [calendar components:NSCalendarUnitMonth fromDate:endDate];
                [hComponents setMonth:1];
            }
                break;
            default:
                
                break;
        }
    [self ZYQ_fetchAllHealthStartDate:startDate endDate:endDate hComponents:hComponents queryResultBlock:^(NSArray *queryResults) {
        if (queryResultBlock) {
            queryResultBlock(queryResults);
        }
    }];
}
#pragma mark -- 根据不同时间获取
+ (void)ZYQ_fetchAllHealthStartDate:(NSDate *)startDate
                           endDate:(NSDate *)endDate
                       hComponents:(NSDateComponents *)hComponents
                  queryResultBlock:(void (^)(NSArray *queryResults))queryResultBlock {
    [self ZYQ_fetchAllHealthStartDate:startDate endDate:endDate hComponents:hComponents quantityType:ZYQQuantityTypeStep  type:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount] queryResultBlock:^(NSArray *queryResults) {
        if (queryResultBlock) {
            queryResultBlock(queryResults);
        }
    }];
}

#pragma mark -- 获取0点到现在的数据
+ (void)ZYQ_getStepCountWithHourOf0ClockBlock:(void (^)(NSArray *queryResults))queryResultBlock{
    NSArray *dateArr = [self getAllDate];
    NSMutableArray *currentDateArray       = [NSMutableArray array];
    //获取要取得时间步数
    for (NSArray *dArr in dateArr) {
        NSDate *endDate = dArr[1];
//        NSDate *currentDate = [NSDate ZYQ_getCurrentDate];
        NSDate *currentDate = [NSDate date];
        if ([NSDate HK_compareDate:endDate withAnotherDate:currentDate withIsIncludeSecond:YES ] == 1) {
            break;
        }else {
            [currentDateArray addObject:dArr];
        }
    }
    //获取每个小时的步数
    NSMutableArray *array       = [NSMutableArray array];
    for (NSArray *dArr in currentDateArray) {
        NSDate *startDate = dArr[0];
        NSDate *endDate = dArr[1];
         __block NSCalendar *calendar    = [NSDate HK_sharedCalendar];
        NSDateComponents *hComponents = [calendar components:NSCalendarUnitHour fromDate:endDate];
        [hComponents setHour:1];
        HKQuantityType *quantityType        = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
        NSPredicate *predicate              = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
        NSUInteger op                       = HKStatisticsOptionCumulativeSum;
        HKStatisticsCollectionQuery  *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:predicate options:op anchorDate:startDate intervalComponents:hComponents];
        query.initialResultsHandler         = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection * __nullable result, NSError * __nullable error) {
            if (error){
                NSLog(@"统计update出错 %@", error);
                return;
            }else {

                for (HKStatistics *statist in result.statistics){
                    double sum4             = [statist.sumQuantity doubleValueForUnit:[HKUnit countUnit]];
                    NSDictionary *dic       = @{@"stepCount":@(sum4),
                                                @"startDate":[NSDate HK_getNewTimeFormat:[NSDate HK_ymd_hmsFormatIs24hour:YES] date:statist.startDate] ,
                                                @"endDate":[NSDate HK_getNewTimeFormat:[NSDate HK_ymd_hmsFormatIs24hour:YES] date: statist.endDate]
                                                };
                    [array addObject:dic];
                }
                if (result.statistics.count == 0) {
                    NSDictionary *dic       = @{@"stepCount":@(0),
                                                @"startDate":[NSDate HK_getNewTimeFormat:[NSDate HK_ymd_hmsFormatIs24hour:YES] date:startDate] ,
                                                @"endDate":[NSDate HK_getNewTimeFormat:[NSDate HK_ymd_hmsFormatIs24hour:YES] date:endDate]
                                                };
                    [array addObject:dic];
                }
                if (queryResultBlock &&array.count == currentDateArray.count) {
                    queryResultBlock(array);
                }
            };
        };
        [[ZYQHealthManager ZYQ_standardHealthManager].healthStore executeQuery:query];
    }
}
+ (NSArray *)getAllDate {
    NSString *dateStr               = [NSDate HK_getNewTimeFormat:[NSDate HK_ymdFormat]];
    NSString *startDateStr          = [NSString stringWithFormat:@"%@ 00:00:00" , dateStr];
    NSDate *startDate               = [NSDate HK_dateWithString:startDateStr format:[NSDate HK_ymd_hmsFormatIs24hour:YES]];
    NSMutableArray *endDateArray    = [NSMutableArray array];
    [endDateArray addObject:startDate];
    for (int i = 1; i < 25; i ++) {
      NSDate  *date                 = [NSDate HK_dateAfterDate:startDate hour:i];
        [endDateArray addObject:date];
    }
    NSMutableArray * allDatePeriods = [NSMutableArray array];
    for (int i = 0; i < endDateArray.count ; i++) {
        if (i+1 >= endDateArray.count) {
            break;
        }
        NSDate * startDate          = endDateArray[i];
        NSDate *endDate             = endDateArray[i+1];
        NSArray *arr = @[startDate,endDate];
        [allDatePeriods addObject:arr];
    }
    return [allDatePeriods copy];
}
#pragma mark -- 获取当天的数据
+ (void)ZYQ_getDayHealthWithType:(ZYQQuantityType)unit
               queryResultBlock:(void (^)(NSArray *queryResults))queryResultBlock{
    __block NSCalendar *calendar    = [NSDate HK_sharedCalendar];
    NSDate *endDate                 = [NSDate HK_getCurrentDate];
    NSDate *startDate               = [NSDate HK_dateAfterDate:endDate day:-1];
    NSDateComponents *hComponents   = [calendar components:NSCalendarUnitHour fromDate:endDate];
    [hComponents setHour:1];
    HKQuantityType *quantityType;
    switch (unit) {
        case ZYQQuantityTypeStep:
        {
            quantityType  = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
            [self ZYQ_fetchAllHealthStartDate:startDate endDate:endDate hComponents:hComponents quantityType:ZYQQuantityTypeStep type:quantityType queryResultBlock:^(NSArray *queryResults) {
                if (queryResultBlock) {
                    queryResultBlock(queryResults);
                }
            }];
        }
            break;
        case ZYQQuantityTypeWalking:
        {   quantityType  = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
            [self ZYQ_fetchAllHealthStartDate:startDate endDate:endDate hComponents:hComponents quantityType:ZYQQuantityTypeWalking type:quantityType  queryResultBlock:^(NSArray *queryResults) {
                if (queryResultBlock) {
                    queryResultBlock(queryResults);
                }
            }];
        }
            break;
        case ZYQQuantityTypeCycling:
        {
            quantityType  = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling];
            [self ZYQ_fetchAllHealthStartDate:startDate endDate:endDate hComponents:hComponents quantityType:ZYQQuantityTypeCycling type:quantityType queryResultBlock:^(NSArray *queryResults) {
                if (queryResultBlock) {
                    queryResultBlock(queryResults);
                }
            }];
        }
            break;
        case ZYQQuantityTypeSwimming:
            
        {
            if (@available(iOS 10.0, *)) {
                quantityType  = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceSwimming];
            } else {
                // Fallback on earlier versions
            }
            [self ZYQ_fetchAllHealthStartDate:startDate endDate:endDate hComponents:hComponents quantityType:ZYQQuantityTypeSwimming type:quantityType queryResultBlock:^(NSArray *queryResults) {
                if (queryResultBlock) {
                    queryResultBlock(queryResults);
                }
            }];
        }
            break;
        case ZYQQuantityTypeActiveEnergyBurned:
            
        {
            quantityType  = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
            [self ZYQ_fetchAllHealthStartDate:startDate endDate:endDate hComponents:hComponents quantityType:ZYQQuantityTypeActiveEnergyBurned type:quantityType  queryResultBlock:^(NSArray *queryResults) {
                if (queryResultBlock) {
                    queryResultBlock(queryResults);
                }
            }];
        }
            break;
        case ZYQQuantityTypeBasalEnergyBurned:
        {
            quantityType  = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned];
            [self ZYQ_fetchAllHealthStartDate:startDate endDate:endDate hComponents:hComponents quantityType:ZYQQuantityTypeBasalEnergyBurned type:quantityType queryResultBlock:^(NSArray *queryResults) {
                if (queryResultBlock) {
                    queryResultBlock(queryResults);
                }
            }];
        }
            
            break;
        case ZYQQuantityTypeHeight:
        {
         quantityType  = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
            [self ZYQ_getBodyType:quantityType queryResultBlock:^(NSArray *queryResults) {
                if (queryResultBlock) {
                    queryResultBlock(queryResults);
                }
            }];
        }
            break;
        case ZYQQuantityTypeBodyMass:
        {
           quantityType  = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
            [self ZYQ_getBodyType:quantityType queryResultBlock:^(NSArray *queryResults) {
                if (queryResultBlock) {
                    queryResultBlock(queryResults);
                }
            }];
        }
        case ZYQQuantityTypeBloodGlucose:
        {
            quantityType  = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
            [self ZYQ_getBodyType:quantityType queryResultBlock:^(NSArray *queryResults) {
                if (queryResultBlock) {
                    queryResultBlock(queryResults);
                }
            }];
        }
        case ZYQQuantityTypeBloodPressureSystolic:
        {
            quantityType  = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
            [self ZYQ_getBodyType:quantityType queryResultBlock:^(NSArray *queryResults) {
                if (queryResultBlock) {
                    queryResultBlock(queryResults);
                }
            }];
        }
        case ZYQQuantityTypeBloodPressureDiastolic:
        {
            quantityType  = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];
            [self ZYQ_getBodyType:quantityType queryResultBlock:^(NSArray *queryResults) {
                if (queryResultBlock) {
                    queryResultBlock(queryResults);
                }
            }];
        }

            break;
    }
}
//根据不同类型获取不同的数据,返回不同的数据
+ (void)ZYQ_fetchAllHealthStartDate:(NSDate *)startDate
                           endDate:(NSDate *)endDate
                       hComponents:(NSDateComponents *)hComponents
                      quantityType:(ZYQQuantityType)unit
                              type:(HKQuantityType *)quantityType
                  queryResultBlock:(void (^)(NSArray *queryResults))queryResultBlock {
    NSPredicate *predicate              = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    NSUInteger op                       = HKStatisticsOptionCumulativeSum | HKStatisticsOptionNone;
    HKStatisticsCollectionQuery  *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:predicate options:op anchorDate:startDate intervalComponents:hComponents];
    query.initialResultsHandler         = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection * __nullable result, NSError * __nullable error) {
        if (error){
            NSLog(@"统计update出错 %@", error);
            return;
        }else {
            NSMutableArray *array       = [NSMutableArray array];
            for (HKStatistics *statist in result.statistics){
                
                double sum4;
                if (unit == ZYQQuantityTypeStep) {
                   sum4             = [statist.sumQuantity doubleValueForUnit:[HKUnit countUnit]];
                }else if (unit == ZYQQuantityTypeWalking || unit ==ZYQQuantityTypeCycling || unit == ZYQQuantityTypeSwimming) {
                   sum4             = [statist.sumQuantity doubleValueForUnit:[HKUnit meterUnit]];
                }else if (unit == ZYQQuantityTypeActiveEnergyBurned || unit ==ZYQQuantityTypeBasalEnergyBurned) {
                  sum4             = [statist.sumQuantity doubleValueForUnit:[HKUnit kilocalorieUnit]];
                }else  {
                    sum4             = [statist.sumQuantity doubleValueForUnit:[HKUnit millimeterOfMercuryUnit]];
                }
                NSDictionary *dic       = @{@"stepCount":@(sum4),
                                            @"startDate":[NSDate HK_getNewTimeFormat:[NSDate HK_ymd_hmsFormatIs24hour:YES] date:statist.startDate] ,
                                            @"endDate":[NSDate HK_getNewTimeFormat:[NSDate HK_ymd_hmsFormatIs24hour:YES] date: statist.endDate]
                                            };
                [array addObject:dic];
            }
            if (queryResultBlock) {
                queryResultBlock(array);
            }
        };
    };
   [[ZYQHealthManager ZYQ_standardHealthManager].healthStore executeQuery:query];
}

+ (void)ZYQ_getBodyType:(HKSampleType *)sampleType queryResultBlock:(void (^)(NSArray *queryResults))queryResultBlock  {
    NSPredicate *predicate              = [HKQuery predicateForSamplesWithStartDate:nil endDate:nil options:HKQueryOptionStrictStartDate];
    NSSortDescriptor *sortDescriptor    = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:YES];
    HKSampleQuery *sampleQuery          = [[HKSampleQuery alloc] initWithSampleType:sampleType predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[sortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
          NSMutableArray *array       = [NSMutableArray array];
        if(!error && results) {
            for(HKQuantitySample *samples in results) {
                NSDictionary *dic       = @{@"stepCount":samples.quantity,
                                            @"startDate":samples.startDate ,
                                            @"endDate":samples.endDate
                                            };
                [array addObject:dic];
            }
        }
        if (queryResultBlock) {
            queryResultBlock(array);
        }
    }];
    [[ZYQHealthManager ZYQ_standardHealthManager].healthStore executeQuery:sampleQuery];
}
#pragma mark -- 写入数据
+ (void)ZYQ_saveHealthKitDataType:(ZYQQuantityType )type
                       startDate:(NSDate *)startDate
                         endDate:(NSDate *)endDate
                          number:(CGFloat)number
                         success:(void(^)(BOOL isSuccess , NSError *error))block{

    HKUnit *unit;
    HKQuantityType *quantityType;
    if (type == ZYQQuantityTypeStep) {
        quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
        unit = [HKUnit countUnit];
    }
    if (type == ZYQQuantityTypeWalking) {
         quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
         unit = [HKUnit meterUnit];
    }
    if (type == ZYQQuantityTypeCycling) {
         quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling];
         unit = [HKUnit meterUnit];
    }
    if (type == ZYQQuantityTypeSwimming) {
        if (@available(iOS 10.0, *)) {
            quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceSwimming];
        } else {
            // Fallback on earlier versions
        }
        unit = [HKUnit meterUnit];
    }
    if (type == ZYQQuantityTypeHeight) {
        quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
        unit = [HKUnit meterUnit];
    }
    if (type == ZYQQuantityTypeBodyMass) {
         quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
        unit = [HKUnit gramUnit];
    }
    if (type == ZYQQuantityTypeActiveEnergyBurned) {
        quantityType =[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
        unit = [HKUnit kilocalorieUnit];
    }
    if (type == ZYQQuantityTypeBasalEnergyBurned) {
         quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned];
        unit = [HKUnit kilocalorieUnit];
    }
    if (type == ZYQQuantityTypeBloodGlucose) {
        quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
         unit = [HKUnit unitFromString:@"mg/dl"];
    }
    if (type == ZYQQuantityTypeBloodPressureSystolic) {
        quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
        unit = [HKUnit millimeterOfMercuryUnit];
    }
    if (type == ZYQQuantityTypeBloodPressureDiastolic) {
        quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];
        unit = [HKUnit millimeterOfMercuryUnit];
    }
    if (!unit || !quantityType) {
        return ;
    }
    HKQuantity *quantity    = [HKQuantity quantityWithUnit:unit doubleValue:number];
    HKQuantitySample *quantitySample = [HKQuantitySample quantitySampleWithType:quantityType quantity:quantity startDate:startDate endDate:endDate];
    [[ZYQHealthManager ZYQ_standardHealthManager].healthStore saveObject:quantitySample withCompletion:^(BOOL success, NSError * _Nullable error) {
        block(success, error);
    }];
    
}

@end
