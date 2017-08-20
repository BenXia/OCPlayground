//
//  SomeClass.m
//  TestTemplateProject
//
//  Created by Ben on 2017/8/20.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "SomeClass.h"
#import "SingletonClass.h"

@interface SomeClass ()

@property (nonatomic, assign) NSUInteger number;

@end

@implementation SomeClass

- (id)init {
    self = [super init];
    if (self) {
        _number = [[SingletonClass sharedSingletonClass] number];//此处用到了单例中的number的值
    }
    return self;
}

@end
