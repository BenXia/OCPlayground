//
//  CategoryVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/9/23.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "CategoryVC.h"
#import "MRCObject.h"
#import "ARCObject.h"

@interface CategoryVC ()

@end

@implementation CategoryVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    MRCObject *mrcObject = [MRCObject new];
    ARCObject *arcObject = [ARCObject new];
    (void)mrcObject;
    (void)arcObject;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
