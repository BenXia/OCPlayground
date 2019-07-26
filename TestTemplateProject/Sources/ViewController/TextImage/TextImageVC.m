//
//  TextImageVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/6/12.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "TextImageVC.h"
#import "TestTemplateProject-Swift.h"

@interface TextImageVC ()

@end

@implementation TextImageVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didClickShowTextViewTestVC:(id)sender {
    TextViewTestVC *vc = [TextViewTestVC new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didClickShowCoreTextTestVC:(id)sender {
    CoreTextTestVC *vc = [CoreTextTestVC new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didClickShowNSAttachmentTestVC:(id)sender {
    AttachmentTestVC *vc = [AttachmentTestVC new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end


