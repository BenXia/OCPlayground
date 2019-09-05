//
//  NSDate+QQCalendar.m
//  QQing
//
//  Created by Ben on 5/15/14.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "NSDate+QQCalendar.h"
#import "NSDateFormatter+Category.h"
#import "TimeService.h"

#define DATE_COMPONENTS (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | kCFCalendarUnitWeek |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation NSDate (QQCalendar)

+ (BOOL)isLeapYear:(NSInteger)year {
    NSAssert(!(year < 1), @"invalid year number");
    
    BOOL leap = FALSE;
    if ((0 == (year % 400))) {
        leap = TRUE;
    }
    else if((0 == (year%4)) && (0 != (year % 100))) {
        leap = TRUE;
    }
    return leap;
}

+ (NSInteger)numberOfDaysInMonth:(NSInteger)month {
    return [NSDate numberOfDaysInMonth:month year:[NSDate currentYear]];
}

+ (NSInteger)currentYear {
    unsigned unitFlags = NSCalendarUnitYear;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:[NSDate date]];
    NSInteger year = comps.year;
    return year;
}

+ (NSInteger)currentMonth {
    unsigned unitFlags = NSCalendarUnitMonth;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:[NSDate date]];
    NSInteger month = comps.month;
    return month;
}

+ (NSInteger)currentDay {
    unsigned unitFlags = NSCalendarUnitDay;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:[NSDate date]];
    NSInteger day = comps.day;
    return day;
}

+ (NSInteger)currentHours {
    unsigned unitFlags = NSCalendarUnitHour;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:[NSDate date]];
    NSInteger hour = comps.hour;
    return hour;
}

+ (NSInteger)currentMinute {
    unsigned unitFlags = NSCalendarUnitMinute;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:[NSDate date]];
    NSInteger minute = comps.minute;
    return minute;
}

+ (NSInteger)currentWeekDay {
    unsigned unitFlags = NSCalendarUnitWeekday;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:[NSDate date]];
    NSInteger weekday = comps.weekday;
    return weekday - 1;  // 原本是1～7
}

+ (NSInteger)monthWithDate:(NSDate*)date {
    unsigned unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];
    NSInteger month = comps.month;
    return month;
}

+ (NSInteger)dayWithDate:(NSDate*)date {
    unsigned unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];
    NSInteger day = comps.day;
    return day;
}

+ (NSInteger)hourWithDate:(NSDate *)date {
    unsigned unitFlags = NSCalendarUnitHour;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];
    NSInteger hour = comps.hour;
    return hour;
}

+ (NSInteger)numberOfDaysInMonth:(NSInteger)month year:(NSInteger) year {
    NSAssert(!(month < 1||month > 12), @"invalid month number");
    NSAssert(!(year < 1), @"invalid year number");
    month = month - 1;
    static int daysOfMonth[12] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    NSInteger days = daysOfMonth[month];
    /*
     * feb
     */
    if (month == 1) {
        if ([NSDate isLeapYear:year]) {
            days = 29;
        }
        else {
            days = 28;
        }
    }
    return days;
}

+ (NSInteger)numberOfDayInYear:(NSInteger)year {
    NSAssert(!(year < 1), @"invalid year number");
    
    static int daysOfYear = 31 + 29 + 31 + 30 + 31 + 30 + 31 + 31 + 30 + 31 + 30 + 31;

    if ([NSDate isLeapYear:year]) {
        return daysOfYear;
    } else {
        return (daysOfYear - 1);
    }
}

- (NSInteger)currentDayIndexInYear {
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    NSDateComponents *components = [gregorian components:(NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.timeZone = [NSTimeZone defaultTimeZone];
    
    static int daysOfMonth[12] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    
    int dayIndex = 0;
    for (int i = 0; i < (components.month - 1); i++) {
        if ((i == 1) && ![NSDate isLeapYear:components.year]) {
            dayIndex += (daysOfMonth[i] - 1);
        } else {
            dayIndex += daysOfMonth[i];
        }
    }
    
    dayIndex += (components.day - 1);
    
    return dayIndex;
}

+ (NSDate *)dateSinceNowWithDayInterval:(NSInteger)dayInterval {
    return [NSDate dateWithTimeIntervalSinceNow:dayInterval*24*60*60];
}

+ (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *formatter = [TimeService sharedInstance].commonDateFormatter;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter dateFromString:dateString];
}

+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)fmt {
    NSDateFormatter *formatter = [TimeService sharedInstance].commonDateFormatter;
    [formatter setDateFormat:fmt];
    return [formatter dateFromString:dateString];
}

- (NSString *)dateOfStringWithFormat:(NSString *)fmt {
    NSDateFormatter *formatter = [TimeService sharedInstance].commonDateFormatter;
    [formatter setDateFormat:fmt];
    return [formatter stringFromDate:self];
}

- (NSString *)dateOfStringWithFormatOfGMT8:(NSString *)fmt {
    // to fix alipay bug
    NSTimeZone* gmt8Zone = [NSTimeZone timeZoneForSecondsFromGMT:3600*8];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:gmt8Zone];
    [formatter setDateFormat:fmt];
    return [formatter stringFromDate:self];
}

- (NSDateComponents *)components {
    return [[NSCalendar currentCalendar] components:
            NSCalendarUnitYear|
            NSCalendarUnitMonth|
            NSCalendarUnitWeekOfMonth|
            NSCalendarUnitWeekday fromDate:self];
}

- (NSInteger)year {
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:self];
    return [components year];
}


- (NSInteger)month {
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    NSDateComponents *components = [gregorian components:NSCalendarUnitMonth fromDate:self];
    return [components month];
}

- (NSInteger)day {
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay fromDate:self];
    return [components day];
}

- (NSInteger)weekday {
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday fromDate:self];
    return [components weekday]; // 1～7  周日～周六
}

