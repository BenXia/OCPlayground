//
//  MultiThreadVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/9/26.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "MultiThreadVC.h"
#import "CustomOperation.h"
#include <pthread.h>
#include <semaphore.h>

@interface MultiThreadVC ()

//@property (atomic, assign) NSInteger intA;

@property (nonatomic, assign) NSInteger intA;
@property (nonatomic, strong) NSLock *lock;

@property (nonatomic, strong) NSString *videoPath;

@end

@implementation MultiThreadVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self testInvocationOperation];
    
//    [self testBlockOperation];
    
//    [self testBlockOperationAndMainOperationQueue];
    
//    [self testCustomOperation];
    
//    [self testMainOperationQueue];
    
//    [self testCustomOperationQueue];
    
//    [self testOperationDependence];
    
//    [self testAtomicPropertyV1];
    
//    [self testAtomicPropertyV2];
    
//    [self testAtomicPropertyV3];

//    __weak typeof(self) weakSelf = self;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        __strong typeof(self) self = weakSelf;
//        [self testGCDSyncOperationExecuteThread];
//    });

//    [self testGCDSyncOperationExecuteThread];

//    [self testGCDAsyncSerialOperationExecuteThread];

//    [self testGCDAsyncConcurrentOperationExecuteThread];

//    // 8核断点看了下有90个左右concurrent_thread，不知道具体跟核心数是什么关系
//    [self testMaxGCDConcurrentThreadCount];
    
//    // 我的天，还有上限吗，8核断点看了下有500多个线程
//    // 使用太多线程会消耗大量内存
//    // 避免创建大量 gcd 的 serial queue。一旦生成 Serial Dispatch Queue 并追加处理，
//    // 系统对于一个 Serial Dispatch Queue 就只生成并使用一个线程。
//    [self testMaxGCDSerialThreadCount];
    
//    [self testGCDManuallyControlMaxConcurrentThreadCount];
    
//    [self testGCDSetTargetQueue];
    
//    [self testGCDDispatchGroup];
    
//    [self testGCDSomeAPI];
    
    // 经典的多读一写互斥问题
//    [self testGCDReadWriteHandle];

    // 多线程数据竞争问题（多个线程更新相同的资源会导致数据的不一致）
//    [self testMultiThreadSafe];

    // 多线程的死锁问题（停止等待事件的线程会导致多个线程相互持续等待）（dispatch_sync单线程也会死锁）
//    [self testMultiThreadDeadLock];
    
    [self testRecursiveSynchronized];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)task:(NSString *)order {
    NSLog(@"任务:%@ thread: %@ isMainOperationQueue: %d isMainThread: %d", order, [NSThread currentThread], [NSOperationQueue.currentQueue isEqual:NSOperationQueue.mainQueue], [NSThread isMainThread]);
}

// 知识点：NSInvocationOperation 会在 start 执行时的线程中调用
- (void)testInvocationOperation {
//    [self executeInvocationOperationInCurrentThread];
    
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

// 知识点：
// NSBlockOperation 如果只是单个 block 构造的操作，则和上面的 NSInvocationOperation 一样会在 start 执行时的线程中调用
//
// 但是NSBlockOperation该操作有个方法能在该操作中持续添加操作任务addExecutionBlock，
// 直到全部的block中的任务都执行完成后，该操作op才算执行完毕。当该操作在addExecutionBlock加入比较多的任务时，
// 该op的block中的（包括blockOperationWithBlock和addExecutionBlock中的操作）可能会在其他线程中执行。
// 不一定在创建该op的线程中执行。（⚠️⚠️⚠️：即使这个 operaton 是在主线程start，也会出现其中某些 block 在非主线程运行，
// 但是 [NSOperationQueue.currentQueue isEqual:NSOperationQueue.mainQueue]）
// 各个添加的 executionBlock 是并行的
- (void)testBlockOperation {
//    [self executeBlockOperationInCurrentThread];
    
    [self executeBlockOperationInNewThread];
}

// 在当前线程中执行
- (void)executeBlockOperationInCurrentThread {
    NSLog(@"创建操作:%@", [NSThread currentThread]);
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [self task:@"BlockOperationJob"];
    }];

    [op addExecutionBlock:^{
        [self task:@"add 1"];
    }];
    [op addExecutionBlock:^{
        [self task:@"add 2"];
    }];
    [op addExecutionBlock:^{
        [self task:@"add 3"];
    }];
    [op addExecutionBlock:^{
        [self task:@"add 4"];
    }];
    [op addExecutionBlock:^{
        [self task:@"add 5"];
    }];
    [op addExecutionBlock:^{
        [self task:@"add 6"];
    }];
    [op addExecutionBlock:^{
        [self task:@"add 7"];
    }];
    [op addExecutionBlock:^{
        [self task:@"add 8"];
    }];
    [op start];
}

// 在子线程中执行
- (void)executeBlockOperationInNewThread {
    NSLog(@"创建操作:%@", [NSThread currentThread]);
    [NSThread detachNewThreadSelector:@selector(executeBlockOperationInCurrentThread) toTarget:self withObject:nil];
}

// 知识点：
// 将操作加入到主队列中后，根据操作添加到队列中的先后顺序(操作之间没有添加依赖关系)，串行执行。
// 每个操作 blockOperationWithBlock 中的任务和 addExecutionBlock 添加的任务共同组成一个操作。
// 两种 block 中的操作都执行结束后，一个操作才算结束。
// 其中 blockOperationWithBlock 中的任务肯定在主线程执行，
// addExecutionBlock 添加的任务不一定在创建该op的线程中执行，而且是并行的。
// 但是 [NSOperationQueue.currentQueue isEqual:NSOperationQueue.mainQueue]）
// 主线程中第一个 addBlock：的任务一般当时就开始调度执行，来不及 cancel/cancelAllOperations

