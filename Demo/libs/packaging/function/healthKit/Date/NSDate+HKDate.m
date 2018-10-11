//
//  NSDate+HKDate.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/11.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "NSDate+HKDate.h"

@implementation NSDate (HKDate)

+ (NSDateFormatter *)HK_sharedDateFormatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"locale"];
    });
    return dateFormatter;
}

+ (NSCalendar *)HK_sharedCalendar {
    static NSCalendar *calendar;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendar = [NSCalendar currentCalendar];
    });
    return calendar;
}

#pragma mark -- 获取日、月、年、小时、分钟、秒
//天
- (NSUInteger)HK_day {
    return [NSDate HK_day:self];
}
+(NSUInteger)HK_day:(NSDate *)date {
    NSCalendar *calendar = [NSDate HK_sharedCalendar];
   
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    return [dayComponents day];
}

//月
- (NSUInteger)HK_month {
    return [NSDate HK_month:self];
}
+ (NSUInteger)HK_month:(NSDate *)date {
    NSCalendar *calendar = [NSDate HK_sharedCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents =[calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    return [dayComponents month];
}

//年
- (NSUInteger)HK_year {
    return [NSDate HK_year:self];
}
+ (NSUInteger)HK_year:(NSDate *)date {
    NSCalendar *calendar = [NSDate HK_sharedCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];;
#endif
    return [dayComponents year];
}

//时
- (NSUInteger)HK_hour {
    return [NSDate HK_hour:self];
}
+ (NSUInteger)HK_hour:(NSDate *)date {
    NSCalendar *calendar = [NSDate HK_sharedCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];;
#endif
    return [dayComponents hour];
}
//分
- (NSUInteger)HK_minute {
    return [NSDate HK_minute:self];
}
+ (NSUInteger)HK_minute:(NSDate *)date {
    NSCalendar *calendar = [NSDate HK_sharedCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];;
#endif
    return [dayComponents minute];
}
//秒
- (NSUInteger)HK_second {
    return [NSDate HK_second:self];
}
+ (NSUInteger)HK_second:(NSDate *)date {
    NSCalendar *calendar = [NSDate HK_sharedCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];;
#endif
    return [dayComponents second];
}
#pragma mark -- 判断闰月年
- (BOOL)HK_isLeapYear {
    return [NSDate HK_isLeapYear:self];
}
+ (BOOL)HK_isLeapYear:(NSDate *)date {
    NSInteger year = [date HK_year];
    if ( (year % 4 == 0 && year % 100 != 0)||(year % 400 == 0)) {
        return YES;
    }
    return NO;
}
#pragma mark -- 一年中有多少天，距离当前日期几天前

- (NSUInteger)HK_daysAgo {
    return [NSDate HK_daysAgo:self];
}
+ (NSUInteger)HK_daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSDate HK_sharedCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];

}

- (NSUInteger)HK_daysInYear {
    return [NSDate HK_daysInYear:self];
}
+ (NSUInteger)HK_daysInYear:(NSDate *)date {
    return [NSDate HK_isLeapYear:date]?366:365;
}

#pragma mark -- 判断有几周
- (NSUInteger)HK_weekForYear {
    return [NSDate HK_weekForYear:self];
}
+ (NSUInteger)HK_weekForYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date HK_year];//2017
    for (i = 1;[[date HK_dateAfterDay:-7 * i] HK_year] == year; i++) {
    }
    return i;
}
- (NSUInteger)HK_weekForMonth {
    return [NSDate HK_weekFotMonth:self];
}
+ (NSUInteger)HK_weekFotMonth:(NSDate *)date {
    return [[date HK_lastdayOfMonth] HK_weekForYear] -[[date HK_begindayOfMonth] HK_weekForYear] + 1;
}

#pragma mark -- 获取该月的第一天和最后一天日期
- (NSDate *)HK_begindayOfMonth {
    return [NSDate HK_begindayOfMonth:self];
}
+ (NSDate *)HK_begindayOfMonth:(NSDate *)date {
    return [self HK_dateAfterDate:date day:-[date HK_day] +1];
}
- (NSDate *)HK_lastdayOfMonth {
    return [NSDate HK_lastdayOfMonth:self];
}
+ (NSDate *)HK_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self HK_begindayOfMonth:date];
    return [[NSDate HK_dateAfterDate:lastDate month:1] HK_dateAfterDay:-1];
}

