//
//  Case2SuperClass.m
//  TestTemplateProject
//
//  Created by Ben on 2020/11/19.
//  Copyright © 2020 iOSStudio. All rights reserved.
//

#import "Case2SuperClass.h"

@implementation Case2SuperClass

+ (void)load {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

+ (void)initialize {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

@end

@implementation Case2ChildClass

+ (void)load {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

+ (void)initialize {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
    
    Case2AnotherClass *object = [Case2AnotherClass new];
    [object doSomeMethod];
}

@end

@implementation Case2AnotherClass

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


