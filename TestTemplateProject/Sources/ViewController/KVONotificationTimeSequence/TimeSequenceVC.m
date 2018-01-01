//
//  TimeSequenceVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/6/12.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "TimeSequenceVC.h"
#import "ReactiveObjC.h"

@interface TimeSequenceVC ()

@property (nonatomic, strong) NSString *text;

@end

@implementation TimeSequenceVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification:) name:@"kNotificationName" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationName" object:nil];
    
    NSLog (@"You");
    
    [[RACObserve(self, text) skip:1] subscribeNext:^(id x) {
        NSLog (@"Know");
    }];
    
//    [[[RACObserve(self, text) skip:1] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(id x) {
//        NSLog (@"Know");
//    }];
    
    self.text = @"Hello world";
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        self.text = @"Hello world";
//    });
    
    NSLog (@"Why");
}

- (void)didReceiveNotification:(NSNotification *)notification {
    NSLog (@"Do");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