#pragma mark -- 多长时间后的日期
//天
- (NSDate *)HK_dateAfterDay:(NSInteger)day {
    return [NSDate HK_dateAfterDate:self
                                day:day];
}
+ (NSDate *)HK_dateAfterDate:(NSDate *)date
                         day:(NSInteger)day {
    if (date == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    NSDateComponents *compomentsAdd = [[NSDateComponents alloc] init];
    [compomentsAdd setDay:day];
    NSDate *afterDate = [calendar dateByAddingComponents:compomentsAdd
                                                  toDate:date
                                                 options:0];
    return afterDate;
}
//月
- (NSDate *)HK_dateAfterMonth:(NSInteger)month {
    
    return [NSDate HK_dateAfterDate:self month:month];
}

+ (NSDate *)HK_dateAfterDate:(NSDate *)date month:(NSInteger)month {
    if (date == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *calendar = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *calendar = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    NSDateComponents *compomentsAdd = [[NSDateComponents alloc] init];
    [compomentsAdd setMonth:month];
    NSDate *afterDate = [calendar dateByAddingComponents:compomentsAdd
                                                  toDate:date
                                                 options:0];
    return afterDate;
}
//年
- (NSDate *)HK_dateAfterYear:(NSInteger)year {
    return [NSDate HK_dateAfterDate:self year:year];
}
+ (NSDate *)HK_dateAfterDate:(NSDate *)date year:(NSInteger)year {
    if (date == nil) {
        return nil;
    }
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    NSDateComponents *compomentsAdd = [[NSDateComponents alloc] init];
    [compomentsAdd setYear:year];
    NSDate *afterDate = [calendar dateByAddingComponents:compomentsAdd
                                                  toDate:date
                                                 options:0];
    return afterDate;
}
//时
- (NSDate *)HK_dateAfterHour:(NSInteger)hour {
    
    return [NSDate HK_dateAfterDate:self hour:hour];
}
+ (NSDate *)HK_dateAfterDate:(NSDate *)date hour:(NSInteger)hour {
    if (date == nil) {
        return nil;
    }
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    //NSDayCalendarUnit
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    NSDateComponents *compomentsAdd = [[NSDateComponents alloc] init];
    [compomentsAdd setHour:hour];
    
    NSDate *afterDate = [calendar dateByAddingComponents:compomentsAdd
                                                  toDate:date
                                                 options:0];
    return afterDate;
}
#pragma mark -- 时间格式的字符串
+ (NSString *)HK_getNewTimeFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSDate *date = [NSDate date];
    return [formatter stringFromDate:date];
}
- (NSString *)HK_ymdFormat {
    return [NSDate HK_ymdFormat];
}
- (NSString *)HK_hmsFormatIs24hour:(BOOL)is24hour {
    return [NSDate HK_hmsFormatIs24hour:is24hour];
}
- (NSString *)HK_ymd_hmsFormatIs24hour:(BOOL)is24hour {
    return [NSDate HK_ymd_hmsFormatIs24hour:is24hour];
}
+ (NSString *)HK_ymdFormat {
   return @"yyy-MM-dd";
}
+ (NSString *)HK_hmsFormatIs24hour:(BOOL)is24hour {
    if (is24hour) {
      return @"HH:mm:ss";
    }
  return @"hh:mm:ss";
}
+ (NSString *)HK_ymd_hmsFormatIs24hour:(BOOL)is24hour {
    if (is24hour) {
        return @"yyyy-MM-dd HH:mm:ss";
    }
   return @"yyyy-MM-dd hh:mm:ss";
}
+ (NSString *)HK_getTimeStamps {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMddHHmmss";
    return [dateFormatter stringFromDate:date];
}
+ (NSString *)HK_getNewTimeFormat:(NSString *)format
                             date:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter stringFromDate:date];
}


