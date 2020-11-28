//
//  CustomOperation.m
//  TestTemplateProject
//
//  Created by Ben on 2020/11/28.
//  Copyright © 2020 iOSStudio. All rights reserved.
//

#import "CustomOperation.h"

@interface CustomOperation ()

@property (nonatomic, strong) id data;//作为该操作的参数。

@end

@implementation CustomOperation

- (instancetype)initWithData:(id)data {
    if (self = [super init]) {
        self.data = data;
    }
    return self;
}

- (void)main {
    //只重写了这个方法的话，如果单独手动执行该自定义操作的话，操作时同步执行的，如果操作队列联合起来使用的话，也会并发执行操作。
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *order = (NSString *)self.data;
        NSLog(@"自定义操作:%@ thread: %@ isMainOperationQueue: %d isMainThread: %d", order, [NSThread currentThread], [NSOperationQueue.currentQueue isEqual:NSOperationQueue.mainQueue], [NSThread isMainThread]);
    });
}

@end


