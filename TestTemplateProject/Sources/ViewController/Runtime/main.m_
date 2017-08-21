//
//  main.m
//  TestTemplateProject
//
//  Created by Ben on 2017/8/20.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

// This file just for: clang -rewrite-objc main.m

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString* cjmName;
@property (nonatomic, assign) NSUInteger cjmAge;

@end

@implementation Person

@synthesize cjmName = _cjmName;
@synthesize cjmAge = _cjmAge;

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *p = [[Person alloc] init];
        p.cjmName = @"JIaming Chen";
        p.cjmAge = 22;
    }
    return 0;
}
