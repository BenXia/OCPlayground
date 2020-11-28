//
//  MultiThreadVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/9/26.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "MultiThreadVC.h"
#import "CustomOperation.h"

@interface MultiThreadVC ()

//@property (atomic, assign) NSInteger intA;

@property (nonatomic, assign) NSInteger intA;
@property (nonatomic, strong) NSLock *lock;

@end

@implementation MultiThreadVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self testInvocationOperation];
    
//    [self testBlockOperation];
    
//    [self testBlockOperationAndMainOperationQueue];
    
    [self testCustomOperation];
    
//    [self testMainOperationQueue];
    
//    [self testCustomOperationQueue];
    
//    [self testOperationDependence];
    
//    [self testAtomicPropertyV1];
    
//    [self testAtomicPropertyV2];

//    __weak typeof(self) weakSelf = self;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        __strong typeof(self) self = weakSelf;
//        [self testGCDSyncOperationExecuteThread];
//    });
//
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

- (void)testInvocationOperation {
    [self executeInvocationOperationInCurrentThread];
    
    [self executeInvocationOperationInNewThread];
}

// 在当前线程中执行
- (void)executeInvocationOperationInCurrentThread {
    NSLog(@"创建操作:%@", [NSThread currentThread]);
//1：创建操作。
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task:) object:@"InvocationOperationJob"];
//2：开始执行操作。
    [op start];
}

// 在子线程中执行
- (void)executeInvocationOperationInNewThread {
    NSLog(@"创建操作:%@", [NSThread currentThread]);
    [NSThread detachNewThreadSelector:@selector(executeInvocationOperationInCurrentThread) toTarget:self withObject:nil];
}

- (void)testBlockOperation {
    [self executeBlockOperationInCurrentThread];
    
    [self executeBlockOperationInNewThread];
}

// 在当前线程中执行
- (void)executeBlockOperationInCurrentThread {
    NSLog(@"创建操作:%@", [NSThread currentThread]);
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [self task:@"BlockOperationJob"];
    }];
    // NSBlockOperation该操作有个方法能在该操作中持续添加操作任务addExecutionBlock，直到全部的block中的任务都执行完成后，该操作op才算执行完毕。当该操作在addExecutionBlock加入比较多的任务时，该op的block中的（包括blockOperationWithBlock和addExecutionBlock中的操作）会在新开的线程中执行。不一定在创建该op的线程中执行。（⚠️⚠️⚠️：即使这个 operaton 是在主线程start，也会出现其中某些 block 在非主线程运行，但是 [NSOperationQueue.currentQueue isEqual:NSOperationQueue.mainQueue]）
    [op addExecutionBlock:^{
        [self task:@"add"];
    }];
    [op addExecutionBlock:^{
        [self task:@"add"];
    }];
    [op addExecutionBlock:^{
        [self task:@"add"];
    }];
    [op addExecutionBlock:^{
        [self task:@"add"];
    }];
    [op addExecutionBlock:^{
        [self task:@"add"];
    }];
    [op addExecutionBlock:^{
        [self task:@"add"];
    }];
    [op addExecutionBlock:^{
        [self task:@"add"];
    }];
    [op addExecutionBlock:^{
        [self task:@"add"];
    }];
    [op start];
}

// 在子线程中执行
- (void)executeBlockOperationInNewThread {
    NSLog(@"创建操作:%@", [NSThread currentThread]);
    [NSThread detachNewThreadSelector:@selector(executeBlockOperationInCurrentThread) toTarget:self withObject:nil];
}

- (void)testBlockOperationAndMainOperationQueue {
    NSLog(@"任务创建:%@", [NSThread currentThread]);
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [self task:@"1"];
    }];

    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [self task:@"2"];
    }];

    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        [self task:@"3"];
    }];
 
    [mainQueue addOperation:op1];
    [mainQueue cancelAllOperations];