#pragma mark -- 判断时间早晚
+ (int)HK_compareDate:(NSDate *)oneday
   withAnotherDate:(NSDate *)anotherDay
withIsIncludeSecond:(BOOL)isIncludeSecond {
   
    NSDateFormatter *dateFormatter = [NSDate HK_sharedDateFormatter];
    NSString *oneDayStr;
    NSString *anotherDayStr;
    if (isIncludeSecond) {
        oneDayStr       = [NSDate HK_getNewTimeFormat:[NSDate HK_ymd_hmsFormatIs24hour:YES] date:oneday];
        anotherDayStr   = [NSDate HK_getNewTimeFormat:[NSDate HK_ymd_hmsFormatIs24hour:YES] date:anotherDay];
        [dateFormatter setDateFormat:[NSDate HK_ymd_hmsFormatIs24hour:YES]];
    }else {
        oneDayStr       = [NSDate HK_getNewTimeFormat:@"yyyy-MM-dd hh:mm" date:oneday];
        anotherDayStr   = [NSDate HK_getNewTimeFormat:@"yyyy-MM-dd hh:mm" date:anotherDay];
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    }
  
    NSDate *Adate       = [dateFormatter dateFromString:oneDayStr];
    NSDate *Bdate       = [dateFormatter dateFromString:anotherDayStr];
    NSAssert(Adate != nil || Bdate != nil, @"有的时间传入为空,转换不正确");
    NSComparisonResult result = [Adate compare:Bdate];
    if (result == NSOrderedDescending) {
        return  1;
    }else if (result == NSOrderedAscending) {
        return  -1;
    }else {
        return 0;
    }
}

- (BOOL)HK_isSameDay:(NSDate *)anotherDate {
    return [NSDate HK_isSameDay:self another:anotherDate];
}
+ (BOOL)HK_isSameDay:(NSDate *)oneDate
             another:(NSDate *)anotherDate {
    NSCalendar *calender                = [NSDate HK_sharedCalendar];
    NSDateComponents *oneComponents     = [calender components:NSCalendarUnitYear
                                                             | NSCalendarUnitMonth
                                                             | NSCalendarUnitDay
                                                  fromDate:oneDate];
    NSDateComponents *anotherComponents = [calender components:NSCalendarUnitYear
                                                             | NSCalendarUnitMonth
                                                             | NSCalendarUnitDay
                                                      fromDate:anotherDate];
    return (oneComponents.year == anotherComponents.year &&
            oneComponents.month == anotherComponents.month&&
            oneComponents.day == anotherComponents.day);
}

