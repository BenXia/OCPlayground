//
//  PlaygroundVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/6/12.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "PlaygroundVC.h"

@interface PlaygroundVC ()

@property (weak, nonatomic) IBOutlet UILabel *testAttributedTextLabel;

@end

@implementation PlaygroundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testAttributedTextLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:@"测试[[NSMutableAttributedString alloc] initWithString:]字体大小"];
    self.view = nil;
    
    // UIView *view = (UIView *)self.view; // 打开这个代码会触发无穷递归（栈溢出）
}

- (void)loadView {
    [super loadView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog (@"PlaygroundVC viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog (@"PlaygroundVC viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog (@"PlaygroundVC viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog (@"PlaygroundVC viewDidDisappear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


