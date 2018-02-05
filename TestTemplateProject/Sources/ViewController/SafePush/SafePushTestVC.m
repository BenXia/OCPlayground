//
//  SafePushTestVC.m
//  TestTemplateProject
//
//  Created by Ben on 2018/2/5.
//  Copyright © 2018年 iOSStudio. All rights reserved.
//

#import "SafePushTestVC.h"

@interface SafePushTestVC ()

@end

@implementation SafePushTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didClickPushTwiceButton:(id)sender {
    SafePushTestVC *vcOne = [SafePushTestVC new];
    SafePushTestVC *vcTwo = [SafePushTestVC new];
    SafePushTestVC *vcThree = [SafePushTestVC new];
    SafePushTestVC *vcFour = [SafePushTestVC new];
    
    [self.navigationController pushViewController:vcOne animated:YES];
    [self.navigationController pushViewController:vcTwo animated:YES];
    [self.navigationController pushViewController:vcThree animated:YES];
    [self.navigationController pushViewController:vcFour animated:YES];
}

@end


