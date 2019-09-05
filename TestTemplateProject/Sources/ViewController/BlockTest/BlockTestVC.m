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
    
    //[self testRecursiveCall_1];
    
    //[self testRecursiveCall_2];
    
    [self testRecursiveLock];
}

- (void)testRecursiveCall_1 {
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

- (void)testRecursiveCall_2 {
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

@end


