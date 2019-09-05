//
//  TimeService.m
//  QQing
//
//  Created by Ben on 5/15/14.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "TimeService.h"

@interface TimeService()

@end

@implementation TimeService

BN_IMP_SINGLETON( TimeService )

- (NSCalendar *)gregorianCalendar {
    if (!_gregorianCalendar) {
        _gregorianCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _gregorianCalendar;
}

- (NSDateFormatter *)commonDateFormatter {
    if (!_commonDateFormatter) {
        _commonDateFormatter = [[NSDateFormatter alloc] init];
    }
    return _commonDateFormatter;
}

@end

