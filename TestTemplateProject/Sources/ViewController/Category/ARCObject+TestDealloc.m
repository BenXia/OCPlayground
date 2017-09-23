//
//  ARCObject+TestDealloc.m
//  TestTemplateProject
//
//  Created by Ben on 2017/9/23.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "ARCObject+TestDealloc.h"

@implementation ARCObject (TestDealloc)

- (void)dealloc {
    NSLog (@"ARCObject(TestDealloc) dealloc");
}

@end


