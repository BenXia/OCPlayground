//
//  Case7SuperClass.m
//  TestTemplateProject
//
//  Created by Ben on 2020/11/19.
//  Copyright © 2020 iOSStudio. All rights reserved.
//

#import "Case7SuperClass.h"

@implementation Case7SuperClass


//运行这段代码，Xcode给出如下的信息：
//objc[84934]: Object 0x10a512930 of class __NSArrayI autoreleased with no pool in place - just leaking - break on objc_autoreleaseNoPool() to debug
//2012-09-28 18:07:39.042 ClassMethod[84934:403] (
//) +[MainClass load]
//其原因是runtime调用+(void)load的时候，程序还没有建立其autorelease pool，所以那些会需要使用到autorelease pool的代码，都会出现异常。这一点是非常需要注意的，也就是说放在+(void)load中的对象都应该是alloc出来并且不能使用autorelease来释放。

+ (void)load {
    NSArray *array = [NSArray array];
    NSLog(@"%@ %s", array, __FUNCTION__);
}

@end


