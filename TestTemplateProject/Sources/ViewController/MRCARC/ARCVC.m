//
//  ARCVC.m
//  TestTemplateProject
//
//  Created by Ben on 2/7/15.
//  Copyright (c) 2015 Ben. All rights reserved.
//

#import "ARCVC.h"
#import "MRCViewB.h"

@interface ARCVC ()

@property (nonatomic, strong) MRCViewB *viewB;

@end

@implementation ARCVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    _viewB = [[MRCViewB alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    if (_viewB.repeatTimer) {
        [_viewB.repeatTimer invalidate];
        _viewB.repeatTimer = nil;
    }
}

@end
