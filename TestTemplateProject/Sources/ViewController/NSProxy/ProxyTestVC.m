//
//  ProxyTestVC.m
//  TestTemplateProject
//
//  Created by Ben on 12/6/18.
//  Copyright (c) 2018 Ben. All rights reserved.
//

#import "ProxyTestVC.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "Aspects.h"
#import "CustomTarget.h"
#import "ProxyWithWeakTarget.h"

static void swizzleDeallocFor(Class classToSwizzle) {
    NSString *className = NSStringFromClass(classToSwizzle);
    SEL deallocSelector = sel_registerName("dealloc");

    __block void (*originalDealloc)(__unsafe_unretained id, SEL) = NULL;

    id newDealloc = ^(__unsafe_unretained id self) {
        NSLog(@"%@ dealloc", [self class]);

        if (originalDealloc == NULL) {
            struct objc_super superInfo = {
                .receiver = self,
                .super_class = class_getSuperclass(classToSwizzle)
            };

            void (*msgSend)(struct objc_super *, SEL) = (__typeof__(msgSend))objc_msgSendSuper;
            msgSend(&superInfo, deallocSelector);
        } else {
            originalDealloc(self, deallocSelector);
        }
    };
    
    IMP newDeallocIMP = imp_implementationWithBlock(newDealloc);
    
    if (!class_addMethod(classToSwizzle, deallocSelector, newDeallocIMP, "v@:")) {
        // The class already contains a method implementation.
        Method deallocMethod = class_getInstanceMethod(classToSwizzle, deallocSelector);
        
        // We need to store original implementation before setting new implementation
        // in case method is called at the time of setting.
        originalDealloc = (__typeof__(originalDealloc))method_getImplementation(deallocMethod);
        
        // We need to store original implementation again, in case it just changed.
        originalDealloc = (__typeof__(originalDealloc))method_setImplementation(deallocMethod, newDeallocIMP);
    }
}



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
//    [self testCustomTarget];
    
    //3.中间人（NSProxy）打破环引用
    [self testProxy];
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
    
    // [self.repeatTimer class]: __NSCFTimer
    
    // 下面几种 hook 方式都无法注入 self.repeatTimer 的 dealloc 方法
//    Method oriMethod = class_getInstanceMethod([self.repeatTimer class], NSSelectorFromString(@"dealloc"));
//    Method repMethod = class_getInstanceMethod([self.repeatTimer class], @selector(replaceDealloc));
//    method_exchangeImplementations(oriMethod, repMethod);
    
//    [[self.repeatTimer class] aspect_hookSelector:NSSelectorFromString(@"dealloc")
//                                      withOptions:AspectPositionBefore
//                                       usingBlock:^(id<AspectInfo> info) {
//                                           NSLog(@"NSTimer dealloc");
//                                       }
//                                            error:NULL];
    
//    [self.repeatTimer aspect_hookSelector:NSSelectorFromString(@"dealloc")
//                              withOptions:AspectPositionBefore
//                               usingBlock:^(id<AspectInfo> info) {
//                                   NSLog(@"NSTimer dealloc");
//                                    }
//                                    error:NULL];

//    swizzleDeallocFor(self.repeatTimer.class);
    
    [[NSRunLoop currentRunLoop] addTimer:self.repeatTimer forMode:NSDefaultRunLoopMode];
}

void swizzlingTheInstanceMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // 假如交换的方法在继承链条上不存在，就会导致交换失败，那么就要在上面代码中单独处理下单独处理下：
    if (!originalMethod) {
        // 在oriMethod为nil时，替换后将swizzledSEL复制一个不做任何事的空实现,代码如下:
        class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        method_setImplementation(swizzledMethod, imp_implementationWithBlock(^(id self, SEL _cmd){ }));
        
        return;
    }

    // 如果交换的方法是父类的方法，就会导致当父类调用该方法时候报错，因为父类没有子类的方法。
    // 解决方法就是：先尝试给交换的类添加要交换的方法，如果添加成功，说明自己没有这个方法，
    //             那么就对该类做替换操作，如果添加失败说明自己有这个方法，那么就直接做交换操作。
    // 方法一：
    //给class添加originalSelector方法，确保class有originalSelector方法
    class_addMethod(class, originalSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    //取到class的originalSelector的Method，因为上面originalMethod可能是class父类的，交换的话可能会导致父类找不到swizzledMethod方法
    originalMethod = class_getInstanceMethod(class, originalSelector);
    //交换方法
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    
    // 方法二：比较通用
//    BOOL didAddMethod = class_addMethod(class,
//                                        originalSelector,
//                                        method_getImplementation(swizzledMethod),
//                                        method_getTypeEncoding(swizzledMethod));
//
//    if (didAddMethod) {
//        // 注意这个地方 super 的实现不会执行两次
//        class_replaceMethod(class,
//                            swizzledSelector,
//                            method_getImplementation(originalMethod),
//                            method_getTypeEncoding(originalMethod));
//    } else {
//        method_exchangeImplementations(originalMethod, swizzledMethod);
//    }
    
    
//    Method afterOMethod = class_getInstanceMethod(class, originalSelector);
//    Method afterSMethod = class_getInstanceMethod(class, swizzledSelector);
}

- (void)replaceDealloc {
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