+ (NSString *)weekdayOfCurrentDate{
    return [NSDate weekdayCnTextForWeekDayComponent:[[NSDate date] weekday]];
}

- (NSDate *)offsetMonth:(NSInteger)numMonths {
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}

- (NSDate *)offsetHours:(NSInteger)hours {
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:hours];
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}

- (NSDate *)offsetDay:(NSInteger)numDays {
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}

- (NSUInteger)numDaysInMonth {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange rng = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    NSUInteger numberOfDaysInMonth = rng.length;
    return numberOfDaysInMonth;
}

+ (NSDate *)dateStartOfDay:(NSDate *)date {
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    
    NSDateComponents *components =
    [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth |
                           NSCalendarUnitDay) fromDate: date];
    return [gregorian dateFromComponents:components];
}

+ (NSDate *)dateStartOfWeek {
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: - ((([components weekday] - [gregorian firstWeekday])
                                      + 7 ) % 7)];
    NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract toDate:[NSDate date] options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                        fromDate: beginningOfWeek];
    
    //gestript
    beginningOfWeek = [gregorian dateFromComponents: componentsStripped];
    
    return beginningOfWeek;
}

+ (NSDate *)dateEndOfWeek {
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay: + (((([components weekday] - [gregorian firstWeekday])
                                  + 7 ) % 7))+6];
    NSDate *endOfWeek = [gregorian dateByAddingComponents:componentsToAdd toDate:[NSDate date] options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                        fromDate: endOfWeek];
    
    //gestript
    endOfWeek = [gregorian dateFromComponents: componentsStripped];
    return endOfWeek;
}

- (NSUInteger)firstWeekDayInMonth {
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    [gregorian setFirstWeekday:2]; //monday is first day
    
    //Set date to first of month
    NSDateComponents *comps = [gregorian components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                           fromDate:self];
    [comps setDay:1];
    NSDate *newDate = [gregorian dateFromComponents:comps];

    return [gregorian ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:newDate];
}

static NSArray *weekCnText;

+ (NSString *)weekdayCnTextForWeekDayComponent:(NSInteger)week {
    weekCnText = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    
    if (week < 1 || week > 7) return @"";
    
    return [weekCnText objectAtIndex:week - 1];
}

+(NSDate*)dateFromLongLong:(long long)msSince1970{
    return [NSDate dateWithTimeIntervalSince1970:msSince1970 / 1000];
}

// yyyy-MM-dd HH:mm:ss
+ (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [TimeService sharedInstance].commonDateFormatter;
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}

// yyyy-MM-dd HH:mm
+ (NSString *)stringWithYearMonthDayHourMinuteMiddleLineFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [TimeService sharedInstance].commonDateFormatter;
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

// yyyy-MM-dd HH:mm:ss
+ (NSString *)stringWithYearMonthDayHourMinuteSecondsMiddleLineFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [TimeService sharedInstance].commonDateFormatter;
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

// HH:mm
+ (NSString *)stringWithHourMinuteFromDate:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [TimeService sharedInstance].commonDateFormatter;
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *)stringWithMonthDayHourMinuteFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [TimeService sharedInstance].commonDateFormatter;
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}

+ (NSString *)stringWithMonthDayHourMinuteSecondFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [TimeService sharedInstance].commonDateFormatter;
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}

+ (NSString *)stringWithYearMonthDayHourMinuteFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [TimeService sharedInstance].commonDateFormatter;
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}



/*
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+ (NSString *)compareCurrentTime:(NSDate *) compareDate {
    NSTimeInterval timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long long temp = 0;
    NSString *result;
    if (timeInterval < 0) {
        result = [compareDate dateOfStringWithFormat:@"MM月dd日"];
    } else if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    } else if((temp = timeInterval/60) <60) {
        result = [NSString stringWithFormat:@"%lld分钟前",temp];
    } else if((temp = temp/60) <24) {
        result = [NSString stringWithFormat:@"%lld小时前",temp];
    } else if((temp = temp/24) <30) {
        result = [NSString stringWithFormat:@"%lld天前",temp];
    } else if((temp = temp/30) <12) {
        result = [NSString stringWithFormat:@"%lld月前",temp];
    } else {
        temp = temp/12;
        result = [NSString stringWithFormat:@"%lld年前",temp];
    }
    return  result;
}



/*
 * 计算两个时间的差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年) (比如，3天、2小时、10分钟)
 */
+ (NSString *)compareDate1:(NSDate *)date1 date2:(NSDate *)date2 {
    
    NSTimeInterval timeInterval1 = [date1 timeIntervalSinceNow];
    NSTimeInterval timeInterval2 = [date2 timeIntervalSinceNow];
    NSTimeInterval diffTimeInterval = timeInterval1 - timeInterval2;
    if (diffTimeInterval < 0) {
        diffTimeInterval = -diffTimeInterval;
    }
    
    long long temp = diffTimeInterval;
    NSString *result;
    if (temp < 60) {
        result = [NSString stringWithFormat:@"%lld秒",temp];
    } else if((temp = temp/60) <60) {
        result = [NSString stringWithFormat:@"%lld分钟",temp];
    } else if((temp = temp/60) <24) {
        result = [NSString stringWithFormat:@"%lld小时",temp];
    } else if((temp = temp/24) <30) {
        result = [NSString stringWithFormat:@"%lld天",temp];
    } else if((temp = temp/30) <12) {
        result = [NSString stringWithFormat:@"%lld月",temp];
    } else {
        temp = temp/12;
        result = [NSString stringWithFormat:@"%lld年",temp];
    }
    return  result;
}


