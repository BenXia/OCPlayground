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
    [self.arcObject release];
    self.arcObject = nil;
    [super dealloc];
    
    NSLog (@"MRCObject dealloc");
}

@end