// 如果不是添加到主队列，而是添加到新建的 operationQueue
// 添加到队列中的操作并行执行。
// 其中 blockOperationWithBlock 中的任务和 addExecutionBlock 添加的任务可能会在其他线程中执行
// 第一个 addBlock: 后只要任务还未调度执行，来的及 cancel/cancelAllOperations
- (void)testBlockOperationAndMainOperationQueue {
    NSLog(@"任务创建:%@", [NSThread currentThread]);
    //NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    NSOperationQueue *mainQueue = [[NSOperationQueue alloc] init];
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
    // 如果是主队列，cancelAllOperations 无效，但是是自定义的 operationQueue，任务还未开始执行，可以 cancel
    [mainQueue cancelAllOperations];
//    [op2 addDependency:op1];
    [mainQueue addOperation:op2];
    [mainQueue addOperation:op3];
    
    [op1 addExecutionBlock:^{
        [self task:@"1.1"];
    }];
    [op1 addExecutionBlock:^{
        [self task:@"1.2"];
    }];
    [op1 addExecutionBlock:^{
        [self task:@"1.3"];
    }];
    [op1 addExecutionBlock:^{
        [self task:@"1.4"];
    }];
    [op1 addExecutionBlock:^{
        [self task:@"1.5"];
    }];
    [op1 addExecutionBlock:^{
        [self task:@"1.6"];
    }];
    [op1 addExecutionBlock:^{
        [self task:@"1.7"];
    }];
    [op1 addExecutionBlock:^{
        [self task:@"1.8"];
    }];
    [op1 addExecutionBlock:^{
        [self task:@"1.9"];
    }];
    [op2 addExecutionBlock:^{
        [self task:@"2.1"];
    }];
    [op3 addExecutionBlock:^{
        [self task:@"3.1"];
    }];
}

// 知识点：结论参照上述 NSInvocationOperation 和 NSBlockOperation
//        1.start 调用情况下，会在执行 start 的线程中调用
//        2.添加到主队列中执行，会在主线程串行执行，主线程中第一个 addBlock：的任务一般当时就开始调度执行，来不及 cancel/cancelAllOperations
//        3.添加到自定义队列中执行，会在后台线程并发执行，第一个 addBlock: 后只要任务还未调度执行，来的及 cancel/cancelAllOperations
- (void)testCustomOperation {
//    [self executeCustomOperationInCurrentThread];

//    [self executeCustomOperationInNewThread];

//    [self testCustomOperationAndMainQueue];

    [self testCustomOperationAndCustomQueue];
}

- (void)executeCustomOperationInCurrentThread {
    NSLog(@"创建操作:%@", [NSThread currentThread]);
    CustomOperation *op = [[CustomOperation alloc] initWithData:@"CustomOperationJob"];
    [op start];
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"测试主线程sync操作: thread: %@ isMainOperationQueue: %d isMainThread: %d", [NSThread currentThread], [NSOperationQueue.currentQueue isEqual:NSOperationQueue.mainQueue], [NSThread isMainThread]);
    });
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
    [op1 cancel];
    [customQueue addOperation:op2];
//    [op2 waitUntilFinished];
    [customQueue addOperation:op3];
//    [op3 waitUntilFinished];
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
    
    //取消某个操作，可以直接调用操作的取消方法cancel。
    [op3 cancel];
    //取消整个操作队列的所有操作，这个方法主队列没有效果。
    //如果将操作加入到自定义队列的话，在操作没有开始执行的时候，是能够取消操作的。
//    [mainQueue cancelAllOperations];
   
   NSInvocationOperation *op4 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"4"];
   [mainQueue addOperation:op4];
}

- (void)testCustomOperationQueue {
    NSLog(@"创建添加任务%@", [NSThread currentThread]);
    NSOperationQueue *customQueue = [[NSOperationQueue alloc] init];
    //这个属性的设置需在队列中添加任务之前。任务添加到队列后，如果该任务没有依赖关系的话，任务添加到队列后，会直接开始执行。
    customQueue.maxConcurrentOperationCount = 5;
    //加入到自定义队列里的任务，可以通过设置操作队列的 maxConcurrentOperationCount 的值来控制操作的串行执行还是并发执行。
    
    //当maxConcurrentOperationCount = 1的时候，是串行执行。 maxConcurrentOperationCount > 1的时候是并发执行，但是这个线程开启的数量最终还是由系统决定的，不是maxConcurrentOperationCount设置为多少，就开多少条线程。默认情况下，自定义队列的maxConcurrentOperationCount值为-1，表示并发执行。
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"1"];
    //[customQueue addOperation:op1];
  
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"2"];
    
//    [customQueue addOperation:op1];

    NSInvocationOperation *op3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"3"];
    
    [customQueue addOperation:op1];
    
    NSInvocationOperation *op4 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"4"];
    
    //打断点在op1加入队列前后的状态值。
    ///<NSInvocationOperation 0x608000246cf0 isFinished=NO isReady=YES isCancelled=NO isExecuting=NO>
   
    ///<NSInvocationOperation 0x608000246cf0 isFinished=NO isReady=YES isCancelled=NO isExecuting=YES>
  
    [customQueue addOperation:op2];
    
    //这个方法只能取消还未开始执行的操作，如果操作已经开始执行，那么该方法依然取消不了。
    //（所以上面 op1、op2 有没有被 cancel 掉，需要根据是否已经被开始调度执行情况而定）
    [customQueue cancelAllOperations];
    
    [customQueue addOperation:op3];
    [customQueue addOperation:op4];
}

