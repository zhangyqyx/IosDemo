//
//  ZYQDateViewController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/11.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQDateViewController.h"
#import "NSDate+ZYQDate.h"

@interface ZYQDateViewController ()
@property (weak, nonatomic) IBOutlet UITextView *showView;

/**时间 */
@property (nonatomic , strong)NSDate *date;

@end

@implementation ZYQDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showView.editable = NO;
    self.navigationItem.title = @"NSDate";
   
}
//获取指定时间年、月、日、时、分、秒
- (IBAction)getAppointedDetailTime:(id)sender {
     self.date = [NSDate date];
    NSUInteger second   = [self.date ZYQ_second]; //  [NSDate ZYQ_second:self.date];
    NSUInteger minute   = [self.date ZYQ_minute];//  [NSDate ZYQ_minute:self.date];
    NSUInteger hour     = [self.date ZYQ_hour];//  [NSDate ZYQ_hour:self.date];
    NSUInteger day      = [self.date ZYQ_day];//  [NSDate ZYQ_day:self.date];
    NSUInteger mounth   = [self.date ZYQ_month];//  [NSDate ZYQ_month:self.date];
    NSUInteger year     = [self.date ZYQ_year];//  [NSDate ZYQ_year:self.date];
    self.showView.text = [NSString stringWithFormat:@"当前时间：\n%lu年\n%lu月\n%lu日\n%lu时\n%lu分\n%lu秒\n" , year,mounth,day,hour,minute,second];
    
}
//获取当前时间
- (IBAction)getCurrenttime:(id)sender {
    NSDate *currentDate = [NSDate ZYQ_getCurrentDate];// [NSDate ZYQ_getLocationDate:[NSDate date]];
    self.showView.text = [NSString stringWithFormat:@"当前时间:%@",currentDate];
    
    
    
}
//获取时间格式字符串
- (IBAction)getdateFormatStr:(id)sender {
    NSString * ymdStr           = [NSDate ZYQ_ymdFormat];
    NSString * hmsStr           = [NSDate ZYQ_hmsFormatIs24hour:YES];
    NSString * ymdhmsStr        = [NSDate ZYQ_ymd_hmsFormatIs24hour:YES];
    self.showView.text          = [NSString stringWithFormat:@"年月日格式:%@\n时分秒格式:%@\n年月日时分秒格式:%@",ymdStr , hmsStr , ymdhmsStr];
    
}
//获取对应格式的时间字符串
- (IBAction)getDateWithStr:(id)sender {
   
    NSString * ymdStr           = [NSDate ZYQ_ymdFormat];
    NSString * hmsStr           = [NSDate ZYQ_hmsFormatIs24hour:YES];
    NSString * ymdhmsStr        = [NSDate ZYQ_ymd_hmsFormatIs24hour:YES];
    NSString * ymdDateStr       = [NSDate ZYQ_getNewTimeFormat:ymdStr date:[NSDate date]];
    NSString * hmsDateStr       = [NSDate ZYQ_getNewTimeFormat:hmsStr date:[NSDate date]];
    NSString * ymdhmsDateStr    = [NSDate ZYQ_getNewTimeFormat:ymdhmsStr date:[NSDate date]];
    self.showView.text          = [NSString stringWithFormat:@"时间-年月日:%@\n时间-时分秒格式:%@\n时间-年月日时分秒格式:%@",ymdDateStr , hmsDateStr , ymdhmsDateStr];
    
    
}
//判断是否为闰月年
- (IBAction)isLeap:(id)sender {
    if ([NSDate ZYQ_isLeapYear:[NSDate date]]) {
        self.showView.text = @"今年是闰年";
    }else {
        self.showView.text = @"今年是平年";
    }
}
//获取距离当前时间几天
- (IBAction)getDateAge:(id)sender {
    NSDate *yesterdayDate   = [NSDate ZYQ_dateAfterDate:[NSDate date] day:-1];
    NSUInteger agoDate      = [NSDate ZYQ_daysAgo:yesterdayDate];
    self.showView.text      = [NSString stringWithFormat:@"距离今天有%lu天",agoDate];
}
//一年中有多少天
- (IBAction)daysInYear:(id)sender {
    NSUInteger days     = [NSDate ZYQ_daysInYear:[NSDate date]];
    self.showView.text  = [NSString stringWithFormat:@"今年有：%lu天", days];
}
//判断日期是一年中的第几周
- (IBAction)weekForYear:(id)sender {
    NSDate *afterDate   = [NSDate ZYQ_dateAfterDate:[NSDate date] day:-55];
    NSUInteger week     = [NSDate ZYQ_weekForYear:afterDate];
    self.showView.text  = [NSString stringWithFormat:@"这周是今年的第%lu周", week];
    NSUInteger weeks    = [NSDate ZYQ_weekFotMonth:[NSDate date]];
    self.showView.text  = [self.showView.text stringByAppendingString:[NSString stringWithFormat:@"\n这个月有%lu周",weeks]];
}
//获取一月中的第一天和最后一天日期
- (IBAction)dayOfMonth:(id)sender {
    NSDate *beginDate  = [NSDate ZYQ_begindayOfMonth:[NSDate date]];
    NSDate *endDate    = [NSDate ZYQ_lastdayOfMonth:[NSDate date]];
   self.showView.text  = [NSString stringWithFormat:@"这个月的第一天:%@\n这个月的最后一天:%@", beginDate,endDate];
}
//获取几天后的时间
- (IBAction)afterDay:(id)sender {
    NSDate *afterDate = [NSDate ZYQ_dateAfterDate:[NSDate date] day:5];
    self.showView.text  = [NSString stringWithFormat:@"5天后的时间是:%@", afterDate];
}
//获取几个月后的时间
- (IBAction)afterMonth:(id)sender {
    NSDate *afterDate = [NSDate ZYQ_dateAfterDate:[NSDate date] month:5];
    self.showView.text  = [NSString stringWithFormat:@"5个月后的时间是:%@", afterDate];
}
//获取几年后的时间
- (IBAction)afterYear:(id)sender {
    NSDate *afterDate = [NSDate ZYQ_dateAfterDate:[NSDate date] year:5];
    self.showView.text  = [NSString stringWithFormat:@"5年后的时间是:%@", afterDate];
}
//获取几个小时后的时间
- (IBAction)afterHour:(id)sender {
    NSDate *afterDate = [NSDate ZYQ_dateAfterDate:[NSDate date] hour:5];
    self.showView.text  = [NSString stringWithFormat:@"5个小时后的时间是:%@", afterDate];
}
//获取当前时间戳
- (IBAction)getTimeStamps:(id)sender {
    NSString *stamps = [NSDate ZYQ_getTimeStamps];
    self.showView.text  = [NSString stringWithFormat:@"当前时间戳是:%@", stamps];
}
//比较时间的先后
- (IBAction)compareDate:(id)sender {
    NSDate *anotherDate = [NSDate ZYQ_dateAfterDate:[NSDate date] hour:1];
    NSDate *oneDate = [NSDate date];
    int result =  [NSDate ZYQ_compareDate:oneDate withAnotherDate:anotherDate withIsIncludeSecond:NO];
    if (result == 1) {
      self.showView.text  = [NSString stringWithFormat:@"时间%@晚于时间%@", anotherDate , oneDate];
    }else if (result == -1) {
         self.showView.text  = [NSString stringWithFormat:@"时间%@早于时间%@", anotherDate , oneDate];
    }else {
       self.showView.text  = [NSString stringWithFormat:@"时间%@等于时间%@", anotherDate , oneDate];
    }
}
//判断是否是同一个日期--年月日
- (IBAction)sameTimeDate:(id)sender {
    NSDate *anotherDate = [NSDate ZYQ_dateAfterDate:[NSDate date] hour:1];
    NSDate *oneDate = [NSDate date];
   BOOL isSameDate =  [NSDate ZYQ_isSameDay:oneDate another:anotherDate];
    if (isSameDate) {
        self.showView.text  = [NSString stringWithFormat:@"时间%@和时间%@是同一天", anotherDate , oneDate];
    }else {
        self.showView.text  = [NSString stringWithFormat:@"时间%@和时间%@不是同一天", anotherDate , oneDate];
    }
}
//判断是否是今天
- (IBAction)isToday:(id)sender {
    NSDate *anotherDate = [NSDate ZYQ_dateAfterDate:[NSDate date] hour:1];
    BOOL isToday =  [anotherDate ZYQ_isToday];
    if (isToday) {
        self.showView.text  = [NSString stringWithFormat:@"时间%@是今天", anotherDate];
    }else {
      self.showView.text  = [NSString stringWithFormat:@"时间%@不是今天", anotherDate];
    }
}
//指定时间差值的时间
- (IBAction)delayDate:(id)sender {
    NSString *delayDate = [NSDate ZYQ_dateStringWithDelay:1.05];
    self.showView.text  = [NSString stringWithFormat:@"1000小时后的时间%@", delayDate];
}
//判断是星期几
- (IBAction)week:(id)sender {
    NSString *weekDay = [NSDate ZYQ_dayFromWeekday:[NSDate date] isEnglish:NO];
    self.showView.text = [NSString stringWithFormat:@"今天是：%@",weekDay];
}
// 获取日期格式字符串
///
/// 具体格式如下：
///     - 刚刚(一分钟内)
///     - X分钟前(一小时内)
///     - X小时前(当天)
///     - X天前
///     - X月前
///     - X年前
///     - MM-dd HH:mm(一年内)
///     - yyyy-MM-dd HH:mm(更早期)
- (IBAction)dateStr:(id)sender {
    NSDate *date = [NSDate ZYQ_dateAfterDate:[NSDate date] day:-6];
    self.showView.text = [NSString stringWithFormat:@"%@", date.ZYQ_dateDescription];
    
}
//其他
- (IBAction)other:(id)sender {
    self.showView.text = @"其他的操作都在NSDate+ZYQDate文件中找到，可以自己去尝试一下";
}





@end
