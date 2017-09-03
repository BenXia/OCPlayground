//
//  BOOLTestVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/9/3.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "BOOLTestVC.h"

//Update October 2013 - On 64-bit iOS (device and simulator) BOOL is now actually bool, so the sharp corners have thankfully gone away for that platform.

static BOOL different (int thing1, int thing2) {
    return thing1 - thing2;
} // difference

static NSString *g_name2 = @"wjkflasj";
static NSString *g_name = @"wjkflasjdf";

static BOOL haveName () {
    return (BOOL)g_name;  //(BOOL)0x10000000;
} // haveName

//static BOOL haveName () {
//    if (g_name) {
//        return YES;
//    } else {
//        return NO;
//    }
//} // haveName
//
//static BOOL haveName () {
//    return g_name != nil;
//} // haveName

@interface BOOLTestVC ()

@end

@implementation BOOLTestVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self testCaseOne];
    
    [self testCaseTwo];
    
    [self testCaseThree];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TestCases

- (void)testCaseOne {
    if (different(11, 10) == YES) printf ("11 != 10\n");
    else printf ("11 == 10\n");
    
    if (different(10, 11) == YES) printf ("10 != 11\n");
    else printf ("10 == 11\n");
    
    if (different(10, 15) == YES) printf ("10 != 15\n");
    else printf ("10 == 15\n");
    
    if (different(512, 256) == YES) printf ("512 != 256\n");
    else printf ("512 == 256\n");
}

- (void)testCaseTwo {
    BOOL truefalse = (BOOL)256;
    printf ("256 -> %d\n", truefalse);
    
    bool stdTruefalse = (bool)256;
    printf ("256 -> %d (bool)\n", stdTruefalse);
}

- (void)testCaseThree {
    printf ("haveName -> %d \n", haveName());
}

@end