// 知识点：依赖关系的设置需要在任务添加到队列之前
//        mainQueue 或者 maxConcurrentOperationCount为1的 operationQueue 可能会因为设置依赖，
//        导致执行顺序和添加到队列中的顺序不一致
- (void)testOperationDependence {
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    NSLog(@"创建添加任务%@", [NSThread currentThread]);
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"1"];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"2"];
    NSInvocationOperation *op3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"3"];
    NSInvocationOperation *op4 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"4"];
    
    // 由此更可以看出，如果添加了依赖关系，在主队列串行执行任务，也不是先进先出的规则。
    // 而是按照依赖关系的属性执行。
    // 应该把操作的所有配置都配置好后，再加入队列，因为加入队列后，操作就开始执行了，再进行配置就晚了。
    [op1 addDependency:op2];
//    [op2 cancel];
    
    [mainQueue addOperation:op1];
    [mainQueue addOperation:op2];
    [mainQueue addOperation:op3];
    [mainQueue addOperation:op4];
}

- (void)testAtomicPropertyV1 {
    //开启一个线程对intA的值+1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 100000; i++) {
            self.intA = self.intA + 1;
        }
        NSLog(@"intA : %ld", (long)self.intA);
    });
    
    //开启一个线程对intA的值+1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 100000; i++) {
            self.intA = self.intA + 1;
        }
        NSLog(@"intA : %ld", (long)self.intA);
    });
}

// 知识点：多线程操作 self.intA = self.intA + 1; 即使属性是 atomic 也不能保证多线程安全，
//       即读又写，需要锁来保证一段原子操作区域。
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

// 知识点：多线程操作 self.videoPath = [NSString stringXXX...]; 
//       如果属性不是 atomic 可能会导致同一个旧值被多个线程连续的 release，引起 crash
- (void)testAtomicPropertyV3 {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 1000; i++) {
        dispatch_async(queue, ^{
            self.videoPath = [NSString stringWithFormat:@"abcdefghij"];  // 不是 TaggedPointerString
        });
    }
    
    /**
     我们异步并发执行setter方法，可能就会有多条线程同时执行[_name release]，连续release两次就会造成对象的过度释放，导致Crash。

     解决办法：

     1.使用atomic属性关键字修饰 videoPath property
     2.在不同线程中操作 self.videoPath = xxx; 前后加锁解锁
     */
}

- (void)testGCDSyncOperationExecuteThread {
    NSLog(@"main thread = %@", [NSThread mainThread]);
    NSLog(@"current thread = %@", [NSThread currentThread]);
    
    // 1.测试并行队列
//    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.summer.concurrent", DISPATCH_QUEUE_CONCURRENT);
//
//    for (int i = 0; i < 100; i++) {
//        dispatch_async(concurrentQueue, ^{
//            NSLog(@"%d, for in dispatch_async concurrentQueue, current thread = %@", i, [NSThread currentThread]);
//            sleep(1);
//        });
//    }
//
//    dispatch_sync(concurrentQueue, ^{
//        NSLog(@"1,current thread = %@", [NSThread currentThread]);
//    });
//
//    dispatch_sync(concurrentQueue, ^{
//        NSLog(@"2,current thread = %@", [NSThread currentThread]);
//        sleep(10);
//    });
    
     
    // 2.测试串行队列
//    dispatch_queue_t serialQueue2 = dispatch_queue_create("com.summer.serial2", 0);
//
//    for (int i = 0; i < 10; i++) {
//        dispatch_async(serialQueue2, ^{
//            NSLog(@"%d, for in dispatch_async serialQueue2, current thread = %@", i, [NSThread currentThread]);
//            sleep(1);
//        });
//    }
//
//    dispatch_async(serialQueue2, ^{
//        NSLog(@"11,current thread = %@", [NSThread currentThread]);
//    });
//
//    dispatch_async(serialQueue2, ^{
//        NSLog(@"12,current thread = %@", [NSThread currentThread]);
//    });
//
//    dispatch_sync(serialQueue2, ^{
//        NSLog(@"13,current thread = %@", [NSThread currentThread]);
//    });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(13 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        dispatch_async(serialQueue2, ^{
//            NSLog(@"14,current thread = %@", [NSThread currentThread]);
//        });
//    });
    
    
    
    // 3. 测试各种情况下的 dispatch_sync 所派发的 block 的执行线程
    // 参考https://www.cnblogs.com/FightingLuoYin/p/4519801.html
    // 在主线程 dispatch_sync 所派发的 block 的执行线程和 dispatch_sync 上下文线程是同一个线程（但是不能在主线程 dispatch_sync(dispatch_get_main_queue(), ^{...}), 否则会死锁）
    // 在后台线程dispatch_sync所派发的block的执行线程和dispatch_sync上下文线程是同一个线程（但是如果在后台线程 dispatch_sync(dispatch_get_main_queue(), ^{...}), 则 block 的执行线程是主线程）
    // 总结规律：在大部分情况下（派发到自定义serialQueue、系统globalQueue、自定义concurrentQueue时）dispatch_sync 所派发的 block 的执行线程和 dispatch_sync 上下文线程是同一个线程，只在派发到 dispatch_get_main_queue() 时情况有特殊，根据当前是主线程/非主线程，分别是死锁和 block 在主线程执行
    
    // 衍生知识点：因为 dispatch_sync 上述大部分情况下避免多线程切换的优化
    //           派发到自定义 serialQueue 不一定都在某一个线程中执行
    //           派发到系统 globalQueue、自定义 concurrentQueue 也不一定都在后台线程中执行
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        NSLog(@"测试当前线程sync到后台线程操作: thread: %@ isMainOperationQueue: %d isMainThread: %d", [NSThread currentThread], [NSOperationQueue.currentQueue isEqual:NSOperationQueue.mainQueue], [NSThread isMainThread]);
//    });
    
//    dispatch_queue_t serialQueue = dispatch_queue_create("com.summer.serial3", 0);
//    dispatch_sync(serialQueue, ^{
//        NSLog(@"测试当前线程sync到后台线程操作: thread: %@ isMainOperationQueue: %d isMainThread: %d", [NSThread currentThread], [NSOperationQueue.currentQueue isEqual:NSOperationQueue.mainQueue], [NSThread isMainThread]);
//    });
        
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"测试当前线程sync到主线程操作: thread: %@ isMainOperationQueue: %d isMainThread: %d", [NSThread currentThread], [NSOperationQueue.currentQueue isEqual:NSOperationQueue.mainQueue], [NSThread isMainThread]);
//    });
//
//    dispatch_sync(dispatch_queue_create("I.am.a.serial.dispatch.queue", DISPATCH_QUEUE_SERIAL), ^{
//        dispatch_queue_t aConcurrentDispatchQueue = dispatch_queue_create("he", DISPATCH_QUEUE_CONCURRENT);
//        __block long sum = 0;
//        for (int i = 0; i < 10000; ++i) {
//            dispatch_async(aConcurrentDispatchQueue, ^{
//                // 不是多线程安全的代码
//                sum += 1;
//            });
//        }
//        dispatch_sync(aConcurrentDispatchQueue, ^{
//            NSLog(@"sum: %d\n", sum);
//            NSLog(@"current thread 2: %@", [NSThread currentThread]);
//        });
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"sum: %ld\n", sum);
//        });
//        NSLog(@"current thread 2: %@", [NSThread currentThread]);
//    });
    