- (BOOL)HK_isToday {
    return [NSDate HK_isTodayWithDate:self];
}
+ (BOOL)HK_isTodayWithDate:(NSDate *)today {
    return [NSDate HK_isSameDay:[NSDate date] another:today];
}
#pragma mark -- 返回时间时间格式字符串
+ (NSString *)HK_timeWithDate:(NSDate *)date {
    NSString *currentDateStr            = [NSDate HK_getNewTimeFormat:@"MM-dd"];
    NSDate *tomorrowDate                = [NSDate HK_dateAfterDate:[NSDate date] day:1];
    NSDateFormatter *dateFormatter      = [NSDate HK_sharedDateFormatter];
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString *tomorrowDateStr           = [dateFormatter stringFromDate:tomorrowDate];
    NSString *nowStr                    = [dateFormatter stringFromDate:date];
    if ([currentDateStr isEqualToString:nowStr]) {
        return @"今天";
    }else if ([tomorrowDateStr isEqualToString:nowStr]) {
        return @"明天";
    }else {
        return nowStr;
    }
}
+ (NSString *)HK_dateStringWithDelay:(NSTimeInterval)delay {
    [self HK_sharedDateFormatter].dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:delay*60*60];
    
    return [[self HK_sharedDateFormatter] stringFromDate:date];
}
- (NSString *)HK_dateDescription {
    NSUInteger units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponents    = [[NSDate HK_sharedCalendar] components:units fromDate:self];
    NSDateComponents *thisComponents    = [[NSDate HK_sharedCalendar] components:units fromDate:[NSDate date]];
    if (dateComponents.year == thisComponents.year && dateComponents.month == thisComponents.month && dateComponents.day == thisComponents.day) {
        NSInteger  delay = (NSInteger)[[NSDate date] timeIntervalSinceDate:self];
        
        if (delay < 60) {
            return @"刚刚";
        }else if (delay < 3600) {
            return [NSString stringWithFormat:@"%ld 分钟前" , delay / 60];
        }
        return [NSString stringWithFormat:@"%ld 小时前" , delay / 3600];
    }else if (dateComponents.year == thisComponents.year && dateComponents.month == thisComponents.month && dateComponents.day != thisComponents.day) {
        if (thisComponents.day > dateComponents.day) {
            return [NSString stringWithFormat:@"%ld 天前" , thisComponents.day - dateComponents.day];
        }
    }else if (dateComponents.year == thisComponents.year && dateComponents.month != thisComponents.month ) {
        if (thisComponents.month > dateComponents.month) {
            return [NSString stringWithFormat:@"%ld 月前" , thisComponents.month - dateComponents.month];
        }
    }else if (dateComponents.year == thisComponents.year) {
        if (thisComponents.year > dateComponents.year) {
            return [NSString stringWithFormat:@"%ld 年前" , thisComponents.year - dateComponents.year];
        }
    }
    NSString *format = @"MM-dd HH:mm";
    if (dateComponents.year != thisComponents.year) {
        format = [@"yyyy-" stringByAppendingString:format];
    }
    [NSDate HK_sharedDateFormatter].dateFormat = format;
    return [[NSDate HK_sharedDateFormatter] stringFromDate:self];
}
#pragma mark -- 星期相关
- (NSUInteger)HK_weekDay {
    return [NSDate HK_weekDay:self];
}
+ (NSUInteger)HK_weekDay:(NSDate *)date {
    NSCalendar *calendar = [NSDate HK_sharedCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay
                                                         |NSCalendarUnitMonth
                                                         | NSCalendarUnitYear
                                                         | NSCalendarUnitWeekday)
                                               fromDate:date];
    return [components weekday];
}
- (NSString *)HK_dayFromWeekdayIsEnglish:(BOOL)isEnglish {
    return [NSDate HK_dayFromWeekday:self isEnglish:isEnglish];
}
+ (NSString *)HK_dayFromWeekday:(NSDate *)date isEnglish:(BOOL)isEnglish {
    switch ([date HK_weekDay]) {
        case 1:
            
            return isEnglish?@"Sunday":@"星期天";
            break;
        case 2:
            return isEnglish?@"Monday":@"星期一";
            break;
        case 3:
            return isEnglish?@"Tuerday":@"星期二";
            break;
        case 4:
            return isEnglish?@"Wednesday":@"星期三";
            break;
        case 5:
            return isEnglish?@"Thursday":@"星期四";
            break;
        case 6:
            return isEnglish?@"Friday":@"星期五";
            break;
        case 7:
            return isEnglish?@"Saturday":@"星期六";
            break;
        default:
            break;
    }
    return @"";
}
#pragma mark -- 其他
+ (NSDate *)HK_dateWithLocalEN_USString:(NSString *)dateStr format:(NSString *)format {
    NSDateFormatter *outPuHKormatter = [NSDate HK_sharedDateFormatter];
    outPuHKormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [outPuHKormatter setDateFormat:format];
    return [outPuHKormatter dateFromString:dateStr];
}
+ (NSDate *)HK_dateWithString:(NSString *)dateStr format:(NSString *)format {
    NSDateFormatter *outPuHKormatter = [NSDate HK_sharedDateFormatter];
    [outPuHKormatter setDateFormat:format];
    return [outPuHKormatter dateFromString:dateStr];
}
#pragma mark -- 获得当前本地时间
+ (NSDate *)HK_getCurrentDate{
    NSDate * date = [NSDate date];
    return [self HK_getLocationDate:date];
}
+ (NSDate *)HK_getLocationDate:(NSDate *)date {
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    return  [date dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
}
@end
