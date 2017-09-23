//
//  MRCObject+TestDealloc.m
//  TestTemplateProject
//
//  Created by Ben on 2017/9/23.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "MRCObject+TestDealloc.h"

@implementation MRCObject (TestDealloc)

- (void)dealloc {
    NSLog (@"MRCObject(TestDealloc) dealloc");
}

@end


