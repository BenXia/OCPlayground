//
//  NSDateFormatter+ChiSymbols.m
//  QQing
//
//  Created by Ben on 5/15/14.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "NSDateFormatter+ChiSymbols.h"

@implementation NSDateFormatter (ChiSymbols)

- (NSArray *)chiSingleWeekdaySymbols {
    return [NSArray arrayWithObjects:@"一", @"二", @"三", @"四", @"五", @"六", @"日", nil];
}

- (NSArray *)chiZhouWeekdaySymbols {
    return [NSArray arrayWithObjects:@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日", nil];
}

- (NSArray *)chiXingQiWeekdaySymbols {
    return [NSArray arrayWithObjects:@"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", @"星期日", nil];
}

- (NSArray *)chiLiBaiWeekdaySymbols {
    return [NSArray arrayWithObjects:@"礼拜一", @"礼拜二", @"礼拜三", @"礼拜四", @"礼拜五", @"礼拜六", @"礼拜天", nil];
}

@end
