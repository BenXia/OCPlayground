//
//  MultiThreadVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/9/26.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "MultiThreadVC.h"

@interface MultiThreadVC ()

@end

@implementation MultiThreadVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __strong typeof(self) self = weakSelf;
        [self testGCDSyncOperationExecuteThread];
    });
    
//    [self testGCDSyncOperationExecuteThread];
//
//    [self testGCDAsyncSerialOperationExecuteThread];
//
//    [self testGCDAsyncConcurrentOperationExecuteThread];
//
//    [self testMaxGCDConcurrentThreadCount];  // 1 + 65 (1为主线程）
    
//    [self testMaxGCDSerialThreadCount];   // 我的天，还有上限吗
    
//    [self testGCDConfigMaxConcurrentTreadCount];
    
//    [self testRecursiveSynchronized];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testGCDSyncOperationExecuteThread {
    NSLog(@"main thread = %@", [NSThread mainThread]);
    NSLog(@"current thread = %@", [NSThread currentThread]);
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.summer.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i < 100; i++) {
        dispatch_async(concurrentQueue, ^{
            NSLog(@"%d, for in dispatch_async concurrentQueue, current thread = %@", i, [NSThread currentThread]);
            sleep(1);
        });
    }
    
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"1,current thread = %@", [NSThread currentThread]);
    });
    
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"2,current thread = %@", [NSThread currentThread]);
        sleep(10);
    });
    
    NSLog(@">>>>>>>>>>>> Part One END");
    
    dispatch_queue_t serialQueue2 = dispatch_queue_create("com.summer.serial2", 0);

    for (int i = 0; i < 100; i++) {
        dispatch_async(serialQueue2, ^{
            NSLog(@"%d, for in dispatch_async serialQueue2, current thread = %@", i, [NSThread currentThread]);
            sleep(1);
        });
    }
    
    dispatch_async(serialQueue2, ^{
        NSLog(@"11,current thread = %@", [NSThread currentThread]);
    });

    dispatch_async(serialQueue2, ^{
        NSLog(@"12,current thread = %@", [NSThread currentThread]);
    });

    dispatch_sync(serialQueue2, ^{
        NSLog(@"13,current thread = %@", [NSThread currentThread]);
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(serialQueue2, ^{
            NSLog(@"14,current thread = %@", [NSThread currentThread]);
        });
    });
    
    NSLog(@">>>>>>>>>>>> Part Two END");
    
//    dispatch_release(serialQueue);
//    dispatch_release(serialQueue2);
}

- (void)testGCDAsyncSerialOperationExecuteThread {
    NSLog(@"main thread = %@", [NSThread mainThread]);
    
    // serialQueue1
    dispatch_queue_t serialQueue = dispatch_queue_create("com.summer.serial", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(serialQueue, ^{
        NSLog(@"1, dispatch_async serialQueue1, current thread = %@", [NSThread currentThread]);
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"2, dispatch_async serialQueue1, current thread = %@", [NSThread currentThread]);
    });
    
    // serialQueue2
    dispatch_queue_t serialQueue2 = dispatch_queue_create("com.summer.serial2", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(serialQueue2, ^{
        NSLog(@"11, dispatch_async serialQueue2, current thread = %@", [NSThread currentThread]);
    });
    
    dispatch_async(serialQueue2, ^{
        NSLog(@"22, dispatch_async serialQueue2, current thread = %@", [NSThread currentThread]);
    });
    
//    dispatch_release(serialQueue);
//    dispatch_release(serialQueue2);
}

- (void)testGCDAsyncConcurrentOperationExecuteThread {
    NSLog(@"main thread = %@", [NSThread mainThread]);
    
    // concurrentQueue1
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.summer.concurrent1", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"1, dispatch_async concurrentQueue1, current thread = %@", [NSThread currentThread]);
    });
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"2, dispatch_async concurrentQueue1, current thread = %@", [NSThread currentThread]);
    });
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"3, dispatch_async concurrentQueue1, current thread = %@", [NSThread currentThread]);
    });
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"4, dispatch_async concurrentQueue1, current thread = %@", [NSThread currentThread]);
    });
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"5, dispatch_async concurrentQueue1, current thread = %@", [NSThread currentThread]);
    });
    
    // concurrentQueue2
    dispatch_queue_t concurrentQueue2 = dispatch_queue_create("com.summer.concurrent2", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(concurrentQueue2, ^{
        NSLog(@"11, dispatch_async concurrentQueue2, current thread = %@", [NSThread currentThread]);
    });
    
    dispatch_async(concurrentQueue2, ^{
        NSLog(@"22, dispatch_async concurrentQueue2, current thread = %@", [NSThread currentThread]);
    });
    
    dispatch_async(concurrentQueue2, ^{
        NSLog(@"33, dispatch_async concurrentQueue2, current thread = %@", [NSThread currentThread]);
    });
    
//    dispatch_release(concurrentQueue);
//    dispatch_release(concurrentQueue2);
}

- (void)testMaxGCDConcurrentThreadCount {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.summer.concurrent1", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i < 2000; i++) {
        dispatch_async(concurrentQueue, ^{
            NSLog(@"%d, for in dispatch_async concurrentQueue1, current thread = %@", i, [NSThread currentThread]);
            sleep(3);
        });
    }
    
//    dispatch_release(concurrentQueue);
}

- (void)testMaxGCDSerialThreadCount {
    for (int i = 0; i < 2000; i++) {
        dispatch_queue_t serialQueue = dispatch_queue_create([NSString stringWithFormat:@"com.summer.serial_%d", i].UTF8String, 0);
        
        dispatch_async(serialQueue, ^{
            NSLog(@"11,current thread = %@", [NSThread currentThread]);
            sleep(10);
        });
    }
}

- (void)testGCDConfigMaxConcurrentTreadCount {
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 100; i++) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            NSLog(@"%i", i);
            sleep(5);
            dispatch_semaphore_signal(semaphore);
        });
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

- (void)testRecursiveSynchronized {
    @synchronized(self) {
        NSLog (@"outter synchronized(self)");
        @synchronized(self) {
            NSLog (@"inner synchronized(self)");
        }
    }
}

@end


