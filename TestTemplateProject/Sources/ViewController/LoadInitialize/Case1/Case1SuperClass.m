//
//  Case1SuperClass.m
//  TestTemplateProject
//
//  Created by Ben on 2020/11/19.
//  Copyright © 2020 iOSStudio. All rights reserved.
//

#import "Case1SuperClass.h"

@implementation Case1SuperClass

+ (void)load {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

+ (void)initialize {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

@end

@implementation Case1ChildClass

+ (void)load {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

+ (void)initialize {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
    
    Case1AnotherClass *object = [Case1AnotherClass new];
    [object doSomeMethod];
}

@end

@implementation Case1AnotherClass

+ (void)load {
    // runtime 对 +(void)load 的调用不一定肯定是类的第一个方法，可能其他类的 +(void)load 先执行调用了该类的 +(void)initialize 方法或其他方法
    NSLog(@"%s", __FUNCTION__);
}

+ (void)initialize {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

- (void)doSomeMethod {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

@end


