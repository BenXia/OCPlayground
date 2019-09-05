//
//  NSDate+QQCalendar.h
//  QQing
//
//  Created by Ben on 5/15/14.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//
// 服务器：GMT 格林尼治时间
// 本地  ：[NSdate date] 获取的也是 gmt 标准时间
// 服务器查询时间，传值达多为yyyy-MM-dd 00:00:00

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

 
@interface NSDate (QQCalendar)

+ (BOOL)isLeapYear:(NSInteger)year;

/*
 * @abstract caculate number of days by specified month and current year
 * @param year range between 1 and 12
 */
+ (NSInteger)numberOfDaysInMonth:(NSInteger)month;

/*
 * @abstract caculate number of days by specified month and year
 * @param year range between 1 and 12
 */
+ (NSInteger)numberOfDaysInMonth:(NSInteger)month year:(NSInteger) year;

+ (NSInteger)numberOfDayInYear:(NSInteger)year;

- (NSInteger)currentDayIndexInYear;

+ (NSInteger)currentYear;

+ (NSInteger)currentMonth;

+ (NSInteger)currentDay;

/*
 * Begin with Sunday [0-6].
 */
+ (NSInteger)currentWeekDay;

+ (NSInteger)monthWithDate:(NSDate *)date;

+ (NSInteger)dayWithDate:(NSDate *)date;

+ (NSInteger)hourWithDate:(NSDate *)date;

+ (NSDate *)dateSinceNowWithDayInterval:(NSInteger)dayInterval;

/*
 *  @abstract init a NSDate instance with string
 *
 *  @param dateString: yyyy-MM-dd
 *
 *  @return NSDate instance
 */
+ (NSDate *)dateFromString:(NSString *)dateString;

+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)fmt;

- (NSString *)dateOfStringWithFormat:(NSString *)fmt;

- (NSString *)dateOfStringWithFormatOfGMT8:(NSString *)fmt;

- (NSDateComponents *)components;

- (NSDate *)offsetMonth:(NSInteger)numMonths;
- (NSDate *)offsetDay:(NSInteger)numDays;
- (NSDate *)offsetHours:(NSInteger)hours;
- (NSUInteger)numDaysInMonth;
- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;

- (NSInteger)hoursAfterDate: (NSDate *)aDate;
- (NSInteger)minitesAfterDate: (NSDate *)aDate;
- (NSInteger)secondsAfterDate: (NSDate *)aDate;

// days since Sunday [1-7]
- (NSInteger)weekday;// 星期几
+ (NSString *)getWeekday:(NSDate *)date;

+ (NSString *)weekdayOfCurrentDate;// 当前日期星期几

+ (NSDate *)dateStartOfDay:(NSDate *)date;
+ (NSDate *)dateStartOfWeek;
+ (NSDate *)dateEndOfWeek;

- (NSUInteger)firstWeekDayInMonth;

/**
 * ...
 * Sunday:1, Monday:2, Tuesday:3, Wednesday:4, Friday:5, Saturday:6
 */
+ (NSString *)weekdayCnTextForWeekDayComponent:(NSInteger)week;

/*
 * long long to nsdate
 */
+ (NSDate *)dateFromLongLong:(long long)msSince1970;

/*
 * 时间转换字符串
 */
// yyyy-MM-dd HH:mm:ss
+ (NSString *)stringFromDate:(NSDate *)date;
// HH:mm
+ (NSString *)stringWithHourMinuteFromDate:(NSDate *)date;
// MM月dd日 HH:mm
+ (NSString *)stringWithMonthDayHourMinuteFromDate:(NSDate *)date;
// MM月dd日 HH:mm:ss
+ (NSString *)stringWithMonthDayHourMinuteSecondFromDate:(NSDate *)date;
// yyyy年MM月dd日 HH:mm
+ (NSString *)stringWithYearMonthDayHourMinuteFromDate:(NSDate *)date;
// yyyy-MM-dd HH:mm
+ (NSString *)stringWithYearMonthDayHourMinuteMiddleLineFromDate:(NSDate *)date;
// yyyy-MM-dd HH:mm:ss
+ (NSString *)stringWithYearMonthDayHourMinuteSecondsMiddleLineFromDate:(NSDate *)date;

