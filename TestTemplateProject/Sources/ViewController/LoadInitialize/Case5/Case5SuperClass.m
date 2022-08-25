//
//  Case5SuperClass.m
//  TestTemplateProject
//
//  Created by Ben on 2020/11/19.
//  Copyright © 2020 iOSStudio. All rights reserved.
//

#import "Case5SuperClass.h"

@implementation Case5SuperClass

+ (void)load {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

+ (void)initialize {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

@end

@implementation Case5ChildClass

+ (void)load {
    [super load];
    
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

+ (void)initialize {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
    
    Case5AnotherClass *object = [Case5AnotherClass new];
    [object doSomeMethod];
}

@end

@implementation Case5AnotherClass

//+ (void)load {
//    NSLog(@"%s", __FUNCTION__);
//}

+ (void)initialize {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

- (void)doSomeMethod {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

@end


