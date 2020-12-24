//
//  BlockTestVC.m
//  TestTemplateProject
//
//  Created by Ben on 2019/7/26.
//  Copyright © 2019 iOSStudio. All rights reserved.
//

#import "BlockTestVC.h"

@interface BlockTestVC ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation BlockTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self testRecursiveCall_1];
    
    //[self testRecursiveCall_2];
    
    //[self testRecursiveCall_3];
    
//    [self testRecursiveLock];
    
    [self testCallSuperMethod];
}

- (void)testRecursiveCall_1 {
    static void (^p)(int) = nil;
    
    __weak typeof(p) weakP = p;
    
    p = ^(int i){
        __strong typeof(p) inStrongP = weakP;
        if (i > 0) {
            NSLog(@"Hello, world!");
            inStrongP(i - 1);
        }
    };
    
    weakP = p;
    
    p(2);
    
//    void (^operation)(BOOL) = ^(BOOL flag){
//        if (flag) {
//            operation();
//        }
//    }
}

- (void)testRecursiveCall_2 {
    void (^p)(int) = 0;
    static void (^ const blocks)(int) = ^(int i){
       if (i > 0) {
          NSLog(@"Hello, world!");
          blocks(i - 1);
       }
    };
    p = blocks;
    p(2);
}

- (void)testRecursiveCall_3 {
    __block void (^blocks)(int);
    blocks = ^(int i){
        if (i > 0) {
            NSLog(@"Hello, world!");
            blocks(i - 1);
        }
    };
    blocks(2);
}

- (void)testRecursiveLock {
    static NSRecursiveLock *lock;
    
    if (lock == nil) {
        lock = [[NSRecursiveLock alloc] init];
    }
    
    static void (^DoLog)(int) = ^(int value){
        [lock lock];
        
        if (value > 0) {
            DoLog(value-1);
        }
        
        NSLog(@"value is %d", value);
        
        [lock unlock];
        
    };
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"test begin");
        
        DoLog(5);
        
        NSLog(@"test end");
    });
}

- (void)justForTestMethod {
    NSLog (@"====BlockTestVC====justForTestMethod");
}

- (void)testCallSuperMethod {
    static NSMutableArray *s_blockArray = nil;
    
    if (!s_blockArray || s_blockArray.count == 0) {
        void (^operationBlock)(void) = ^{
            [super justForTestMethod];
        };
        
        s_blockArray = [NSMutableArray arrayWithObject:[operationBlock copy]];
    }
    
    void (^nextBlock)(void) = [s_blockArray firstObject];
    
    nextBlock();
}

@end


