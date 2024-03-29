//
//  SingletonClass.m
//  TestTemplateProject
//
//  Created by Ben on 2017/8/20.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "SingletonClass.h"
#import "SomeClass.h"

@interface SingletonClass ()

@property (nonatomic, strong) SomeClass *someClass;

@end

@implementation SingletonClass

static SingletonClass *g_singleton = nil;

+ (instancetype)sharedSingletonClass {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_singleton = [[super allocWithZone:NULL] init];
    });
    
    return g_singleton;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedSingletonClass];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return self;
}

- (id)mutableCopyWithZone:(struct _NSZone *)zone {
    return self;
}

- (id)init {
    @synchronized ([self class]) {
//        if (!self) {
            if (self = [super init]) {
                _number = 10;//一个属性
                _someClass = [[SomeClass alloc] init];//初始化SomeClass
            }
//        }
    }

    return self;
}

@end



//static NSMutableDictionary *sharedInstances = nil;
//
//@implementation PPDataController
//
//#pragma mark - 构造方法
//+ (instancetype)sharedDataController
//{
//    PPDataController *aController;
//    
//    @synchronized(self) {
//        if (sharedInstances == nil) {
//            sharedInstances = [[NSMutableDictionary alloc] init];
//        }
//        
//        NSString *keyName = NSStringFromClass([self class]);
//        if (keyName) {
//            aController = [sharedInstances objectForKey:keyName];
//            
//            if (aController == nil) {
//                aController = [[self alloc] init];
//                
//                [sharedInstances setObject:aController forKey:keyName];
//            }
//        }
//    }
//    
//    return aController;
//}
//
//@end
