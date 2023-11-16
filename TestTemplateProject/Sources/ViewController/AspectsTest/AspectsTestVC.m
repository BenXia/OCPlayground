//
//  AspectsTestVC.m
//  TestTemplateProject
//
//  Created by Ben on 12/6/18.
//  Copyright (c) 2018 Ben. All rights reserved.
//

#import "AspectsTestVC.h"
#import "EOCAutoDictionary.h"
#import "Aspects.h"

@interface AspectsTestVC ()

@property (nonatomic, strong) EOCAutoDictionary *dict;

@end

@implementation AspectsTestVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dict = [EOCAutoDictionary new];
    
    // 如果 setDate: 方法是需要等动态添加的话，则动态添加的方法中的 _cmd 为 aspects__ 加上原始方法名前缀，需要注意一下。
    // 此处即方法名会变成 aspects__setDate: （因为把原始实现放到了这个别名 selector 中）
    [self.dict aspect_hookSelector:NSSelectorFromString(@"setDate:")
                       withOptions:AspectPositionBefore
                        usingBlock:^(id<AspectInfo> info) {
                           NSLog(@"EOCAutoDictionary will perform setDate:");
                       }
                            error:NULL];
    self.dict.date = [NSDate dateWithTimeIntervalSince1970:475372800];
    NSLog(@"self.dict.date = %@", self.dict.date);
    
    [self aspect_hookSelector:NSSelectorFromString(@"selectorForTestHook")
                  withOptions:AspectPositionBefore
                   usingBlock:^(id<AspectInfo> info) {
                       NSLog(@"AspectsTestVC will perform selectorForTestHook");
                        }
                        error:NULL];
    
    [self aspect_hookSelector:NSSelectorFromString(@"dealloc")
                  withOptions:AspectPositionBefore
                   usingBlock:^(id<AspectInfo> info) {
                       NSLog(@"AspectsTestVC will dealloc");
                        }
                        error:NULL];
    
    [self selectorForTestHook];
}

- (void)selectorForTestHook {
    NSLog (@"AspectsTestVC selectorForTestHook");
}

@end




