//
//  ProxyTestVC.m
//  TestTemplateProject
//
//  Created by Ben on 12/6/18.
//  Copyright (c) 2018 Ben. All rights reserved.
//

#import "ProxyTestVC.h"
#import <objc/runtime.h>
#import "Aspects.h"
#import "CustomTarget.h"
#import "ProxyWithWeakTarget.h"

@interface ProxyTestVC ()

@property (nonatomic, strong) NSTimer *repeatTimer;
@property (nonatomic, strong) id target;
@property (nonatomic, strong) ProxyWithWeakTarget *proxy;

@end

@implementation ProxyTestVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.常规使用
//    [self testGeneralUsage];
    
    //2.自定义类打破环引用
    [self testCustomTarget];
    
    //3.中间人（NSProxy）打破环引用
//    [self testProxy];
}

// 1.常规使用 打开该方法
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//
//    if (self.isMovingFromParentViewController) {
//        [self.repeatTimer invalidate];
//        self.repeatTimer = nil;
//    }
//}

// 2.自定义类打破环引用
// 3.中间人（NSProxy）打破环引用
// 两种方案打开该方法
- (void)dealloc {
    [self.repeatTimer invalidate];
    self.repeatTimer = nil;
    
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

#pragma mark - Private methods

- (void)sayHello {
    NSLog(@"hello");
}

- (void)testGeneralUsage {
    // runloop -> timer -> self  self->timer
    
    self.repeatTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(sayHello) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.repeatTimer forMode:NSDefaultRunLoopMode];
}

- (void)testCustomTarget {
    // runloop -> timer -> target(中间件)
    
    // 注意 VC、Timer、Target 的 dealloc 方法顺序应该是 VC -> Timer -> Target（self.timer = nil; 会将当前timer autorelease）
    
    //给一个类添加一个新的方法和该方法的具体实现
    //"v@:"第一个表示返回值，二三位是固定的。 (B:BOOL  V:void *:char * @:id #:Class (:):SEL)
    
    self.target = [CustomTarget new];
    class_addMethod([self.target class], @selector(sayHello), (IMP)sayHelloIMP, "v@:");
    self.repeatTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self.target selector:@selector(sayHello) userInfo:nil repeats:YES];
    
    // 下面几种 hook 方式都无法注入 self.repeatTimer 的 dealloc 方法
//    Method oriMethod = class_getInstanceMethod([self.repeatTimer class], NSSelectorFromString(@"dealloc"));
//    Method repMethod = class_getInstanceMethod([self class], @selector(replaceDelloc));
//    method_exchangeImplementations(oriMethod, repMethod);
    
    [[self.repeatTimer class] aspect_hookSelector:NSSelectorFromString(@"dealloc")
                                      withOptions:AspectPositionBefore
                                       usingBlock:^(id<AspectInfo> info) {
                                           NSLog(@"NSTimer dealloc");
                                       }
                                            error:NULL];
    
//    [self.repeatTimer aspect_hookSelector:NSSelectorFromString(@"dealloc")
//                              withOptions:AspectPositionBefore
//                               usingBlock:^(id<AspectInfo> info) {
//                                   NSLog(@"NSTimer dealloc");
//                                    }
//                                    error:NULL];
    
    [[NSRunLoop currentRunLoop] addTimer:self.repeatTimer forMode:NSDefaultRunLoopMode];
}

- (void)replaceDelloc {
    NSLog(@"NSTimer dealloc");
}

// 函数指针，指向的是方法的实现 (至少带有两个参数)
void sayHelloIMP(id self, SEL _cmd){
    NSLog(@"hello hello");
}

- (void)testProxy {
    //runloop -> timer -> proxy（代理中间键） --->（弱引用）self
    
    //没有构造函数
    self.proxy = [ProxyWithWeakTarget alloc];
    self.proxy.target = self;
    
    self.repeatTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self.proxy selector:@selector(sayHello) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.repeatTimer forMode:NSDefaultRunLoopMode];
}

@end


