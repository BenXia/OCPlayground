//
//  Case3SuperClass.m
//  TestTemplateProject
//
//  Created by Ben on 2020/11/19.
//  Copyright © 2020 iOSStudio. All rights reserved.
//

#import "Case3SuperClass.h"

static NSMutableArray *kSomeObjects;

@implementation Case3SuperClass

//+ (void)load {
//    NSLog(@"%@ %s", [self class], __FUNCTION__);
//}

+ (void)initialize {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
    
    // 加上这条检测语句之后，只有当开发者所期望的那个类载入系统时，才会执行相关初始化操作。
    // 这样就不会因为子类没有实现 initialize，触发父类的 initialize 而执行多次。
    if (self == [Case3SuperClass class]) {
        kSomeObjects = [NSMutableArray new];
    }
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