+ (NSString *)compareCurrentTimeType2:(NSDate *) compareDate {
    NSTimeInterval timeInterval = [compareDate timeIntervalSinceDate:[NSDate date]];
    timeInterval = MAX(timeInterval, -timeInterval);  //取绝对值
    
    int days =  timeInterval / 60 /60 / 24;
    int hours = (timeInterval - days * 60 * 60 * 24) / 60 / 60;
    int mins =  (timeInterval - days * 60 * 60 * 24 - hours * 60 * 60 ) / 60 ;
    
    if (days > 0) {
        return [NSString stringWithFormat:@"%d天%d小时%d分钟",days, hours, mins];
    }else if( hours > 0 ){
        return [NSString stringWithFormat:@"%d小时%d分钟", hours, mins];
    }else{
        return [NSString stringWithFormat:@"%d分钟", mins];
    }

}

/**
 *  获得传进来的时间和当前时间的时间差  方便下面进行排序
 *
 *  @param currentDate  返回值越大，证明离当前时间越长，就给它放后面
 *
 *  @return
 */
+ (NSTimeInterval)compareTimeGetSubTime:(NSDate *)currentDate{
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    return timeInterval;
}

+ (NSTimeInterval)compareTwoTimeGetSubTime:(NSDate *)firstDate secondTime:(NSDate *)secondDate{
    NSTimeInterval timeInterval1 = [firstDate timeIntervalSinceNow];
    NSTimeInterval timeInterval2 = [secondDate timeIntervalSinceNow];
    return timeInterval2 - timeInterval1;
}

/**
 *
 *  计算指定时间与当前的时间隔多少天
 *
 */
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate {
    NSTimeInterval ti = [[self beginningOfDaytime] timeIntervalSinceDate:[anotherDate beginningOfDaytime]];
    return (NSInteger) (ti / D_DAY);
}

/**
 *
 *  计算指定时间与当前的时间隔多少年
 *
 */
- (NSInteger)distanceInYearsToDate:(NSDate *)anotherDate {
    
    NSTimeInterval timeInterval = [self timeIntervalSinceDate:anotherDate];
    
    if (timeInterval < 0) {
        
        timeInterval = -timeInterval;
    }

    return (NSInteger) (timeInterval / D_DAY / 365);
}

+ (BOOL)compareLocalTimeOverrideOneDay:(NSDate *) compareDate{
    NSTimeInterval timeInterval = [compareDate timeIntervalSinceNow];
    BOOL result = NO;
    if (timeInterval < 0) {
        result = NO;
    } else if((timeInterval/3600) <24) {
        result = NO;
    } else {
        result = YES;
    }
    return  result;
}

+ (NSString *)dateWithHourMiniteAndSecond:(long long)timeInterver {
    long long hourStr = timeInterver/D_HOUR;
    long long miniteStr = (timeInterver%D_HOUR)/D_MINUTE;
    long long secondStr = (timeInterver%D_MINUTE);
    return [NSString stringWithFormat:@"%02lld:%02lld:%02lld",hourStr,miniteStr,secondStr];
}

+ (NSString *)getWeekday:(NSDate *)date{
    switch ([date weekday]) {
        case 1:
            return @"周日";
            break;
        case 2:
            return @"周一";
            break;
        case 3:
            return @"周二";
            break;
        case 4:
            return @"周三";
            break;
        case 5:
            return @"周四";
            break;
        case 6:
            return @"周五";
            break;
        case 7:
            return @"周六";
            break;
        default:
            break;
    }
    return nil;
}

+ (NSString*)getStartTime:(int)startBlock{
    NSString *nowTime;
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    [dateComponent setHour:8];
    [dateComponent setMinute:0];
    [dateComponent setSecond:0];
    [dateComponent setMinute:startBlock*30];
    
    
    NSDate *date = [calendar dateFromComponents:dateComponent];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm"];
    
    nowTime = [formatter stringFromDate:date];
    
    if ([nowTime isEqualToString:@"00:00"]) {
        nowTime = @"24:00";
    }
    return nowTime;
}

+ (NSInteger)getTodaysTimestamp{
    NSCalendar *calendar = [TimeService sharedInstance].gregorianCalendar;
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *date = [calendar dateFromComponents:components];
    return [date timeIntervalSince1970];
}

+ (NSInteger)getTimestampFromToday:(NSInteger)value{
    NSCalendar *calendar = [TimeService sharedInstance].gregorianCalendar;
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *date = [calendar dateByAddingUnit:NSCalendarUnitDay value:value toDate:startDate options:0];
    return [date timeIntervalSince1970];
}


#pragma mark 获得不是nsdate类型的开始时间

+ (NSString*)getEndTime:(int)endBlock{
    NSString *nowTime;
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    [dateComponent setHour:8];
    [dateComponent setMinute:0];
    [dateComponent setSecond:0];
    [dateComponent setMinute:endBlock*30+30];
    
    NSDate *date = [calendar dateFromComponents:dateComponent];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm"];
    
    nowTime = [formatter stringFromDate:date];
    
    if ([nowTime isEqualToString:@"00:00"]) {
        nowTime = @"24:00";
    }
    return nowTime;
}

+ (NSDate *)getStartDate:(NSInteger)startBlock {
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    [dateComponent setHour:8];
    [dateComponent setMinute:0];
    [dateComponent setSecond:0];
    [dateComponent setMinute:startBlock*30];
    
    
    return [calendar dateFromComponents:dateComponent];
}

+ (NSDate *)getEndDate:(NSInteger)endBlock {
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    [dateComponent setHour:8];
    [dateComponent setMinute:0];
    [dateComponent setSecond:0];
    [dateComponent setMinute:endBlock*30+30];
    
    return [calendar dateFromComponents:dateComponent];
}

/// 指定 date
+ (NSDate *)getStartDate:(NSInteger)startBlock date:(NSDate *)date {
    NSDate *now = date;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    [dateComponent setHour:8];
    [dateComponent setMinute:0];
    [dateComponent setSecond:0];
    [dateComponent setMinute:startBlock*30];
    
    
    return [calendar dateFromComponents:dateComponent];
}

