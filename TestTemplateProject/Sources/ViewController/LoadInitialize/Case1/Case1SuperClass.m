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
    NSLog(@"%s", __FUNCTION__);
}

+ (void)initialize {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

- (void)doSomeMethod {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

@end


