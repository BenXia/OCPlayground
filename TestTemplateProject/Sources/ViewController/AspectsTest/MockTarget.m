//
//  MockTarget.m
//  TestTemplateProject
//
//  Created by Ben on 2023/11/16.
//  Copyright © 2023 iOSStudio. All rights reserved.
//

#import "MockTarget.h"
#import <objc/runtime.h>

@interface MockTarget ()

@end

@implementation MockTarget

- (void)setDate:(NSDate *)date {
    NSLog (@"MockTarget setDate");
    _date = date;
}

@end




