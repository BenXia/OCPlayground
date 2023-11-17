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
    
//    [self testRecursiveCall_2];
    
//    [self testRecursiveCall_3];
    
//    [self testRecursiveLock];
    
//    [self testCallSuperMethod];
    
    [self testWhetherBlockCopy];
    
//    [self testWhetherBlockCopy2];
    
//    [self testBlockCaptureObjectOnlyInStack];
    
//    [self testBlockCaptureObjectAndRetainWhenCopyToHeap];
    
//    [self testBlockCaptureWeakObjectAndCopyToHeap];
}

- (void)testRecursiveCall_1 {
    // 测试一：
//    static void (^p)(int) = nil;
//    p = ^(int i){
//        if (i > 0) {
//            NSLog(@"Hello, world!");
//            p(i - 1);
//        }
//    };
//    p(2);
    
    
    // 测试二：
//    __block void (^p)(int) = nil;
//    
//    p = ^(int i){
//        if (i > 0) {
//            NSLog(@"Hello, world!");
//            p(i-1);
//        }
//    };
//    
//    p(2);
    
    
    // 测试三：错误的（截获的是指针 nil）
//    void (^p)(int) = nil;
//    
//    __weak typeof(p) weakP = p;
//    
//    p = ^(int i){
//        __strong typeof(p) inStrongP = weakP;
//        if (i > 0) {
//            NSLog(@"Hello, world!");
//            inStrongP(i - 1);
//        }
//    };
//    
//    weakP = p;
//    
//    p(2);
    
    
    // 测试四：截获指针的指针是可以的
    void (^p)(int) = nil;

    __strong id *blockPointer = &p;

    p = ^(int i){
        void (^block)(int) = (void (^)(int))(*blockPointer);
        if (i > 0) {
            NSLog(@"Hello, world!");
            block(i - 1);
        }
    };

    p(2);
}

- (void)testRecursiveCall_2 {
//    void (^p)(int) = 0;
    static void (^ const blocks)(int) = ^(int i){
       if (i > 0) {
          NSLog(@"Hello, world!");
          blocks(i - 1);
       }
    };
//    p = blocks;
//    p(2);
    
    blocks(2);
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

- (NSArray *)getBlockArray {
    int val = 10;
    return [[NSArray alloc] initWithObjects:
            ^{NSLog(@"blk0:%d", val);},
            ^{NSLog(@"blk1:%d", val);}, nil];
}

- (void)testWhetherBlockCopy {
    NSArray *obj = [self getBlockArray];
    // po obj
//    <__NSArrayI 0x600000287e40>(
//        <__NSMallocBlock__: 0x600000d6c0c0>
//        <__NSMallocBlock__: 0x600000d6c270>
//    )
                                
    typedef void (^blk_t)(void);
    int val[100000];  // 定义一个比较大的栈中数组，试图擦掉之前入栈初始化的block
    memset(val, -1, sizeof(val));
    
    blk_t blk = (blk_t)[obj objectAtIndex:1];
    blk(); // （跟书上说的运行时访问的是悬垂指针不一样，竟然已经拷贝到堆中了）
    // 跟这篇文章中说的也不一样，https://www.jianshu.com/p/357e250ca6c7
    printf("%d\n", val[0]);
}

static void blockCleanUp(__strong void(^*block)(void)) {
    //(*block)();
    NSLog(@"I'm dying...");
}

- (NSArray *)getBlockArray2 {
    int val = 10;
    
    __strong void(^block)(void) __attribute__((cleanup(blockCleanUp), unused)) = ^{
        NSLog(@"blk0:%d", val);
    };
    
    return [[NSArray alloc] initWithObjects:
            //[block copy],
            block,
            [^{NSLog(@"blk1:%d", val);} copy], nil];
}

- (void)testWhetherBlockCopy2 {
    NSArray *obj = [self getBlockArray2];
    typedef void (^blk_t)(void);
    blk_t blk = (blk_t)[obj objectAtIndex:0];
    blk();
}

static void blockCleanUp2(__strong void(^*block)(id obj)) {
    //(*block)();
    NSLog(@"I'm dying...");
}

- (void)testBlockCaptureObjectOnlyInStack {
    typedef void (^blk_t)(id obj);
    
    blk_t blk;
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
//        __strong blk_t block __attribute__((cleanup(blockCleanUp2), unused)) = ^(id obj){
//            [array addObject:obj];
//            NSLog(@"array count = %ld", [array count]);
//        };
//        blk = block;
        
        blk = ^(id obj){
            [array addObject:obj];
            NSLog(@"array count = %ld", [array count]);
        };
    }
    
    blk([[NSObject alloc] init]);
    blk([[NSObject alloc] init]);
    blk([[NSObject alloc] init]);
}

- (void)testBlockCaptureObjectAndRetainWhenCopyToHeap {
    typedef void (^blk_t)(id obj);
    
    blk_t blk;
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        blk = [^(id obj){
            [array addObject:obj];
            NSLog(@"array count = %ld", [array count]);
        } copy];
    }
    
    blk([[NSObject alloc] init]);
    blk([[NSObject alloc] init]);
    blk([[NSObject alloc] init]);
}

- (void)testBlockCaptureWeakObjectAndCopyToHeap {
    typedef void (^blk_t)(id obj);
    
    blk_t blk;
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSMutableArray __weak *array2 = array;
        blk = [^(id obj){
            [array2 addObject:obj];
            NSLog(@"array count = %ld", [array2 count]);
            //NSLog(@"array count = %ld", [array count]);
        } copy];
    }
    
    blk([[NSObject alloc] init]);
    blk([[NSObject alloc] init]);
    blk([[NSObject alloc] init]);
}


/**
 * 下面的代码单独拿出去用
 * clang -rewrite-objc 源代码文件名
 * 生成C++代码看下
 
 #include <stdio.h>
 int main() {
     int dmy = 256;
     int val = 10;
     const char *fmt = "val = %d\n";
     void (^blk)(void) = ^{printf(fmt, val);};

     val = 2;
     fmt = "These values were changed, val = %d\n";

     blk();

     return 0;
 }

 #include <stdio.h>
 #import <Foundation/Foundation.h>

 int main() {
     typedef void (^blk_t)(id obj);

     blk_t blk;
     {
         NSMutableArray *array = [[NSMutableArray alloc] init];
         blk = ^(id obj){
             [array addObject:obj];
             NSLog(@"array count = %ld", [array count]);
         };
     }

     blk([[NSObject alloc] init]);
 }
 
 */

@end


