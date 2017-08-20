//
//  SingletonVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/8/20.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "SingletonVC.h"
#import "SingletonClass.h"

@interface SingletonVC ()

@end

@implementation SingletonVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"Hello, World!");
    
    NSLog(@"%@:", [SingletonClass sharedSingletonClass]);
    
    NSLog(@"Hello, World!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


