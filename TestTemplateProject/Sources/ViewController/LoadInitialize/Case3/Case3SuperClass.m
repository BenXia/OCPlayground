//
//  Case3SuperClass.m
//  TestTemplateProject
//
//  Created by Ben on 2020/11/19.
//  Copyright © 2020 iOSStudio. All rights reserved.
//

#import "Case3SuperClass.h"

@implementation Case3SuperClass

//+ (void)load {
//    NSLog(@"%@ %s", [self class], __FUNCTION__);
//}

+ (void)initialize {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

@end

@implementation Case3ChildClass

+ (void)load {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

//+ (void)initialize {
//    NSLog(@"%@ %s", [self class], __FUNCTION__);
//
//    Case3AnotherClass *object = [Case3AnotherClass new];
//    [object doSomeMethod];
//}

@end

@implementation Case3AnotherClass

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