//    dispatch_sync(dispatch_queue_create("I.am.a.concurrent.dispatch.queue", DISPATCH_QUEUE_CONCURRENT), ^{
//        dispatch_queue_t aSerialDispatchQueue = dispatch_queue_create("ha", DISPATCH_QUEUE_SERIAL);
//        __block long sum = 0;
//        for (int i = 0; i < 10000; ++i) {
//            dispatch_sync(aSerialDispatchQueue, ^{
//                sum += 1;
//            });
//        }
//        
//        dispatch_sync(aSerialDispatchQueue, ^{
//            NSLog(@"sum: %ld\n", sum);
//            NSLog(@"current thread 3: %@", [NSThread currentThread]);
//        });
//        
//        NSLog(@"current thread 3: %@", [NSThread currentThread]);
//    });
    
    
    // 4.避免 dispatch_sync 在某个 serialQueue 中任务调用 dispatch_sync(serialQueue, ***) 引起死锁
    // 知识点：
    // 可以想象 serialQueue 在底层实现中有一把“锁”，这把锁确保 serialQueue 中只有一个 block 被执行
    // 当执行到 block1 代码时，这把锁为 block1 所持有，当 block1 执行完了，会释放之；
    // 然而 block1 同步派发了一个任务 block2，同步派发意味着 block1 会被阻塞，直到 block2 被执行完成；
    // 但是这里产生了矛盾，block2 顺利执行的前提是 serialQueue 的这把“锁”被 block1 释放，
    // 但是 block1 释放这把“锁”的前提是 block1 执行完成，而 block1 执行完的前提是 block2 执行完成；
    // 所以造成的局面是“block2 等待 block1 执行完成置放‘锁’”，同时“block1 等待 block2 执行完成”，这就是典型的 deadlock。

//    dispatch_queue_t serialQueue = dispatch_queue_create("com.summer.serial4", 0);
//    dispatch_async(serialQueue, ^{
//        NSLog(@"1");
//
//        dispatch_sync(serialQueue, ^{
//            NSLog(@"2");
//        });
//    });
//    NSLog(@"3");
//    
//    // 当前线程是主线的话这里的 serialQueue 恰好是 main queue。
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"will deadlock when outside thread is mainthread");
//    });
    
    // 4. 测试 dispatch_sync + 自定义serialQueue，也可以起到线程安全的作用
    // 知识点：
    // 即使是 dispatch_sync(自定义serialQueue, ^{...}); 在调用时会优化成 block 在当前线程执行，避免线程切换，导致在不同线程中执行 block
    // 但是依然会保证所有 dispatch_sync 到该 serialQueue 的 block 会串行执行，保证线程安全
    // 可以想象 serialQueue 在底层实现中有一把“锁”，这把锁确保 serialQueue 中只有一个 block 被执行
    // 当执行到 block1 代码时，这把锁为 block1 所持有，当 block1 执行完了，会释放之。
//    dispatch_queue_t serialQueue = dispatch_queue_create("com.summer.serial3", 0);
//    __block long sum = 0;
//    for (int i = 0; i < 10000; i++) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            dispatch_sync(serialQueue, ^{
//                NSLog(@"sum add task 1: %d\n", i);
//                sum += 1;
//            });
//        });
//    }
//
//    for (int i = 0; i < 10000; i++) {
//        // 下面的是串行的
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            dispatch_sync(serialQueue, ^{
//                NSLog(@"sum add task 2: %d\n", i);
//                sum += 1;
//            });
//        });
//    }
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"sum: %ld", sum);
//    });
    

//    __block long sum2 = 0;
//    for (int i = 0; i < 10000; i++) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"sum2 add task 1: %d\n", i);
//            sum2 += 1;
//        });
//    }
//
//    for (int i = 0; i < 10000; i++) {
//        // 下面的是并发的
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            NSLog(@"sum2 add task 2: %d\n", i);
//            sum2 += 1;
//        });
//    }
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"sum2: %ld", sum2);
//    });
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

