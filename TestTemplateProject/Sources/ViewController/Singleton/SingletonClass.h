//
//  SingletonClass.h
//  TestTemplateProject
//
//  Created by Ben on 2017/8/20.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonClass : NSObject

@property (nonatomic, assign) NSUInteger number;

+ (instancetype)sharedSingletonClass;

@end