/// 指定 date
+ (NSDate *)getEndDate:(NSInteger)endBlock date:(NSDate *)date {
    NSDate *now = date;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    [dateComponent setHour:8];
    [dateComponent setMinute:0];
    [dateComponent setSecond:0];
    [dateComponent setMinute:endBlock*30+30];
    
    return [calendar dateFromComponents:dateComponent];
}

/**
 *  2017年（如果跨年显示年）7月1日 7:00
 */
+ (NSString *)getDateAndStartStringWithDate:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [TimeService sharedInstance].commonDateFormatter;
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    if (date.year == [NSDate date].year) {
        [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    }else{
        [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    }
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *)getDateStringWithDate:(NSDate *)date withStartBlock:(int)startBlock withEndBlock:(int)endBlock{
    NSString *dayDateStr = [date dateOfStringWithFormat:@"MM月dd日"];
    NSString *weekStr = [NSDate weekdayCnTextForWeekDayComponent:[date weekday]];
    NSString *startTime = [NSDate getStartTime:startBlock];
    NSString *endTime = [NSDate getEndTime:endBlock];
    
    return [NSString stringWithFormat:@"%@ 周%@ %@-%@",dayDateStr,weekStr,startTime,endTime];
}

/**
 *  2017年（如果跨年显示年）7月1日 周二 7:00-8:00
 */
+ (NSString *)getYearOrMonthDayWeekStartEndTimeStringWithDate:(NSDate *)date withStartBlock:(int)startBlock withEndBlock:(int)endBlock {
    
    NSString *dayDateStr;
    if (date.year == [NSDate date].year) {
        dayDateStr = [date dateOfStringWithFormat:@"MM月dd日"];
    }else{
        dayDateStr = [date dateOfStringWithFormat:@"yyyy年MM月dd日"];
    }
    NSString *weekStr = [NSDate weekdayCnTextForWeekDayComponent:[date weekday]];
    NSString *startTime = [NSDate getStartTime:startBlock];
    NSString *endTime = [NSDate getEndTime:endBlock];
    
    return [NSString stringWithFormat:@"%@ 周%@ %@-%@",dayDateStr,weekStr,startTime,endTime];
}

/**
 *  2017年（如果跨年显示年）07月01日 周二 07:00-08:00
 */
+ (NSString *)getYearOrMonthDayWeekStartEndTimeStringWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    
    NSString *dayDateStr;
    if (startDate.year == [NSDate date].year) {
        dayDateStr = [startDate dateOfStringWithFormat:@"MM月dd日"];
    }else{
        dayDateStr = [startDate dateOfStringWithFormat:@"yyyy年MM月dd日"];
    }
    NSString *weekStr = [NSDate weekdayCnTextForWeekDayComponent:[startDate weekday]];
    NSString *startTime = [startDate dateOfStringWithFormat:@"HH:mm"];
    NSString *endTime = [endDate dateOfStringWithFormat:@"HH:mm"];
    
    return [NSString stringWithFormat:@"%@ 周%@ %@-%@",dayDateStr,weekStr,startTime,endTime];
}

+ (NSString *)getDateStringWithDateNewStyle:(NSString *)dateString withStartBlock:(int)startBlock withEndBlock:(int)endBlock{
    NSString *startTime = [NSDate getStartTime:startBlock];
    NSString *endTime = [NSDate getEndTime:endBlock];
    return [NSString stringWithFormat:@"%@ %@ 至 %@",dateString,startTime,endTime];
}

/**
 *  格式 跨年 2016年12月 非跨年 12月
 */
+ (NSString *)getYearOrMonthWithDate:(NSDate *)date {
    
    NSString *dateString;
    if (date.year == [NSDate date].year) {
        dateString = [date dateOfStringWithFormat:@"MM月"];
    }else{
        dateString = [date dateOfStringWithFormat:@"yyyy年MM月"];
    }
    
    return dateString;
}

/**
 *  格式 跨年 2016年12月3日 非跨年 12月3日
 */
+ (NSString *)getYearOrMonthDayWithDate:(NSDate *)date {
    
    NSString *dateString;
    if (date.year == [NSDate date].year) {
        dateString = [date dateOfStringWithFormat:@"MM月dd日"];
    }else{
        dateString = [date dateOfStringWithFormat:@"yyyy年MM月dd日"];
    }
    
    return dateString;
}

/**
 *  格式 跨年 2016年12月3日 13:33 非跨年 12月3日 13:33
 */
+ (NSString *)getYearOrMonthDayHourMinuteWithDate:(NSDate *)date {
    
    NSString *dateString;
    if (date.year == [NSDate date].year) {
        dateString = [date dateOfStringWithFormat:@"MM月dd日 HH:mm"];
    }else{
        dateString = [date dateOfStringWithFormat:@"yyyy年MM月dd日 HH:mm"];
    }
    
    return dateString;
}

/**
 *  格式 01月03日
 */
+ (NSString *)getMonthDayWithDate:(NSDate *)date {
    
    NSString *dateString = [date dateOfStringWithFormat:@"MM月dd日"];
    
    return dateString;
}

/**
 *  格式 1月3日
 */
+ (NSString *)getMonthDayNoZeroWithDate:(NSDate *)date {
    
    NSString *dateString = [date dateOfStringWithFormat:@"M月d日"];
    
    return dateString;
}

/**
 *  格式 2017年12月3日
 */
+ (NSString *)getYearMonthDayWithDate:(NSDate *)date {
    
    NSString *dateString = [date dateOfStringWithFormat:@"yyyy年MM月dd日"];
    
    return dateString;
}