// 知识点：可以通过资源信号量控制并发队列会并发的任务数量上限，避免使用过多的 concurrent_thread
- (void)testGCDManuallyControlMaxConcurrentThreadCount {
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

// 知识点：
//     默认 dispatch_queue_create 函数生成的 Dispatch Queue 不管是 Serial Dispatch Queue 还是 Concurrent Dispatch Queue,
//     都使用与默认优先级 Global Dispatch Queue 相同执行优先级的线程。
//     而变更生成的 Dispatch Queue 的执行优先级要使用 dispatc_set_target_queue 函数。
- (void)testGCDSetTargetQueue {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.summer.customSerialQueue", NULL);
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.summer.customConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);

    // 下面的并发队列任务会串行执行
//    dispatch_set_target_queue(concurrentQueue, serialQueue);
//
//    for (int i = 0; i < 1000; i++) {
//        dispatch_async(concurrentQueue, ^{
//            NSLog(@"%d, for in dispatch_async concurrentQueue, current thread = %@", i, [NSThread currentThread]);
//            sleep(3);
//        });
//    }
    
    // 下面的还是串行的，只是优先级发生了变化
//    dispatch_set_target_queue(serialQueue, concurrentQueue);
//
//    for (int i = 0; i < 1000; i++) {
//        dispatch_async(serialQueue, ^{
//            NSLog(@"%d, for in dispatch_async concurrentQueue, current thread = %@", i, [NSThread currentThread]);
//            sleep(3);
//        });
//    }
    
    // concurrentQueue 的 target queue 设置为主线程，则该 concurrentQueue 中还未执行的 block 也会在主线程执行
    dispatch_set_target_queue(concurrentQueue, dispatch_get_main_queue());

    for (int i = 0; i < 1000; i++) {
        dispatch_async(concurrentQueue, ^{
            NSLog(@"%d, for in dispatch_async concurrentQueue, current thread = %@", i, [NSThread currentThread]);
            sleep(3);
        });
    }
    
    // serial queue 的 target queue 设置为主线程，则该 serial queue 中还未执行的 block 也会在主线程执行
//    dispatch_set_target_queue(serialQueue, dispatch_get_main_queue());
//
//    for (int i = 0; i < 1000; i++) {
//        dispatch_async(serialQueue, ^{
//            NSLog(@"%d, for in dispatch_async concurrentQueue, current thread = %@", i, [NSThread currentThread]);
//            sleep(3);
//        });
//    }
}

- (void)testGCDDispatchGroup {
    // 在追加到 Dispatch Queue 中的多个处理全部结束后想执行结束处理
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, globalQueue, ^{
        NSLog(@"blk0");
    });
    dispatch_group_async(group, globalQueue, ^{
        NSLog(@"blk1");
    });
    dispatch_group_async(group, globalQueue, ^{
        NSLog(@"blk2");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"done");
    });
    
    // 上面这个 dispatch_group_notify 也可以换成下面的 dispatch_group_wait，仅等待全部处理执行结束
    //dispatch_group_wait(group, DISPATCH_TIME_FOREVER); // 一直等待
    //dispatch_group_wait(group, DISPATCH_TIME_NOW);  // 不等待，直接判断属于 group 的处理是否执行结束
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
    long result = dispatch_group_wait(group, time);
    if (result == 0) {
        NSLog(@"All finished");
    } else {
        NSLog(@"Not all finished");
    }
    
//    dispatch_release(group);
}

dispatch_time_t getDispatchTimeByDate(NSDate *date)
{
    NSTimeInterval interval;
    double second, subsecond;
    struct timespec time;
    dispatch_time_t milestone;
    
    interval = [date timeIntervalSince1970];
    subsecond = modf(interval, &second);
    time.tv_sec = second;
    time.tv_sec = subsecond * NSEC_PER_SEC;
    milestone = dispatch_walltime(&time, 0);
    
    return milestone;
}

- (void)testGCDSomeAPI {
    //dispatch_apply
    //dispatch_apply 函数是 dispatch_sync 函数和 Dispatch Group 的关联 API。
    //该函数按指定的次数将指定的 Block 追加到指定 Dispatch Queue 中，并等待全部处理执行结束。
    //另外，由于 dispatch_apply 函数也与 dispatch_sync 函数相同会等待处理执行结束，因此推荐在 dispatch_async 函数中非同步地执行 dispath_apply 函数。
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_apply(10, queue, ^(size_t index){
//        NSLog(@"%zu", index);
//    });
//    NSLog(@"done");

//    dispatch_async(queue, ^{
//        dispatch_apply(10, queue, ^(size_t index){
//            NSLog(@"%zu", index);
//        });
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"done");
//        });
//    });

//    NSArray *array = @[@"000", @"111", @"222", @"333", @"444", @"555", @"666", @"777", @"888", @"999"];
//    dispatch_apply(array.count, queue, ^(size_t index) {
//        NSLog(@"%zu: %@", index, [array objectAtIndex:index]);
//    });
    
    
    
    // dispatch_suspend / dispatch_resume
    // 注意，对于系统的 global queue 没有作用
//    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.summer.customConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
//    for (int i = 0; i < 10; i++) {
//        dispatch_async(concurrentQueue, ^{
//            NSLog(@"%d", i);
//        });
//    }
//
//    dispatch_suspend(concurrentQueue);
//
//    for (int i = 100; i < 110; i++) {
//        dispatch_async(concurrentQueue, ^{
//            NSLog(@"%d", i);
//        });
//    }
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        dispatch_resume(concurrentQueue);
//    });
    
    
    
    // dispatch_source
    // DISPATCH_SOURCE_TYPE_DATA_ADD   变量增加
    // DISPATCH_SOURCE_TYPE_DATA_OR    变量 OR
    // DISPATCH_SOURCE_TYPE_MACH_SEND  MACH 端口发送
    // DISPATCH_SOURCE_TYPE_MACH_RECV  MACH 端口接收
    // DISPATCH_SOURCE_TYPE_PROC       监测到与进程相关的事件
    // DISPATCH_SOURCE_TYPE_READ       可读取文件映像
    // DISPATCH_SOURCE_TYPE_SIGNAL     接收信号
    // DISPATCH_SOURCE_TYPE_TIMER      定时器
    // DISPATCH_SOURCE_TYPE_VNODE      文件系统有变更
    // DISPATCH_SOURCE_TYPE_WRITE      可写入文件映像
    
    // 在定时器经过指定时间时设定 Main Dispatch Queue 为追加处理的 Dispatch Queue
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    // 将定时器设定为 15 秒后。不指定为重复。允许延迟1秒。
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, 15ull * NSEC_PER_SEC), DISPATCH_TIME_FOREVER, 1ull * NSEC_PER_SEC);

    // 指定定时器指定时间内执行的处理
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"wakeup!");

        // 取消 Dispatch Source
        dispatch_source_cancel(timer);
    });

    // 指定取消 Dispatch Source 时的处理
    dispatch_source_set_cancel_handler(timer, ^{
        NSLog(@"canceled");

        // 释放 Dispatch Source
//        dispatch_release(timer);
    });

    // 启动 Dispatch Source
    dispatch_resume(timer);
}

