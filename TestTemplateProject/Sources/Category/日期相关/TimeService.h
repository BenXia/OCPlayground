//
//  TimeService.h
//  QQing
//
//  Created by Ben on 5/15/14.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNotificationServerTimerDidUpdated @"kNotificationServerTimerDidUpdated"
/*
 *  管理日期的单例组件
 *  获取服务器时间
 *  创建全局唯一的公历日历对象（NSCalendar性能优化）
 *  创建通用的时间格式，这里指仅仅设置了dateFormat字段的时间格式。特殊样式单独创建（NSDateFormatter性能优化）
 */
 
@interface TimeService : NSObject

BN_DEC_SINGLETON( TimeService )

// 创建公历的日历对象，避免多次创建
@property (strong,nonatomic) NSCalendar *gregorianCalendar;

// 创建通用的时间格式，避免多次创建
@property (strong,nonatomic) NSDateFormatter *commonDateFormatter;

@end