- (BOOL)isYearMonthDayEqualToDate:(NSDate *)anotherDate {
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    NSDateComponents *components1 = [gregorian components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    NSDateComponents *components2 = nil;
    if (anotherDate) {
        components2 = [gregorian components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:anotherDate];
    }
    return ((components1.day == components2.day) && (components1.month == components2.month) && (components1.year == components2.year));
}

- (BOOL)isYearMonthEqualToDate:(NSDate *)anotherDate {
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    NSDateComponents *components1 = [gregorian components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = nil;
    if (anotherDate) {
        components2 = [gregorian components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:anotherDate];
    }
    return ((components1.month == components2.month) && (components1.year == components2.year));
}

- (BOOL)isYearEqualToDate:(NSDate *)anotherDate {
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    NSDateComponents *components1 = [gregorian components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = nil;
    if (anotherDate) {
        components2 = [gregorian components:NSCalendarUnitYear fromDate:anotherDate];
    }
    return (components1.year == components2.year);
}

- (BOOL)isComponentDayEqualToDate:(NSDate *)anotherDate {
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    NSDateComponents *components1 = [gregorian components:NSCalendarUnitDay fromDate:self];
    NSDateComponents *components2 = nil;
    if (anotherDate) {
        components2 = [gregorian components:NSCalendarUnitDay fromDate:anotherDate];
    }
    
    return ([components1 day] == [components2 day]);
}

- (BOOL)isToday {
    return [self isYearMonthDayEqualToDate:[NSDate date]];
}

- (BOOL)isThisYear{
    return [self isYearEqualToDate:[NSDate date]];
}

/// 按时间戳比较，精确到秒
- (NSComparisonResult)compareByTimestamp:(NSDate *)date {
    
    return [@([self timeIntervalSince1970]) compare:@([date timeIntervalSince1970])];
}

/// 比某日早
- (BOOL)compareByTimestampIsEarlierThanDate:(NSDate *)anotherDate {
    
    if ([self compareByTimestamp:anotherDate] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}

/// 比某日晚
- (BOOL)compareByTimestampIsLaterThanDate:(NSDate *)anotherDate {
    
    if ([self compareByDay:anotherDate] == NSOrderedDescending) {
        return YES;
    }
    return NO;
}

/// 比某日早
- (BOOL)isEarlierThanDate:(NSDate *)anotherDate {
    
    if ([self compareByDay:anotherDate] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}

/// 比某日晚
- (BOOL)isLaterThanDate:(NSDate *)anotherDate {
    
    if ([self compareByDay:anotherDate] == NSOrderedDescending) {
        return YES;
    }
    return NO;
}

/// 比今天早
- (BOOL)isEarlierThanToday {
    
    return [self isEarlierThanDate:[NSDate today]];
}

/// 比今天晚
- (BOOL)isLaterThanToday {
    
    return [self isLaterThanDate:[NSDate today]];
}

/// 获取比两年后晚的日期，2017-08-15 ~ 2019-07-31
+ (NSDate *)getLastDayAfterTwentyThreeMonth {
    
    /// 先找到这个月第一天 2017-08-01
    NSDate *today = [NSDate today];
    NSDate *firstDayOfThisMonth = [NSDate today];
    /// 一天天往前找
    while ([firstDayOfThisMonth isYearMonthEqualToDate:today]) {
        
        firstDayOfThisMonth = [firstDayOfThisMonth dateByAddingDays:- 1];
    }
    /// 找到了 2017-08-01
    firstDayOfThisMonth = [firstDayOfThisMonth dateByAddingDays:1];
    
    /// 找两年后的这一天 2019-08-01，直接加 365 * 2 + 10，10 是 防止意外，把日期加到  2019-08-11 左右
    NSDate *dayAfterTwentyFourMonth = [firstDayOfThisMonth dateByAddingDays:365 * 2 + 10];
    NSDate *lastDayAfterTwentyMonth = dayAfterTwentyFourMonth;
    
    /// 继续一天天往前找，找到前一个月的最后一天  2019-07-31
    while ([lastDayAfterTwentyMonth isYearMonthEqualToDate:dayAfterTwentyFourMonth]) {
        
        lastDayAfterTwentyMonth = [lastDayAfterTwentyMonth dateByAddingDays:- 1];
    }
    
    return lastDayAfterTwentyMonth;
}

// 本周
- (BOOL)isThisWeek {
    
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    [gregorian setFirstWeekday:2];
    NSDateComponents *components1 = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:self];
    NSDateComponents *components2 = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:[NSDate today]];
    
    return ((components1.weekOfYear == components2.weekOfYear) && (components1.year == components2.year));
}

// 下周
- (BOOL)isNextWeek {
    
    // 想了一下，这里加一周后，跳到第二年，同时这里匹配了年份，会不会有问题？
    // 不会，因为比较的对象是加了 7 天后的 date，那个年份已经改变过了（如果有需要）
    // 因此作为比较对象，另一个 date 也是第二年的，没问题！
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    [gregorian setFirstWeekday:2];
    NSDateComponents *components1 = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:self];
    NSDateComponents *components2 = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:[[NSDate today] dateByAddingDays:7]];
    
    return ((components1.weekOfYear == components2.weekOfYear) && (components1.year == components2.year));
}

// 下周之前（更早）
- (BOOL)isEarlierThanNextWeek {
    
    // 两个判断条件
    // 1. 比 14 天前的今天早
    // 2. 和两周前是同一周
    // 用两个的原因是我不知道有没有办法找到两周前的第一天，且这一天的定义也不知道按哪个
    
    if ([self compareByDay:[[NSDate today] dateByAddingDays:14]] == NSOrderedDescending) {
        return YES;
    }
    
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    [gregorian setFirstWeekday:2];
    NSDateComponents *components1 = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:self];
    NSDateComponents *components2 = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:[[NSDate today] dateByAddingDays:14]];
    
    return ((components1.weekOfYear == components2.weekOfYear) && (components1.year == components2.year));
}

