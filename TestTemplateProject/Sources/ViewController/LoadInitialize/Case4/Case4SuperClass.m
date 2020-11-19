//
//  Case4SuperClass.m
//  TestTemplateProject
//
//  Created by Ben on 2020/11/19.
//  Copyright © 2020 iOSStudio. All rights reserved.
//

#import "Case4SuperClass.h"

@implementation Case4SuperClass

+ (void)load {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

+ (void)initialize {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

@end

@implementation Case4SuperClass(Category)
 
+ (void)load {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

+ (void)initialize {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

@end

@implementation Case4SuperClass(OtherCategory)

+ (void)load {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

+ (void)initialize {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

@end


