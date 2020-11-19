//
//  Case6SuperClass.m
//  TestTemplateProject
//
//  Created by Ben on 2020/11/19.
//  Copyright © 2020 iOSStudio. All rights reserved.
//

#import "Case6SuperClass.h"

@implementation Case6SuperClass

+ (void)load {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

//+ (void)initialize {
//    NSLog(@"%@ %s", [self class], __FUNCTION__);
//}

@end

@implementation Case6ChildClass

+ (void)load {
    NSLog(@"%@ %s", @"Case6ChildClass", __FUNCTION__);
}

//+ (void)initialize {
//    NSLog(@"%@ %s", [self class], __FUNCTION__);
//    
//    Case6AnotherClass *object = [Case6AnotherClass new];
//    [object doSomeMethod];
//}

@end

@implementation Case6AnotherClass

+ (void)load {
    NSLog(@"%s", __FUNCTION__);
}

//+ (void)initialize {
//    NSLog(@"%@ %s", [self class], __FUNCTION__);
//}

- (void)doSomeMethod {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

@end


