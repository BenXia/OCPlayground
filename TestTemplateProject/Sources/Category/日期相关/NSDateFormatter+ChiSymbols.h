//
//  NSDateFormatter+ChiSymbols.h
//  QQing
//
//  Created by Ben on 5/15/14.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

 
@interface NSDateFormatter (ChiSymbols)

/*
 * @return 一 二 三 四 五 六 日
 */
- (NSArray *)chiSingleWeekdaySymbols;

/*
 * @return 周一 周二 周三 周四 周五 周六 周日
 */
- (NSArray *)chiZhouWeekdaySymbols;

/*
 * @return 星期一 星期二 星期三 星期四 星期五  星期六 星期日
 */
- (NSArray *)chiXingQiWeekdaySymbols;

/*
 * @return 礼拜一 礼拜二 礼拜三 礼拜四 礼拜五 礼拜六 礼拜天
 */
- (NSArray *)chiLiBaiWeekdaySymbols;

@end
