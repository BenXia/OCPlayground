//
//  Person.h
//  TestTemplateProject
//
//  Created by Ben on 2017/8/20.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger age;

- (void)test;
- (NSString *)getInfo;

@end