// 知识点：多线程多读单写的问题可以用以下方法解决
//        concurrentQueue + dispatch_async + dispatch_barrier_async
//        pthread_rwlock_t
//        两个互斥锁 pthread_mutex_t（操作系统书中有介绍）
//        连个互斥锁 sem_t （操作系统书中有介绍）
//        使用条件变量+互斥锁来实现。注意：条件变量必须和互斥锁一起使用，等待、释放的时候需要加锁。
- (void)testGCDReadWriteHandle {
//    [self testGCDAsyncBarrierHandle];
    
//    [self testGCDSetTargetQueueAndDispatchGroupHandle];
    
    // 下面两种实现方式与 gcd 无关
//    [self testPthreadReadWriteLock];
    
//    [self testPthreadMutex];
    
//    [self testPthreadSem];
    
    [self testPthreadMutexAndCondition];
}

- (void)testGCDAsyncBarrierHandle {
    // ⚠️：dispatch_barrier_async 对于系统的 global queue 没有用
//    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.summer.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"Read 1");
        sleep(3);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"Read 2");
        sleep(3);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"Read 3");
        sleep(3);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"Read 4");
        sleep(3);
    });
    
    dispatch_barrier_async(concurrentQueue, ^{
        NSLog(@"Write 1");
        sleep(3);
    });
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"Read 5");
        sleep(3);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"Read 6");
        sleep(3);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"Read 7");
        sleep(3);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"Read 8");
        sleep(3);
    });
}

- (void)testGCDSetTargetQueueAndDispatchGroupHandle {
    // Objective-C 高级编程中提到利用 Dispatch Group 和 dispatch_set_target_queue 函数可以实现，但是我不太知道怎么实现
}

- (void)testPthreadReadWriteLock {
    // 直接使用 pthread 中提供的读写锁
    pthread_rwlock_t rwlock = PTHREAD_RWLOCK_INITIALIZER;
    
    pthread_rwlock_rdlock(&rwlock);
    NSLog(@"读：1");
    pthread_rwlock_unlock(&rwlock);
    pthread_rwlock_rdlock(&rwlock);
    NSLog(@"读：2");
    pthread_rwlock_unlock(&rwlock);
    pthread_rwlock_rdlock(&rwlock);
    NSLog(@"读：3");
    pthread_rwlock_unlock(&rwlock);
    pthread_rwlock_rdlock(&rwlock);
    NSLog(@"读：4");
    pthread_rwlock_unlock(&rwlock);
    
    pthread_rwlock_wrlock(&rwlock);
    NSLog(@"写：1");
    pthread_rwlock_unlock(&rwlock);
    
    pthread_rwlock_rdlock(&rwlock);
    NSLog(@"读：5");
    pthread_rwlock_unlock(&rwlock);
    pthread_rwlock_rdlock(&rwlock);
    NSLog(@"读：6");
    pthread_rwlock_unlock(&rwlock);
    pthread_rwlock_rdlock(&rwlock);
    NSLog(@"读：7");
    pthread_rwlock_unlock(&rwlock);
    pthread_rwlock_rdlock(&rwlock);
    NSLog(@"读：8");
    pthread_rwlock_unlock(&rwlock);
}