/*
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+ (NSString *)compareCurrentTime:(NSDate *)compareDate;

/*
 * 计算两个时间的差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年) (比如，3天、2小时、10分钟)
 */
+ (NSString *)compareDate1:(NSDate *)date1 date2:(NSDate *)date2;

// 1天2小时50分
+ (NSString *)compareCurrentTimeType2:(NSDate *)compareDate;


/**
 *  计算指定时间与当前的时间差
 *
 *  @param BOOL 返回值越大，证明时间越久，放最后面
 *
 *  @return
 */
+ (NSTimeInterval)compareTimeGetSubTime:(NSDate *)currentDate;

/**
 *
 *  计算指定时间与当前的时间隔多少天
 *
 */
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;

/**
 *
 *  计算指定时间与当前的时间隔多少年
 *
 */
- (NSInteger)distanceInYearsToDate:(NSDate *)anotherDate;

/*
 *判断当前时间与指定时间是否超过24小时
 */
+ (BOOL)compareLocalTimeOverrideOneDay:(NSDate *)compareDate;

/**
 *  时间段转化为时分秒格式字符串：eg:18:02:34
 */
+ (NSString *)dateWithHourMiniteAndSecond:(long long)timeInterver;

/**
 *  根据开始时间块获得时间 like 9:00
 *  根据结束时间块获得时间
 */

+ (NSString *)getStartTime:(int)startBlock;
+ (NSString *)getEndTime:(int)endBlock;

+ (NSDate *)getStartDate:(NSInteger)startBlock;
+ (NSDate *)getEndDate:(NSInteger)endBlock;

/// 指定 date
+ (NSDate *)getStartDate:(NSInteger)startBlock date:(NSDate *)date;
/// 指定 date
+ (NSDate *)getEndDate:(NSInteger)endBlock date:(NSDate *)date;

/**
 *  2017年（如果跨年显示年）7月1日 7:00
 */
+ (NSString *)getDateAndStartStringWithDate:(NSDate *)date;

/**
 *  7月1日 周二 7:00-8:00
 */
+ (NSString *)getDateStringWithDate:(NSDate *)date withStartBlock:(int)startBlock withEndBlock:(int)endBlock;

/**
 *  2017年（如果跨年显示年）7月1日 周二 7:00-8:00
 */
+ (NSString *)getYearOrMonthDayWeekStartEndTimeStringWithDate:(NSDate *)date withStartBlock:(int)startBlock withEndBlock:(int)endBlock;

/**
 *  2017年（如果跨年显示年）07月01日 周二 07:00-08:00
 */
+ (NSString *)getYearOrMonthDayWeekStartEndTimeStringWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

/** 1.27
 *  格式 2016-01-27 7:00至8:00
 */
+ (NSString *)getDateStringWithDateNewStyle:(NSString *)dateString withStartBlock:(int)startBlock withEndBlock:(int)endBlock;

/**
 *  按天粒度比较Date
 */
- (BOOL)isDayEqualToDate:(NSDate *)anotherDate;

- (BOOL)isYearMonthDayEqualToDate:(NSDate *)anotherDate;

- (BOOL)isYearMonthEqualToDate:(NSDate *)anotherDate;

- (BOOL)isYearEqualToDate:(NSDate *)anotherDate;

- (BOOL)isComponentDayEqualToDate:(NSDate *)anotherDate;

- (BOOL)isToday;
- (BOOL)isYesterday;
- (BOOL)isThisYear;

/// 比某日早
- (BOOL)compareByTimestampIsEarlierThanDate:(NSDate *)anotherDate;

/// 比某日晚
- (BOOL)compareByTimestampIsLaterThanDate:(NSDate *)anotherDate;

/// 比某日早
- (BOOL)isEarlierThanDate:(NSDate *)anotherDate;

/// 比某日晚
- (BOOL)isLaterThanDate:(NSDate *)anotherDate;

/// 比今天早
- (BOOL)isEarlierThanToday;

/// 比今天晚
- (BOOL)isLaterThanToday;

/// 获取比两年后晚的日期，2017-08-15 ~ 2019-07-31
+ (NSDate *)getLastDayAfterTwentyThreeMonth;

/// 本周
- (BOOL)isThisWeek;
/// 下周
- (BOOL)isNextWeek;
/// 下周之前（更早）
- (BOOL)isEarlierThanNextWeek;
/// 上周
- (BOOL)isLastWeek;
/// 上周之后（更晚）
- (BOOL)isLaterThanLastWeek;
/// 上年
- (BOOL)isLastYear;