// 上周
- (BOOL)isLastWeek{
    
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    [gregorian setFirstWeekday:2];
    NSDateComponents *components1 = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:self];
    NSDateComponents *components2 = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:[[NSDate today] dateByAddingDays:- 7]];
    
    return ((components1.weekOfYear == components2.weekOfYear) && (components1.year == components2.year));
}

// 上周之后（更晚）
- (BOOL)isLaterThanLastWeek {
    
    // 两个判断条件
    // 1. 比 -14 天前的今天晚
    // 2. 和两周后是同一周
    // 用两个的原因是我不知道有没有办法找到两周后的第一天，且这一天的定义也不知道按哪个
    
    if ([self compareByDay:[[NSDate today] dateByAddingDays:- 14]] == NSOrderedAscending) {
        return YES;
    }
    
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    [gregorian setFirstWeekday:2];
    NSDateComponents *components1 = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:self];
    NSDateComponents *components2 = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:[[NSDate today] dateByAddingDays:- 14]];
    
    return ((components1.weekOfYear == components2.weekOfYear) && (components1.year == components2.year));
}

// 上年
- (BOOL)isLastYear {
    
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    NSDateComponents *components1 = [gregorian components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [gregorian components:NSCalendarUnitYear fromDate:[NSDate today]];
    
    return (components1.year < components2.year);
}

/// 是否 周X（周日:1 周六:7）
- (BOOL)isWeekday:(NSInteger)weekday{
    
    return self.weekday == weekday;
}

/// 获取今天的 date
+ (NSDate *)today {
    
    return [NSDate date];
}

/// 获取这个月的第一天
- (NSDate *)firstDayOfCurrentMonth {
    
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}

/// 获取上个月的第一天
- (NSDate *)firstDayOfLastMonth {
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[self firstDayOfCurrentMonth] options:0];
}

/// 获取下个月的第一天
- (NSDate *)firstDayOfNextMonth {
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = 1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[self firstDayOfCurrentMonth] options:0];
}

/// 获取这周的第一天
- (NSDate *)firstDayOfCurrentWeek {
    
    NSDate *firstDayOfThisWeek = self;
    
    /// 一天天往前找
    while ([firstDayOfThisWeek isThisWeek]) {
        firstDayOfThisWeek = [firstDayOfThisWeek dateByAddingDays:-1];
    }
    
    return [firstDayOfThisWeek dateByAddingDays:1];
}

- (NSDate *)dateByAddingDays:(NSInteger)dDays {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = dDays;
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    return [gregorian dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour = hours;
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    return [gregorian dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateBySubtractingDays:(NSInteger)dDays {
    return [self dateByAddingDays:-dDays];
}

+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)dDays {
    return [[NSDate date] dateBySubtractingDays:dDays];
}

+ (NSDate *)dateYesterday {
    return [NSDate dateWithDaysBeforeNow:1];
}

- (BOOL)isEqualToDateIgnoringTime:(NSDate * _Nonnull) otherDate {
    NSCalendar *currentCalendar = [TimeService sharedInstance].gregorianCalendar;
    NSCalendarUnit unitFlags = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components1 = [currentCalendar components:unitFlags fromDate:self];
    NSDateComponents *components2 = [currentCalendar components:unitFlags fromDate:otherDate];
    return (components1.era == components2.era) &&
    (components1.year == components2.year) &&
    (components1.month == components2.month) &&
    (components1.day == components2.day);
}

- (BOOL)isYesterday {
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

- (BOOL)isDayEqualToDate:(NSDate *)anotherDate {
    return [self day] != [anotherDate day] ? NO : YES;
}

- (NSComparisonResult)compareByDay:(NSDate *)date {
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    NSDateComponents *components1 = [gregorian components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    NSDateComponents *components2 = [gregorian components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    if (components1.day == components2.day && components1.month == components2.month && components1.year == components2.year) {
        return NSOrderedSame;
    } else if ((components1.year == components2.year && components1.month == components2.month && components1.day < components2.day) ||
               (components1.year == components2.year && components1.month < components2.month) ||
               (components1.year < components2.year)) {
        // self < date
        return NSOrderedAscending;
    } else if ((components1.year > components2.year) ||
               (components1.month > components2.month && components1.year == components2.year) ||
               (components1.year == components2.year && components1.month == components2.month && components1.day > components2.day)) {
        return NSOrderedDescending;
    }
    
    // what?
    return NSOrderedDescending;
}

- (NSDate *)dateAfterDay:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Get the weekday component of the current date
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return dateAfterDay;
}

- (NSDate *)dateAfterMonth:(int)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return dateAfterMonth;
}

- (NSDate *)dateAfterYear:(int)year {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setYear:year];
    
    NSDate *dateAfterYear = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return dateAfterYear;
}

- (NSDate *)dateAfterYear:(int)year month:(int)month day:(int)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setYear:year];
    [componentsToAdd setMonth:month];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterYearMonthDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return dateAfterYearMonthDay;
}

- (NSDate *)beginningOfMonth {
    return [self dateAfterDay:-[self day] + 1];
}

- (NSDate *)endOfMonth {
    return [[[self beginningOfMonth] dateAfterMonth:1] dateAfterDay:-1];
}

- (NSDate *)beginningOfDaytime {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    
    [dateComponent setHour:0];
    [dateComponent setMinute:0];
    [dateComponent setSecond:0];
    
    return [calendar dateFromComponents:dateComponent];
}

- (NSDate *)dateByCopyHourMinuteSecondFromDate:(NSDate*)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    NSDateComponents *otherDateComponent = [calendar components:unitFlags fromDate:date];

    [dateComponent setHour:otherDateComponent.hour];
    [dateComponent setMinute:otherDateComponent.minute];
    [dateComponent setSecond:otherDateComponent.second];
    
    return [calendar dateFromComponents:dateComponent];
}

#pragma mark - IM中使用的

