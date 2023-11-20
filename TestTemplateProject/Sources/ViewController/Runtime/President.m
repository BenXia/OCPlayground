//
//  President.m
//  TestTemplateProject
//
//  Created by Ben on 2017/8/30.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "President.h"

@implementation President

- (void)test {
    [super test];
    
    // super 只是编译器标识符，意思是从 currentclass->superclass 开始在继承链上查找某个 function
    // 此处调用的 class 方法最终都是在 NSObject 中，最终执行的方法是一样的，第一个参数也都是 self 这个对象指针，所以打印都一样
    // 但是下面这个 getInfo 方法则因为找的最终执行方法不一样，所以打印不同
    NSLog(@"self: %p self class: %p %p %p %p %@ %@ %@ %@",
          self, [self class], [self superclass], [super class], [super superclass],
          NSStringFromClass([self class]),
          NSStringFromClass([self superclass]),
          NSStringFromClass([super class]),
          NSStringFromClass([super superclass]));
    
    NSLog(@"[self getInfo]: %@\n[super getInfo]: %@", [self getInfo], [super getInfo]);
}

- (NSString *)getInfo {
    return @"President getInfo";
}

@end


