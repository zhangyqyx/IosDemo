//
//  NSDate+ZYQDate.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/11.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "NSDate+ZYQDate.h"

@implementation NSDate (ZYQDate)

+ (NSDateFormatter *)ZYQ_sharedDateFormatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"locale"];
    });
    return dateFormatter;
}

+ (NSCalendar *)ZYQ_sharedCalendar {
    static NSCalendar *calendar;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendar = [NSCalendar currentCalendar];
    });
    return calendar;
}

#pragma mark -- 获取日、月、年、小时、分钟、秒
//天
- (NSUInteger)ZYQ_day {
    return [NSDate ZYQ_day:self];
}
+(NSUInteger)ZYQ_day:(NSDate *)date {
    NSCalendar *calendar = [NSDate ZYQ_sharedCalendar];
   
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    return [dayComponents day];
}

//月
- (NSUInteger)ZYQ_month {
    return [NSDate ZYQ_month:self];
}
+ (NSUInteger)ZYQ_month:(NSDate *)date {
    NSCalendar *calendar = [NSDate ZYQ_sharedCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents =[calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    return [dayComponents month];
}

//年
- (NSUInteger)ZYQ_year {
    return [NSDate ZYQ_year:self];
}
+ (NSUInteger)ZYQ_year:(NSDate *)date {
    NSCalendar *calendar = [NSDate ZYQ_sharedCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];;
#endif
    return [dayComponents year];
}

//时
- (NSUInteger)ZYQ_hour {
    return [NSDate ZYQ_hour:self];
}
+ (NSUInteger)ZYQ_hour:(NSDate *)date {
    NSCalendar *calendar = [NSDate ZYQ_sharedCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];;
#endif
    return [dayComponents hour];
}
//分
- (NSUInteger)ZYQ_minute {
    return [NSDate ZYQ_minute:self];
}
+ (NSUInteger)ZYQ_minute:(NSDate *)date {
    NSCalendar *calendar = [NSDate ZYQ_sharedCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];;
#endif
    return [dayComponents minute];
}
//秒
- (NSUInteger)ZYQ_second {
    return [NSDate ZYQ_second:self];
}
+ (NSUInteger)ZYQ_second:(NSDate *)date {
    NSCalendar *calendar = [NSDate ZYQ_sharedCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];;
#endif
    return [dayComponents second];
}
#pragma mark -- 判断闰月年
- (BOOL)ZYQ_isLeapYear {
    return [NSDate ZYQ_isLeapYear:self];
}
+ (BOOL)ZYQ_isLeapYear:(NSDate *)date {
    NSInteger year = [date ZYQ_year];
    if ( (year % 4 == 0 && year % 100 != 0)||(year % 400 == 0)) {
        return YES;
    }
    return NO;
}
#pragma mark -- 一年中有多少天，距离当前日期几天前

- (NSUInteger)ZYQ_daysAgo {
    return [NSDate ZYQ_daysAgo:self];
}
+ (NSUInteger)ZYQ_daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSDate ZYQ_sharedCalendar];
    
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

- (NSUInteger)ZYQ_daysInYear {
    return [NSDate ZYQ_daysInYear:self];
}
+ (NSUInteger)ZYQ_daysInYear:(NSDate *)date {
    return [NSDate ZYQ_isLeapYear:date]?366:365;
}

#pragma mark -- 判断有几周
- (NSUInteger)ZYQ_weekForYear {
    return [NSDate ZYQ_weekForYear:self];
}
+ (NSUInteger)ZYQ_weekForYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date ZYQ_year];//2017
    for (i = 1;[[date ZYQ_dateAfterDay:-7 * i] ZYQ_year] == year; i++) {
    }
    return i-1;
}
- (NSUInteger)ZYQ_weekForMonth {
    return [NSDate ZYQ_weekFotMonth:self];
}
+ (NSUInteger)ZYQ_weekFotMonth:(NSDate *)date {
    return [[date ZYQ_lastdayOfMonth] ZYQ_weekForYear] -[[date ZYQ_begindayOfMonth] ZYQ_weekForYear] + 1;
}