/*标准时间日期描述*/
-(NSString *)formattedTime{
    NSDateFormatter* formatter = [TimeService sharedInstance].commonDateFormatter;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [[NSDate date] day];
    [components setDay:[[NSDate date] day]];
    [components setMonth:[[NSDate date] month]];
    [components setYear:[[NSDate date] year]];

    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    NSDate *date = [gregorian dateFromComponents:components]; //今天 0点时间
    
    NSInteger hour = [self hoursAfterDate:date];
    NSDateFormatter *dateFormatter = nil;
    NSString *ret = @"";
    
    //hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    
    if (!hasAMPM) { //24小时制
        if (hour <= 24 && hour >= 0) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"HH:mm"];
        }else if (hour < 0 && hour >= -24) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"昨天HH:mm"];
        }else {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd HH:mm"];
        }
    }else {
        if (hour >= 0 && hour <= 6) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"凌晨hh:mm"];
        }else if (hour > 6 && hour <=11 ) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"上午hh:mm"];
        }else if (hour > 11 && hour <= 17) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"下午hh:mm"];
        }else if (hour > 17 && hour <= 24) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"晚上hh:mm"];
        }else if (hour < 0 && hour >= -24){
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"昨天HH:mm"];
        }else  {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd HH:mm"];
        }
    }
    
    ret = [dateFormatter stringFromDate:self];
    return ret;
}

- (NSString *)formattedTimeForChatRoomHistory {
    NSDateFormatter* formatter = [TimeService sharedInstance].commonDateFormatter;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString * dateNow = [formatter stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[[dateNow substringWithRange:NSMakeRange(8,2)] intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(5,2)] intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)] intValue]];
    NSCalendar *gregorian = [TimeService sharedInstance].gregorianCalendar;
    NSDate *date = [gregorian dateFromComponents:components]; //今天 0点时间
    
    NSString *weekStr = [NSDate weekdayCnTextForWeekDayComponent:[self weekday]];
    NSInteger hour = [self hoursAfterDate:date];
    //    NSInteger minite = [self minitesAfterDate:date];
    NSDateFormatter *dateFormatter = nil;
    NSString *ret = @"";
    
    //hasAMPM==TURE为12小时制，否则为24小时制
    //    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    //    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    //    BOOL hasAMPM = containsA.location != NSNotFound;
    //    if (!hasAMPM) { //24小时制
    if (hour <= 24 && hour >= 0) {
        dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"HH:mm"];
    } else if (hour < 0 && hour >= -24) {
        dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"昨天 HH:mm"];
    } else if (hour < -24 && hour > -24*7) {
        NSString *dateFormatterStr = [NSString stringWithFormat:@"星期%@ HH:mm",weekStr];
        dateFormatter = [NSDateFormatter dateFormatterWithFormat:dateFormatterStr];
    } else {
        dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy年MM月dd日 HH:mm"];
    }
    //    } else {
    //        if (hour >= 0 && hour <= 6) {
    //            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"凌晨hh:mm"];
    //        }else if (hour > 6 && hour <=11 ) {
    //            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"上午hh:mm"];
    //        }else if (hour > 11 && hour <= 17) {
    //            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"下午hh:mm"];
    //        }else if (hour > 17 && hour <= 24) {
    //            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"晚上hh:mm"];
    //        }else if (hour < 0 && hour >= -24){
    //            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"昨天HH:mm"];
    //        }else  {
    //            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd HH:mm"];
    //        }
    //    }
    
    ret = [dateFormatter stringFromDate:self];
    return ret;
    
}

+(NSInteger) calcDaysFromBegin:(NSDate *)inBegin end:(NSDate *)inEnd
{
    NSInteger unitFlags = NSCalendarUnitDay| NSCalendarUnitMonth | NSCalendarUnitYear;
    NSCalendar *cal = [TimeService sharedInstance].gregorianCalendar;
    NSDateComponents *comps = [cal components:unitFlags fromDate:inBegin];
    NSDate *newBegin  = [cal dateFromComponents:comps];
    
    NSCalendar *cal2 = [TimeService sharedInstance].gregorianCalendar;
    NSDateComponents *comps2 = [cal2 components:unitFlags fromDate:inEnd];
    NSDate *newEnd  = [cal2 dateFromComponents:comps2];
    
    NSTimeInterval interval = [newEnd timeIntervalSinceDate:newBegin];
    NSInteger beginDays=((NSInteger)interval)/(3600*24);
    
    return beginDays;
}

+ (NSString *)getTimeDescriptionWithDate:(NSDate *)timeDate {
    NSInteger betweendays = [self calcDaysFromBegin:[NSDate date] end:timeDate];
    if (betweendays >= 7 ) {
        return @"七天后";
    } else if (betweendays == 6) {
        return @"六天后";
    } else if (betweendays == 5) {
        return @"五天后";
    } else if (betweendays == 4) {
        return @"四天后";
    } else if (betweendays == 3) {
        return @"三天后";
    } else if (betweendays == 2) {
        return @"后天";
    } else if (betweendays == 1) {
        return @"明天";
    } else if (betweendays == 0) {
        return @"今天";
    } else if (betweendays == -1) {
        return @"昨天";
    } else if (betweendays == -2) {
        return @"两天前";
    } else if (betweendays == -3) {
        return @"三天前";
    } else if (betweendays == -4) {
        return @"四天前";
    } else if (betweendays == -5) {
        return @"五天前";
    } else if (betweendays == -6) {
        return @"六天前";
    } else if (betweendays < -6 && betweendays > -14) {
        return @"一周前";
    } else if (betweendays <= -14 && betweendays > -21) {
        return @"两周前";
    } else if (betweendays <= -21 && betweendays > -28) {
        return @"三周前";
    } else if (betweendays <= -28 && betweendays > -30) {
        return @"四周前";
    } else {
        return @"一个月前";
    }
}