//    [op2 addDependency:op1];
    [mainQueue addOperation:op2];
    [mainQueue addOperation:op3];
    
    [op1 addExecutionBlock:^{
        [self task:@"1.1"];
    }];
    [op1 addExecutionBlock:^{
        [self task:@"1.1"];
    }];
    [op1 addExecutionBlock:^{
        [self task:@"1.1"];
    }];
    [op1 addExecutionBlock:^{
        [self task:@"1.1"];
    }];
    [op1 addExecutionBlock:^{
        [self task:@"1.1"];
    }];
    [op1 addExecutionBlock:^{
        [self task:@"1.1"];
    }];
    [op1 addExecutionBlock:^{
        [self task:@"1.1"];
    }];[op1 addExecutionBlock:^{
        [self task:@"1.1"];
    }];
    [op1 addExecutionBlock:^{
        [self task:@"1.1"];
    }];
    [op2 addExecutionBlock:^{
        [self task:@"2.1"];
    }];
    [op3 addExecutionBlock:^{
        [self task:@"3.1"];
    }];
    //将操作加入到主队列中后，根据操作添加到队列中的先后顺序(操作之间没有添加依赖关系)，串行执行。每个操作addExecutionBlock添加的任务和blockOperationWithBlock中的任务共同组成一个操作。两个block中的操作都执行结束后，一个操作才算结束。
    //虽然将操作加到了NSOperationQueue主操作队列，但是当操作中addExecutionBlock加的任务比较多的时候，操作block中的任务会在新的线程中并发执行，但是对于操作来说，操作时串行执行的。
}

- (void)testCustomOperation {
//    [self executeCustomOperationInCurrentThread];
//
//    [self executeCustomOperationInNewThread];
//
//    [self testCustomOperationAndMainQueue];
//
    [self testCustomOperationAndCustomQueue];
}

- (void)executeCustomOperationInCurrentThread {
    NSLog(@"创建操作:%@", [NSThread currentThread]);
    CustomOperation *op = [[CustomOperation alloc] initWithData:@"CustomOperationJob"];
    [op start];
}

- (void)executeCustomOperationInNewThread {
    NSLog(@"创建操作:%@", [NSThread currentThread]);
    [NSThread detachNewThreadSelector:@selector(executeCustomOperationInCurrentThread) toTarget:self withObject:nil];
}

- (void)testCustomOperationAndMainQueue {
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    CustomOperation *op1 = [[CustomOperation alloc] initWithData:@"1"];
    CustomOperation *op2 = [[CustomOperation alloc] initWithData:@"2"];
    CustomOperation *op3 = [[CustomOperation alloc] initWithData:@"3"];
    
    [mainQueue addOperation:op1];
    [mainQueue addOperation:op2];
    [mainQueue addOperation:op3];
}

- (void)testCustomOperationAndCustomQueue {
    NSOperationQueue *customQueue = [[NSOperationQueue alloc] init];
    CustomOperation *op1 = [[CustomOperation alloc] initWithData:@"1"];
    CustomOperation *op2 = [[CustomOperation alloc] initWithData:@"2"];
    CustomOperation *op3 = [[CustomOperation alloc] initWithData:@"3"];
    
    [customQueue addOperation:op1];
//    [op1 waitUntilFinished];//waitUntilFinished是阻塞当前线程的作用，在这里会阻塞主线程，阻塞主线程中继续往队列中加任务，直到该op1操作执行结束，这样就能实现操作的串行了。
//    [op1 cancel];
    [customQueue addOperation:op2];
//    [op2 waitUntilFinished];
    [customQueue addOperation:op3];
//    [op3 waitUntilFinished];
}

- (void)task:(NSString *)order {
    NSLog(@"任务:%@ thread: %@ isMainOperationQueue: %d isMainThread: %d", order, [NSThread currentThread], [NSOperationQueue.currentQueue isEqual:NSOperationQueue.mainQueue], [NSThread isMainThread]);
}