- (void)testPthreadMutex {
    pthread_mutex_t r_mutex = PTHREAD_MUTEX_INITIALIZER;
    pthread_mutex_t w_mutex = PTHREAD_MUTEX_INITIALIZER;
    int readers = 0;  // 记录读者的个数
    
    // 读
    pthread_mutex_lock(&r_mutex);
    if (readers == 0) {
        pthread_mutex_lock(&w_mutex);
    }
    readers++;
    pthread_mutex_unlock(&r_mutex);
    NSLog(@"读：1");
    pthread_mutex_lock(&r_mutex);
    readers--;
    if (readers == 0) {
        pthread_mutex_unlock(&w_mutex);
    }
    pthread_mutex_unlock(&r_mutex);
    
    pthread_mutex_lock(&r_mutex);
    if (readers == 0) {
        pthread_mutex_lock(&w_mutex);
    }
    readers++;
    pthread_mutex_unlock(&r_mutex);
    NSLog(@"读：2");
    pthread_mutex_lock(&r_mutex);
    readers--;
    if (readers == 0) {
        pthread_mutex_unlock(&w_mutex);
    }
    pthread_mutex_unlock(&r_mutex);
    
    pthread_mutex_lock(&r_mutex);
    if (readers == 0) {
        pthread_mutex_lock(&w_mutex);
    }
    readers++;
    pthread_mutex_unlock(&r_mutex);
    NSLog(@"读：3");
    pthread_mutex_lock(&r_mutex);
    readers--;
    if (readers == 0) {
        pthread_mutex_unlock(&w_mutex);
    }
    pthread_mutex_unlock(&r_mutex);
    
    pthread_mutex_lock(&r_mutex);
    if (readers == 0) {
        pthread_mutex_lock(&w_mutex);
    }
    readers++;
    pthread_mutex_unlock(&r_mutex);
    NSLog(@"读：4");
    pthread_mutex_lock(&r_mutex);
    readers--;
    if (readers == 0) {
        pthread_mutex_unlock(&w_mutex);
    }
    pthread_mutex_unlock(&r_mutex);
    
    // 写
    pthread_mutex_lock(&w_mutex);
    NSLog(@"写：1");
    pthread_mutex_unlock(&w_mutex);
    
    // 读
    pthread_mutex_lock(&r_mutex);
    if (readers == 0) {
        pthread_mutex_lock(&w_mutex);
    }
    readers++;
    pthread_mutex_unlock(&r_mutex);
    NSLog(@"读：5");
    pthread_mutex_lock(&r_mutex);
    readers--;
    if (readers == 0) {
        pthread_mutex_unlock(&w_mutex);
    }
    pthread_mutex_unlock(&r_mutex);
    
    pthread_mutex_lock(&r_mutex);
    if (readers == 0) {
        pthread_mutex_lock(&w_mutex);
    }
    readers++;
    pthread_mutex_unlock(&r_mutex);
    NSLog(@"读：6");
    pthread_mutex_lock(&r_mutex);
    readers--;
    if (readers == 0) {
        pthread_mutex_unlock(&w_mutex);
    }
    pthread_mutex_unlock(&r_mutex);
    
    pthread_mutex_lock(&r_mutex);
    if (readers == 0) {
        pthread_mutex_lock(&w_mutex);
    }
    readers++;
    pthread_mutex_unlock(&r_mutex);
    NSLog(@"读：7");
    pthread_mutex_lock(&r_mutex);
    readers--;
    if (readers == 0) {
        pthread_mutex_unlock(&w_mutex);
    }
    pthread_mutex_unlock(&r_mutex);
    
    pthread_mutex_lock(&r_mutex);
    if (readers == 0) {
        pthread_mutex_lock(&w_mutex);
    }
    readers++;
    pthread_mutex_unlock(&r_mutex);
    NSLog(@"读：8");
    pthread_mutex_lock(&r_mutex);
    readers--;
    if (readers == 0) {
        pthread_mutex_unlock(&w_mutex);
    }
    pthread_mutex_unlock(&r_mutex);
}

- (void)testPthreadSem {
    // 这里使用2个信号量+1个整型变量来实现。令信号量的初始值为1，那么信号量的作用就和互斥量等价了
    sem_t r_sem;
    sem_init(&r_sem, 0, 1);
    
    sem_t w_sem;
    sem_init(&w_sem, 0, 1);
    
    int readers = 0;
    
    // 读
    sem_wait(&r_sem);
    if (readers == 0) {
        sem_wait(&w_sem);
    }
    readers++;
    sem_post(&r_sem);
    NSLog(@"读：1");
    sem_wait(&r_sem);
    readers--;
    if (readers == 0) {
        sem_post(&w_sem);
    }
    sem_post(&r_sem);
    
    sem_wait(&r_sem);
    if (readers == 0) {
        sem_wait(&w_sem);
    }
    readers++;
    sem_post(&r_sem);
    NSLog(@"读：2");
    sem_wait(&r_sem);
    readers--;
    if (readers == 0) {
        sem_post(&w_sem);
    }
    sem_post(&r_sem);
    
    sem_wait(&r_sem);
    if (readers == 0) {
        sem_wait(&w_sem);
    }
    readers++;
    sem_post(&r_sem);
    NSLog(@"读：3");
    sem_wait(&r_sem);
    readers--;
    if (readers == 0) {
        sem_post(&w_sem);
    }
    sem_post(&r_sem);
    
    sem_wait(&r_sem);
    if (readers == 0) {
        sem_wait(&w_sem);
    }
    readers++;
    sem_post(&r_sem);
    NSLog(@"读：4");
    sem_wait(&r_sem);
    readers--;
    if (readers == 0) {
        sem_post(&w_sem);
    }
    sem_post(&r_sem);
    
    // 写
    sem_wait(&w_sem);
    NSLog(@"写：1");
    sem_post(&w_sem);
    
    // 读
    sem_wait(&r_sem);
    if (readers == 0) {
        sem_wait(&w_sem);
    }
    readers++;
    sem_post(&r_sem);
    NSLog(@"读：5");
    sem_wait(&r_sem);
    readers--;
    if (readers == 0) {
        sem_post(&w_sem);
    }
    sem_post(&r_sem);
    
    sem_wait(&r_sem);
    if (readers == 0) {
        sem_wait(&w_sem);
    }
    readers++;
    sem_post(&r_sem);
    NSLog(@"读：6");
    sem_wait(&r_sem);
    readers--;
    if (readers == 0) {
        sem_post(&w_sem);
    }
    sem_post(&r_sem);
    
    sem_wait(&r_sem);
    if (readers == 0) {
        sem_wait(&w_sem);
    }
    readers++;
    sem_post(&r_sem);
    NSLog(@"读：7");
    sem_wait(&r_sem);
    readers--;
    if (readers == 0) {
        sem_post(&w_sem);
    }
    sem_post(&r_sem);
    
    sem_wait(&r_sem);
    if (readers == 0) {
        sem_wait(&w_sem);
    }
    readers++;
    sem_post(&r_sem);
    NSLog(@"读：8");
    sem_wait(&r_sem);
    readers--;
    if (readers == 0) {
        sem_post(&w_sem);
    }
    sem_post(&r_sem);
}