+ (NSString *)getStudentPoolInfoTimeDescriptionWithDate:(NSDate *)timeDate {
    NSInteger betweendays = [self calcDaysFromBegin:[NSDate date] end:timeDate];
    
    if (betweendays >= 30) {
        return @"1个月后";
    } else if (betweendays >= 28) {
        return @"4周后";
    } else if (betweendays >= 21) {
        return @"4周内";
    } else if (betweendays >= 14) {
        return @"3周内";
    } else if (betweendays >= 7) {
        return @"2周内";
    } else if (betweendays >= 3) {
        return @"1周内";
    } else if (betweendays == 2) {
        return @"后天";
    } else if (betweendays == 1) {
        return @"明天";
    } else if (betweendays == 0) {
        return @"今天";
    } else if (betweendays == -1) {
        return @"昨天";
    } else if (betweendays == -2) {
        return @"2天前";
    } else if (betweendays == -3) {
        return @"3天前";
    } else if (betweendays == -4) {
        return @"4天前";
    } else if (betweendays == -5) {
        return @"5天前";
    } else if (betweendays == -6) {
        return @"6天前";
    } else if (betweendays < -6 && betweendays > -14) {
        return @"1周前";
    } else if (betweendays <= -14 && betweendays > -21) {
        return @"2周前";
    } else if (betweendays <= -21 && betweendays > -28) {
        return @"3周前";
    } else if (betweendays <= -28 && betweendays > -30) {
        return @"4周前";
    } else {
        return @"1个月前";
    }
}

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond {
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    if(timeIntervalInMilliSecond > 140000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return ret;
}

- (NSInteger)hoursAfterDate: (NSDate *)aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)minitesAfterDate: (NSDate *)aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)secondsAfterDate: (NSDate *)aDate {
    return [self timeIntervalSinceDate:aDate];
}


- (BOOL)isCurrentDay: (NSDate *)date {
    
    NSTimeInterval offset = [NSTimeZone localTimeZone].secondsFromGMT;
    
    if ((int)(([self timeIntervalSince1970] + offset)/(24*3600))
        - (int)(([date timeIntervalSince1970] + offset)/(24*3600))
        == 0) {
        return YES;
    }
    return NO;
}

/**
 返回时间戳，毫秒
 */
- (int64_t)dateLongLong {
    return [self timeIntervalSince1970] * 1000;
}

#pragma mark - 作业截止时间转换

+ (NSString*)convertDateToDeadLineString:(long long)deltaDay {
    NSArray* weekStringArray = @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"];
    NSDate* todayDate = [NSDate dateWithTimeIntervalSinceNow:deltaDay*24*60*60];
    NSDateComponents *componets = [[TimeService sharedInstance].gregorianCalendar components:NSCalendarUnitWeekday | kCFCalendarUnitMonth | kCFCalendarUnitDay fromDate:todayDate];
    NSInteger weekday = (([componets weekday] - [TimeService sharedInstance].gregorianCalendar.firstWeekday) + 7) % 7;
    NSString* weekDayString = weekStringArray[weekday];
    NSString* toTodayString = @"";
    if (deltaDay) {
        toTodayString = [NSString stringWithFormat:@"%lld天后", deltaDay];
    } else {
        toTodayString = @"当天";
    }
    NSString* todayMonthDayString = [NSString stringWithFormat:@"%ld月%ld日 %@ (%@)",(long) [componets month], (long)[componets day], weekDayString, toTodayString];
    return todayMonthDayString;
}

+ (NSString*)convertDateToDeadLineDayInReportPreviewString:(long long)deadlineTS {
    NSArray* weekStringArray = @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"];
    NSDate* todayDate = [NSDate dateWithTimeIntervalSince1970:deadlineTS/1000];
    NSDateComponents *componets = [[TimeService sharedInstance].gregorianCalendar components:NSCalendarUnitWeekday | kCFCalendarUnitMonth | kCFCalendarUnitDay fromDate:todayDate];
    NSInteger weekday = (([componets weekday] - [TimeService sharedInstance].gregorianCalendar.firstWeekday) + 7) % 7;
    NSString* weekDayString = weekStringArray[weekday];
    
    NSString* todayMonthDayString = [NSString stringWithFormat:@"%ld月%ld日%@截止",(long) [componets month], (long)[componets day], weekDayString];
    return todayMonthDayString;
}

+ (NSString*)convertDateToDeadLineInReportPreviewString:(long long)deltaDay {
    NSArray* weekStringArray = @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"];
    NSDate* todayDate = [NSDate dateWithTimeIntervalSinceNow:deltaDay*24*60*60];
    NSDateComponents *componets = [[TimeService sharedInstance].gregorianCalendar components:NSCalendarUnitWeekday | kCFCalendarUnitMonth | kCFCalendarUnitDay fromDate:todayDate];
    NSInteger weekday = (([componets weekday] - [TimeService sharedInstance].gregorianCalendar.firstWeekday) + 7) % 7;
    NSString* weekDayString = weekStringArray[weekday];

    NSString* todayMonthDayString = [NSString stringWithFormat:@"%ld月%ld日%@截止",(long) [componets month], (long)[componets day], weekDayString];
    return todayMonthDayString;
}
+ (NSDate *)getInternetDate{
    NSString *urlString = @"http://m.baidu.com";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval: 2];
    [request setHTTPShouldHandleCookies:FALSE];
    [request setHTTPMethod:@"GET"];
    NSHTTPURLResponse *response;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSString *date = [[response allHeaderFields] objectForKey:@"Date"];
    date = [date substringFromIndex:5];
    date = [date substringToIndex:[date length]-4];
    NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
    dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
    NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:0];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: netDate];
    NSDate *localeDate = [netDate  dateByAddingTimeInterval: interval];
    return localeDate;
}
+ (NSString *)getWeekDate:(NSDate *)timeDate {
    switch ([timeDate weekday]) {
        case 1:
            return @"星期日";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return nil;
}
@end
