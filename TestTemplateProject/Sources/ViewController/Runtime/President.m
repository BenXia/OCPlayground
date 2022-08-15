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
    
    NSLog(@"self: %p self class: %p %p %p %p %@ %@ %@ %@",
          self, [self class], [self superclass], [super class], [super superclass],
          NSStringFromClass([self class]),
          NSStringFromClass([self superclass]),
          NSStringFromClass([super class]),
          NSStringFromClass([super superclass]));
}

@end


