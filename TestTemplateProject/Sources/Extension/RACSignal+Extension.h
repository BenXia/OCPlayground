//
//  RACSignal+Extension.h
//  QQingCommon
//
//  Created by Ben on 2019/7/27.
//  Copyright © 2019 iOSStudio. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>
 
@interface RACSignal (Extension)

- (RACSignal *)onMainThread;

+ (RACSignal *)createSignalWithSignalsArray:(NSArray <RACSignal *> *)signalsArray
                   respectiveNextBlockArray:(NSArray *)signalNextBlockArray
                  respectiveErrorBlockArray:(NSArray *)signalErrorBlockArray
                            nextOnMainArray:(NSArray *)nextOnMainArray
                           errorOnMainArray:(NSArray *)errorOnMainArray;

+ (RACSignal *)createSignalWithSignalsArray:(NSArray <RACSignal *> *)signalsArray
                   respectiveNextBlockArray:(NSArray *)signalNextBlockArray
                  respectiveErrorBlockArray:(NSArray *)signalErrorBlockArray;

+ (RACSignal *)createSignalWithSignalsArray:(NSArray <RACSignal *> *)signalsArray
                   respectiveNextBlockArray:(NSArray *)signalNextBlockArray;

/**
 *  为信号源筛选最大输入数量
 *
 *  @param maxLength 最大数量
 *
 *  @return 返回一个原信号
 */
- (RACSignal *)setMaxLength:(NSInteger)maxLength;

@end