- (void)testMainOperationQueue {
    //获得主操作队列
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    NSLog(@"创建添加任务%@", [NSThread currentThread]);
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"1"];
    [mainQueue addOperation:op1];
    [mainQueue cancelAllOperations];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"2"];
    [mainQueue addOperation:op2];
    
    NSInvocationOperation *op3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"3"];
    [mainQueue addOperation:op3];
    
    [op3 cancel];//取消某个操作，可以直接调用操作的取消方法cancel。
    //取消整个操作队列的所有操作，这个方法好像没有效果？？？。在主队列中，没有用，如果将操作加入到自定义队列的话，在操作没有开始执行的时候，是能够取消操作的。
//    [mainQueue cancelAllOperations];
   
   NSInvocationOperation *op4 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"4"];
   [mainQueue addOperation:op4];
}

- (void)testCustomOperationQueue {
    NSLog(@"创建添加任务%@", [NSThread currentThread]);
    NSOperationQueue *customQueue = [[NSOperationQueue alloc] init];
     customQueue.maxConcurrentOperationCount = 5;//这个属性的设置需在队列中添加任务之前。任务添加到队列后，如果该任务没有依赖关系的话，任务添加到队列后，会直接开始执行。
    //加入到自定义队列里的任务，可以通过设置操作队列的 maxConcurrentOperationCount的值来控制操作的串行执行还是并发执行。
    
    //当maxConcurrentOperationCount = 1的时候，是串行执行。 maxConcurrentOperationCount > 1的时候是并发执行，但是这个线程开启的数量最终还是由系统决定的，不是maxConcurrentOperationCount设置为多少，就开多少条线程。默认情况下，自定义队列的maxConcurrentOperationCount值为-1，表示并发执行。
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"1"];
    [customQueue addOperation:op1];
  
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"2"];

    NSInvocationOperation *op3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"3"];
    
    NSInvocationOperation *op4 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"4"];
    
    //打断点在op1加入队列前后的状态值。
    ///<NSInvocationOperation 0x608000246cf0 isFinished=NO isReady=YES isCancelled=NO isExecuting=NO>
   
    ///<NSInvocationOperation 0x608000246cf0 isFinished=NO isReady=YES isCancelled=NO isExecuting=YES>
  
    [customQueue addOperation:op2];
    [customQueue cancelAllOperations];//这个方法只能取消还未开始执行的操作，如果操作已经开始执行，那么该方法依然取消不了。
    [customQueue addOperation:op3];
    [customQueue addOperation:op4];
}

//依赖关系的设置需要在任务添加到队列之前。
- (void)testOperationDependence {
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    NSLog(@"创建添加任务%@", [NSThread currentThread]);
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"1"];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"2"];
    NSInvocationOperation *op3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"3"];
    NSInvocationOperation *op4 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"4"];
    
    [op1 addDependency:op2];//由此更可以看出，如果添加了依赖关系，在主队列串行执行任务，也不是先进先出的规则。而是按照依赖关系的属性执行。  应该把操作的所有配置都配置好后，再加入队列，因为加入队列后，操作就开始执行了，再进行配置就晚了。
//    [op2 cancel];
    
    [mainQueue addOperation:op1];
    [mainQueue addOperation:op2];
    [mainQueue addOperation:op3];
    [mainQueue addOperation:op4];
}

- (void)testAtomicPropertyV1 {
    //开启一个线程对intA的值+1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0;i < 10000;i ++){
            self.intA = self.intA + 1;
        }
        NSLog(@"intA : %ld",(long)self.intA);
    });
    
    //开启一个线程对intA的值+1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0;i < 10000;i ++){
            self.intA = self.intA + 1;
        }
        NSLog(@"intA : %ld",(long)self.intA);
    });
}

- (void)testAtomicPropertyV2 {
   self.lock = [[NSLock alloc] init];
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       for (int i = 0; i < 10000; i ++) {
           [self.lock lock];
           self.intA = self.intA + 1;
           [self.lock unlock];
       }
       NSLog(@"intA : %ld",(long)self.intA);
   });

   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       for (int i = 0; i < 10000; i ++) {
           [self.lock lock];
           self.intA = self.intA + 1;
           [self.lock unlock];
       }
       NSLog(@"intA : %ld",(long)self.intA);
   });
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


