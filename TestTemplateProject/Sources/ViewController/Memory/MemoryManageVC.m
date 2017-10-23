//
//  MemoryManageVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/10/23.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "MemoryManageVC.h"

@interface MemoryManageVC ()

@property (nonatomic, strong) Block block;
@property (nonatomic, strong) NSMutableArray *tempArray;

@end

@implementation MemoryManageVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self testBlockMemoryManage];
    
    self.block();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog (@"MemoryManageVC dealloc");
}

#pragma mark - Private methods

- (void)testBlockMemoryManage {
    //@weakify(self)
    __weak MemoryManageVC* self_weak_ = self;
    self.block = ^{
        //@strongify(self)
        __strong MemoryManageVC* self = self_weak_;
        NSLog (@"self.tempArray: %@", self.tempArray);
        
        //@weakify(self)                             //这句可加可不加
        //__weak MemoryManageVC* self_weak_ = self;  //这句可加可不加
        self.block = ^{
            //@strongify(self)
            __strong MemoryManageVC *self = self_weak_;
            NSLog (@"self.tempArray: %@", self.tempArray);
        };
    };
}

@end
