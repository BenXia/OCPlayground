//
//  Person.m
//  TestTemplateProject
//
//  Created by Ben on 2017/8/20.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)test {
    NSLog(@"self class: %p %p %p %p %@ %@ %@ %@",
          [self class], [self superclass], [super class], [super superclass],
          NSStringFromClass([self class]),
          NSStringFromClass([self superclass]),
          NSStringFromClass([super class]),
          NSStringFromClass([super superclass]));
}

@end
