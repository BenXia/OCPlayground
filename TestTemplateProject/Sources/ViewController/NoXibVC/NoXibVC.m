//
//  NoXibVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/8/21.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "NoXibVC.h"

@interface NoXibVC ()

@end

@implementation NoXibVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog (@"self.view.bounds: %@", NSStringFromCGRect(self.view.bounds));
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
