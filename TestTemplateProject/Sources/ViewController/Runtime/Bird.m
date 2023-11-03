//
//  Bird.m
//  TestTemplateProject
//
//  Created by Ben on 2023/11/3.
//  Copyright © 2023 iOSStudio. All rights reserved.
//

#import "Bird.h"

@implementation Bird

void swizzlingInstanceMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
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

+ (void)load {
    // 测试换实现时候子类没有该方法的情况
    swizzlingInstanceMethod([self class], @selector(speak), @selector(custom_speak));
    
    // 测试换实现时候该类继承链上都没有该方法的情况
    swizzlingInstanceMethod([self class], @selector(run), @selector(custom_run));
}

- (void)custom_speak {
    NSLog(@"Bird Custom Speak");
    
    [self custom_speak];
}

- (void)custom_run {
    NSLog(@"Custom Run");
    
    [self custom_run];
}

@end




