//
//  TimeSequenceVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/6/12.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "TimeSequenceVC.h"
#import "ReactiveObjC.h"
#import "BenTestModelOCA.h"
#import "BenTestModelOCB.h"
#import "BenTestModelOCC.h"

@interface TimeSequenceVC ()

@property (nonatomic, strong) NSString *text;

// 测试KVO KeyPath
@property (nonatomic, strong) BenTestModelOCA *testKVOModelA;

@end

@implementation TimeSequenceVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self testKVOSequence];
//    
//    [self testKVOKeyPath];
    
    [self testRACKVO];
}

- (void)testKVOSequence {
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

- (void)testKVOKeyPath {
    self.testKVOModelA = [BenTestModelOCA new];
    BenTestModelOCB *modelB1 = [BenTestModelOCB new];
    modelB1.adjusted = NO;
    modelB1.name = @"modelB1-before";
    self.testKVOModelA.objB = modelB1;

    [self.testKVOModelA addObserver:self forKeyPath:@"objB.adjusted" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    [self.testKVOModelA addObserver:self forKeyPath:@"objB.name" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];

    // 下面这两种方式去除KVO观察都会出现回调block中self为nil的问题
//    @weakify(self);
//    [self.rac_deallocDisposable addDisposable:[RACDisposable disposableWithBlock:^{
//        @strongify(self);
//        [self.testKVOModelA removeObserver:self forKeyPath:@"objB.adjusted"];
//        [self.testKVOModelA removeObserver:self forKeyPath:@"objB.name"];
//    }]];
//
//    [self.rac_willDeallocSignal subscribeCompleted:^{
//        @strongify(self);
//        [self.testKVOModelA removeObserver:self forKeyPath:@"objB.adjusted"];
//        [self.testKVOModelA removeObserver:self forKeyPath:@"objB.name"];
//    }];

    modelB1.adjusted = YES;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        modelB1.name = @"modelB1-after";
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BenTestModelOCB *modelB2 = [BenTestModelOCB new];
        modelB2.adjusted = NO;
        modelB2.name = @"modelB2-before";

        self.testKVOModelA.objB = modelB2;
    });
}

- (void)testRACKVO {
    BenTestModelOCA *model2 = [[BenTestModelOCA alloc] init];
    model2.objB = [[BenTestModelOCB alloc] init];
    BenTestModelOCB *oldB = model2.objB;
    model2.objB.objC = [[BenTestModelOCC alloc] init];
    BenTestModelOCC *oldC = model2.objB.objC;

    [[RACObserve(model2, objB.objC.name) deliverOnMainThread] subscribeNext:^(NSString *name) {
        NSLog(@"name: %@", name);
    }];
    
    // NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionPrior
//    [model2 addObserver:self forKeyPath:@"objB.objC.name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionPrior context:nil];

    model2.objB.objC.name = @"objC-name";
    BenTestModelOCC *newC = [[BenTestModelOCC alloc] init];
    newC.name = @"newObjC-name";
    model2.objB.objC = newC;
    oldC.name = @"oldObjC-name";
}

- (void)didReceiveNotification:(NSNotification *)notification {
    NSLog (@"Do");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
