//
//  RunLoopVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/9/17.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "RunLoopVC.h"

@interface RunLoopVC ()

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation RunLoopVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // CADispalyLink 由 Source1 mach port 触发
    //[self startDisplayLink];
    
    // 由 Timer mach port 触发
    //[self performSelector:@selector(delayFunction) withObject:nil afterDelay:3];
    
    // waitUntilDone NO 则为 Source0， YES 则栈中继续执行
    //[self performSelectorOnMainThread:@selector(performOnMainFunction) withObject:nil waitUntilDone:YES];
    
    //[self testAsyncWaiting];
    
    // 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CADisplayLink test

- (void)startDisplayLink {
    [self stopDisplayLink];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopDisplayLink {
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

- (void)displayLinkAction {
    NSLog (@"Just for easy break point");
}

#pragma mark - performSelector test

- (void)delayFunction {
    NSLog (@"Just for easy break point");
}

- (void)performOnMainFunction {
    NSLog (@"Just for easy break point");
}

#pragma mark - Async Test Case

- (void)testAsyncWaiting {
    __block BOOL isFinished = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        isFinished = YES;
    });
    
    [self runUntilBlock:^BOOL{
        return isFinished;
    } timeout:15];
    
    NSLog (@"after async waiting");
}

//- (void)runUntilBlock:(BOOL (^)())block timeout:(NSTimeInterval)timeout {
//    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeout];
//    do {
//        CFTimeInterval quantum = 0.0001;
//        CFRunLoopRunInMode(kCFRunLoopDefaultMode, quantum, false);
//    } while([timeoutDate timeIntervalSinceNow] > 0.0 && !block());
//}

- (BOOL)runUntilBlock:(BOOL(^)(void))block timeout:(NSTimeInterval)timeout {
    __block Boolean fulfilled = NO;
    void (^beforeWaiting)(CFRunLoopObserverRef observer, CFRunLoopActivity activity) =
    ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        fulfilled = block();
        if (fulfilled) {
            CFRunLoopStop(CFRunLoopGetCurrent());
        }
    };
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(NULL, kCFRunLoopBeforeWaiting, true, 0, beforeWaiting);
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    // Run!
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, timeout, false);
    
    CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    CFRelease(observer);
    
    return fulfilled;
}

@end