- (void)testPthreadMutexAndCondition {
    // 使用条件变量+互斥锁来实现。注意：条件变量必须和互斥锁一起使用，等待、释放的时候需要加锁。
    pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
    pthread_cond_t  cond  = PTHREAD_COND_INITIALIZER;
    int w = 0, r = 0;
    
    // 读
    pthread_mutex_lock(&mutex);
    while(w != 0) {                         // 注意这个地方是 while
        pthread_cond_wait(&cond, &mutex);   // 等待条件变量的成立
    }
    r++;
    pthread_mutex_unlock(&mutex);
    NSLog(@"读：1");
    pthread_mutex_lock(&mutex);
    r--;
    if (r == 0) {
        pthread_cond_broadcast(&cond);     // 唤醒其他因条件变量而产生的阻塞
    }
    pthread_mutex_unlock(&mutex);
    
    pthread_mutex_lock(&mutex);
    while(w != 0) {
        pthread_cond_wait(&cond, &mutex);
    }
    r++;
    pthread_mutex_unlock(&mutex);
    NSLog(@"读：2");
    pthread_mutex_lock(&mutex);
    r--;
    if (r == 0) {
        pthread_cond_broadcast(&cond);
    }
    pthread_mutex_unlock(&mutex);
    
    pthread_mutex_lock(&mutex);
    while(w != 0) {
        pthread_cond_wait(&cond, &mutex);
    }
    r++;
    pthread_mutex_unlock(&mutex);
    NSLog(@"读：3");
    pthread_mutex_lock(&mutex);
    r--;
    if (r == 0) {
        pthread_cond_broadcast(&cond);
    }
    pthread_mutex_unlock(&mutex);
    
    pthread_mutex_lock(&mutex);
    while(w != 0) {
        pthread_cond_wait(&cond, &mutex);
    }
    r++;
    pthread_mutex_unlock(&mutex);
    NSLog(@"读：4");
    pthread_mutex_lock(&mutex);
    r--;
    if (r == 0) {
        pthread_cond_broadcast(&cond);
    }
    pthread_mutex_unlock(&mutex);
    
    // 写
    pthread_mutex_lock(&mutex);
    while(w != 0 || r > 0) {               // 注意这个地方是 while
        pthread_cond_wait(&cond, &mutex);  // 等待条件变量的成立
    }
    w = 1;
    pthread_mutex_unlock(&mutex);
    NSLog(@"写：1");
    pthread_mutex_lock(&mutex);
    w = 0;
    pthread_cond_broadcast(&cond);   // 唤醒其他因条件变量而产生的阻塞
    pthread_mutex_unlock(&mutex);
    
    // 读
    pthread_mutex_lock(&mutex);
    while(w != 0) {
        pthread_cond_wait(&cond, &mutex);
    }
    r++;
    pthread_mutex_unlock(&mutex);
    NSLog(@"读：5");
    pthread_mutex_lock(&mutex);
    r--;
    if (r == 0) {
        pthread_cond_broadcast(&cond);
    }
    pthread_mutex_unlock(&mutex);
    
    pthread_mutex_lock(&mutex);
    while(w != 0) {
        pthread_cond_wait(&cond, &mutex);
    }
    r++;
    pthread_mutex_unlock(&mutex);
    NSLog(@"读：6");
    pthread_mutex_lock(&mutex);
    r--;
    if (r == 0) {
        pthread_cond_broadcast(&cond);
    }
    pthread_mutex_unlock(&mutex);
    
    pthread_mutex_lock(&mutex);
    while(w != 0) {
        pthread_cond_wait(&cond, &mutex);
    }
    r++;
    pthread_mutex_unlock(&mutex);
    NSLog(@"读：7");
    pthread_mutex_lock(&mutex);
    r--;
    if (r == 0) {
        pthread_cond_broadcast(&cond);
    }
    pthread_mutex_unlock(&mutex);
    
    pthread_mutex_lock(&mutex);
    while(w != 0) {
        pthread_cond_wait(&cond, &mutex);
    }
    r++;
    pthread_mutex_unlock(&mutex);
    NSLog(@"读：8");
    pthread_mutex_lock(&mutex);
    r--;
    if (r == 0) {
        pthread_cond_broadcast(&cond);
    }
    pthread_mutex_unlock(&mutex);
}

// 多线程数据竞争问题（多个线程更新相同的资源会导致数据的不一致）
// 1.使用 gcd 的 serial queue，保证在一个线程中执行，可避免数据竞争问题
// 2.dispatch_barrier_async
// 3.dispatch_semaphore
// 4.Lock
// 5.mutext
// 6.@synchronized() {}
// 7.atomic function
// 8.dispatch_once
- (void)testMultiThreadSafe {
    // 1.使用 gcd 的 serial queue，保证在一个线程中执行，可避免数据竞争问题
    // 2.dispatch_barrier_async
    // 3.dispatch_semaphore
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    for (int i = 0; i < 1000; ++i) {
//        dispatch_async(queue, ^{
//            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//            // 这个地方也可以指定等待具体的超时时间
//            // 判断返回值为 0 则是由于 Dispatch Semaphore 的计数值达到大于等于1，或者在待机中的指定时间内 Dispatch Semaphore 的计数值达到大于等于1，所以 Dispatch Semaphore 的计数值减去 1。
//            // 判断返回值不为 0 则是由于在待机时间内 Dispatch Semaphore 的计数值为 0
//
//            [array addObject:[NSNumber numberWithInt:i]];
//
//            dispatch_semaphore_signal(semaphore);
//        });
//    }
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"array.count: %zd", array.count);
//    });

//    dispatch_release(semaphore);
    
    // 4.Lock
    
    // 5.mutext
    
    // 6.@synchronized() {}
    
    // 7.atomic function
    
    // 8.dispatch_once
    // 用于保证在应用程序执行中只执行一次指定处理的API。（多线程安全的）
    // 常用于单件的实现
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        NSLog(@"Only execute once");
    });
}

// 多线程的死锁问题（停止等待事件的线程会导致多个线程相互持续等待）
- (void)testMultiThreadDeadLock {
    
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




