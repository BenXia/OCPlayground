//
//  MRCViewB.m
//  TestTemplateProject
//
//  Created by Ben on 2/7/15.
//  Copyright (c) 2015 Ben. All rights reserved.
//

#import "MRCViewB.h"

@implementation MRCViewB

- (id)init {
    if (self = [super init]) {
        _repeatTimer = [[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES] retain];
    }
    return self;
}

- (void)timerAction:(NSTimer *)timer
{
    NSLog (@"do nothing");
}

- (void)dealloc
{
    [_repeatTimer release];
    _repeatTimer = nil;
    [super dealloc];
    
    NSLog (@"====DEALLOC==== MRCViewB");
}

@end