#pragma mark -- 获取该月的第一天和最后一天日期
- (NSDate *)ZYQ_begindayOfMonth {
    return [NSDate ZYQ_begindayOfMonth:self];
}
+ (NSDate *)ZYQ_begindayOfMonth:(NSDate *)date {
    return [self ZYQ_dateAfterDate:date day:-[date ZYQ_day] +1];
}
- (NSDate *)ZYQ_lastdayOfMonth {
    return [NSDate ZYQ_lastdayOfMonth:self];
}
+ (NSDate *)ZYQ_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self ZYQ_begindayOfMonth:date];
    return [[NSDate ZYQ_dateAfterDate:lastDate month:1] ZYQ_dateAfterDay:-1];
}

#pragma mark -- 多长时间后的日期
//天
- (NSDate *)ZYQ_dateAfterDay:(NSInteger)day {
    return [NSDate ZYQ_dateAfterDate:self
                                day:day];
}
+ (NSDate *)ZYQ_dateAfterDate:(NSDate *)date
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
- (NSDate *)ZYQ_dateAfterMonth:(NSInteger)month {
    
    return [NSDate ZYQ_dateAfterDate:self month:month];
}

+ (NSDate *)ZYQ_dateAfterDate:(NSDate *)date month:(NSInteger)month {
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
- (NSDate *)ZYQ_dateAfterYear:(NSInteger)year {
    return [NSDate ZYQ_dateAfterDate:self year:year];
}
+ (NSDate *)ZYQ_dateAfterDate:(NSDate *)date year:(NSInteger)year {
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
- (NSDate *)ZYQ_dateAfterHour:(NSInteger)hour {
    
    return [NSDate ZYQ_dateAfterDate:self hour:hour];
}
+ (NSDate *)ZYQ_dateAfterDate:(NSDate *)date hour:(NSInteger)hour {
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
+ (NSString *)ZYQ_getNewTimeFormat:(NSString *)format {
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    formatter.dateFormat        = format;
    NSDate *date                = [NSDate date];
    return [formatter stringFromDate:date];
}
- (NSString *)ZYQ_ymdFormat {
    return [NSDate ZYQ_ymdFormat];
}
- (NSString *)ZYQ_hmsFormatIs24hour:(BOOL)is24hour {
    return [NSDate ZYQ_hmsFormatIs24hour:is24hour];
}
- (NSString *)ZYQ_ymd_hmsFormatIs24hour:(BOOL)is24hour {
    return [NSDate ZYQ_ymd_hmsFormatIs24hour:is24hour];
}
+ (NSString *)ZYQ_ymdFormat {
   return @"yyy-MM-dd";
}
+ (NSString *)ZYQ_hmsFormatIs24hour:(BOOL)is24hour {
    if (is24hour) {
      return @"HH:mm:ss";
    }
  return @"hh:mm:ss";
}
+ (NSString *)ZYQ_ymd_hmsFormatIs24hour:(BOOL)is24hour {
    if (is24hour) {
        return @"yyyy-MM-dd HH:mm:ss";
    }
   return @"yyyy-MM-dd hh:mm:ss";
}
+ (NSString *)ZYQ_getTimeStamps {
    NSDate *date                    = [NSDate date];
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat        = @"yyyyMMddHHmmss";
    return [dateFormatter stringFromDate:date];
}
+ (NSString *)ZYQ_getNewTimeFormat:(NSString *)format
                             date:(NSDate *)date{
    NSDateFormatter *formatter      = [[NSDateFormatter alloc] init];
    formatter.dateFormat            = format;
    return [formatter stringFromDate:date];
}


#pragma mark -- 判断时间早晚
+ (int)ZYQ_compareDate:(NSDate *)oneday
   withAnotherDate:(NSDate *)anotherDay
withIsIncludeSecond:(BOOL)isIncludeSecond {
   
    NSDateFormatter *dateFormatter = [NSDate ZYQ_sharedDateFormatter];
    NSString *oneDayStr;
    NSString *anotherDayStr;
    if (isIncludeSecond) {
        oneDayStr       = [NSDate ZYQ_getNewTimeFormat:[NSDate ZYQ_ymd_hmsFormatIs24hour:YES] date:oneday];
        anotherDayStr   = [NSDate ZYQ_getNewTimeFormat:[NSDate ZYQ_ymd_hmsFormatIs24hour:YES] date:anotherDay];
        [dateFormatter setDateFormat:[NSDate ZYQ_ymd_hmsFormatIs24hour:YES]];
    }else {
        oneDayStr       = [NSDate ZYQ_getNewTimeFormat:@"yyyy-MM-dd HH:mm" date:oneday];
        anotherDayStr   = [NSDate ZYQ_getNewTimeFormat:@"yyyy-MM-dd HH:mm" date:anotherDay];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
  
    NSDate *Adate       = [dateFormatter dateFromString:oneDayStr];
    NSDate *Bdate       = [dateFormatter dateFromString:anotherDayStr];
    NSAssert(Adate != nil || Bdate != nil, @"有的时间传入为空,转换不正确");
    NSComparisonResult result = [Bdate compare:Adate];
    if (result == NSOrderedDescending) {
        return  1;
    }else if (result == NSOrderedAscending) {
        return  -1;
    }else {
        return 0;
    }
}

- (BOOL)ZYQ_isSameDay:(NSDate *)anotherDate {
    return [NSDate ZYQ_isSameDay:self another:anotherDate];
}
+ (BOOL)ZYQ_isSameDay:(NSDate *)oneDate
             another:(NSDate *)anotherDate {
    NSCalendar *calender                = [NSDate ZYQ_sharedCalendar];
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

- (BOOL)ZYQ_isToday {
    return [NSDate ZYQ_isTodayWithDate:self];
}
+ (BOOL)ZYQ_isTodayWithDate:(NSDate *)today {
    return [NSDate ZYQ_isSameDay:[NSDate date] another:today];
}
#pragma mark -- 返回时间时间格式字符串
+ (NSString *)ZYQ_timeWithDate:(NSDate *)date {
    NSString *currentDateStr            = [NSDate ZYQ_getNewTimeFormat:@"MM-dd"];
    NSDate *tomorrowDate                = [NSDate ZYQ_dateAfterDate:[NSDate date] day:1];
    NSDateFormatter *dateFormatter      = [NSDate ZYQ_sharedDateFormatter];
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
+ (NSString *)ZYQ_dateStringWithDelay:(NSTimeInterval)delay {
    [self ZYQ_sharedDateFormatter].dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:delay*60*60];
    
    return [[self ZYQ_sharedDateFormatter] stringFromDate:date];
}
- (NSString *)ZYQ_dateDescription {
    NSUInteger units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponents    = [[NSDate ZYQ_sharedCalendar] components:units fromDate:self];
    NSDateComponents *thisComponents    = [[NSDate ZYQ_sharedCalendar] components:units fromDate:[NSDate date]];
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
    [NSDate ZYQ_sharedDateFormatter].dateFormat = format;
    return [[NSDate ZYQ_sharedDateFormatter] stringFromDate:self];
}
#pragma mark -- 星期相关
- (NSUInteger)ZYQ_weekDay {
    return [NSDate ZYQ_weekDay:self];
}
+ (NSUInteger)ZYQ_weekDay:(NSDate *)date {
    NSCalendar *calendar = [NSDate ZYQ_sharedCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay
                                                         |NSCalendarUnitMonth
                                                         | NSCalendarUnitYear
                                                         | NSCalendarUnitWeekday)
                                               fromDate:date];
    return [components weekday];
}
- (NSString *)ZYQ_dayFromWeekdayIsEnglish:(BOOL)isEnglish {
    return [NSDate ZYQ_dayFromWeekday:self isEnglish:isEnglish];
}
+ (NSString *)ZYQ_dayFromWeekday:(NSDate *)date isEnglish:(BOOL)isEnglish {
    switch ([date ZYQ_weekDay]) {
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
+ (NSDate *)ZYQ_dateWithLocalEN_USString:(NSString *)dateStr format:(NSString *)format {
    NSDateFormatter *outPuZYQormatter = [NSDate ZYQ_sharedDateFormatter];
    outPuZYQormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [outPuZYQormatter setDateFormat:format];
    return [outPuZYQormatter dateFromString:dateStr];
}
+ (NSDate *)ZYQ_dateWithString:(NSString *)dateStr format:(NSString *)format {
    NSDateFormatter *outPuZYQormatter = [NSDate ZYQ_sharedDateFormatter];
    [outPuZYQormatter setLocale:[NSLocale currentLocale]];
    [outPuZYQormatter setDateFormat:format];
    return [outPuZYQormatter dateFromString:dateStr];
}
#pragma mark -- 获得当前本地时间
+ (NSDate *)ZYQ_getCurrentDate{
    NSDate * date = [NSDate date];
    return [self ZYQ_getLocationDate:date];
}
+ (NSDate *)ZYQ_getLocationDate:(NSDate *)date {
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    return  [date dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
}
@end
