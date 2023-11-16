//
//  MRCObject.m
//  TestTemplateProject
//
//  Created by Ben on 2017/9/23.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "MRCObject.h"
#import "ARCObject.h"

@interface MRCObject ()

@property (nonatomic, retain) ARCObject *arcObject;

@end

@implementation MRCObject

- (instancetype)init {
    if (self = [super init]) {
        self.arcObject = [[ARCObject new] autorelease];
    }
    
    return self;
}

- (void)dealloc {
    // 注意：下面两段代码都会对 self.arcObject 做 release 操作，所以不能都打开
    [self.arcObject release];
    _arcObject = nil;
    
//    self.arcObject = nil;
    
    [super dealloc];
    
    NSLog (@"MRCObject dealloc");
}

@end