/// 是否 周X（周日:1 周六:7）
- (BOOL)isWeekday:(NSInteger)weekday;

/// 获取今天的 date
+ (NSDate *)today;

/// 获取这个月的第一天
- (NSDate *)firstDayOfCurrentMonth;

/// 获取上个月的第一天
- (NSDate *)firstDayOfLastMonth;

/// 获取下个月的第一天
- (NSDate *)firstDayOfNextMonth;

/// 获取这周的第一天
- (NSDate *)firstDayOfCurrentWeek;

/**
 *  按天比较
 */
- (NSComparisonResult)compareByDay:(NSDate *)date;

- (NSDate *)dateByAddingDays:(NSInteger)dDays;
- (NSDate *)dateByAddingHours:(NSInteger)hours;
- (NSDate *)dateBySubtractingDays:(NSInteger)dDays;
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)dDays;
+ (NSDate *)dateYesterday;

/**
 *  返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)dateAfterDay:(NSInteger)day;

/**
 *  month个月后的日期
 */
- (NSDate *)dateAfterMonth:(int)month;

/**
 *  year年后的日期
 */
- (NSDate *)dateAfterYear:(int)year;

/**
 *  year年、month个月、day天后的日期
 */
- (NSDate *)dateAfterYear:(int)year month:(int)month day:(int)day;

/**
 *  该月第一天
 */
- (NSDate *)beginningOfMonth;

/**
 *  该月的最后一天
 */
- (NSDate *)endOfMonth;

/**
 *  回到当日零点
 */
- (NSDate *)beginningOfDaytime;

/**
 *  拷贝其他日期的时分秒信息
 */
- (NSDate *)dateByCopyHourMinuteSecondFromDate:(NSDate*)date;

/**
 *  格式 跨年 2016年12月 非跨年 12月
 */
+ (NSString *)getYearOrMonthWithDate:(NSDate *)date;

/**
 *  格式 跨年 2016年12月3日 非跨年 12月3日
 */
+ (NSString *)getYearOrMonthDayWithDate:(NSDate *)date;

/**
 *  格式 跨年 2016年12月3日 13:33 非跨年 12月3日 13:33
 */
+ (NSString *)getYearOrMonthDayHourMinuteWithDate:(NSDate *)date;

/**
 *  格式 01月03日
 */
+ (NSString *)getMonthDayWithDate:(NSDate *)date;

/**
 *  格式 1月3日
 */
+ (NSString *)getMonthDayNoZeroWithDate:(NSDate *)date;

/**
 *  格式 2017年12月3日
 */
+ (NSString *)getYearMonthDayWithDate:(NSDate *)date;

#pragma mark - IM中使用的

- (NSString *)formattedTime;
- (NSString *)formattedTimeForChatRoomHistory;
+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

#pragma mark - 教学计划和阶段总结中使用的

+ (NSString *)getTimeDescriptionWithDate:(NSDate *)timeDate;

#pragma mark - 预约中使用

+ (NSString *)getStudentPoolInfoTimeDescriptionWithDate:(NSDate *)timeDate;


/**
 判断两个日期是否是同一天

 @param date another date
 @return BOOL,是否是同一天
 */
- (BOOL)isCurrentDay: (NSDate *)date;

+ (NSInteger)getTodaysTimestamp;
+ (NSInteger)getTimestampFromToday:(NSInteger)value;

/**
 返回时间戳，毫秒
 */
- (int64_t)dateLongLong;

#pragma mark - 6.5.0作业截止时间转换

+ (NSString*)convertDateToDeadLineString:(long long)deltaDay;
+ (NSString*)convertDateToDeadLineDayInReportPreviewString:(long long)deadlineTS;
+ (NSString*)convertDateToDeadLineInReportPreviewString:(long long)deltaDay;

+ (NSTimeInterval)compareTwoTimeGetSubTime:(NSDate *)firstDate secondTime:(NSDate *)secondDate;
+ (NSInteger)currentHours;
+ (NSInteger)currentMinute;
+ (NSDate *)getInternetDate;
+ (NSString *)getWeekDate:(NSDate *)timeDate;
@end
