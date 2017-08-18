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
    
    // 打开下面代码会触发无穷递归（栈溢出）
    //self.view = nil;
    // UIView *view = (UIView *)self.view;
    
    // 多线程安全测试
    NSLog (@"线程UI的优先级为: %g", [NSThread threadPriority]);
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    thread1.name = @"线程A";
    NSLog (@"线程的优先级A为：%g", thread1.threadPriority);
    thread1.threadPriority = 0.0;
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(run2) object:nil];
    thread2.name = @"线程B";
    NSLog (@"线程的优先级B为：%g", thread2.threadPriority);
    thread2.threadPriority = 0.5;
    [thread1 start];
    [thread2 start];
    for (int i = 0; i < 10000; i++) {
        NSLog (@"-----%@------%d", [NSThread currentThread], i);
    }
}

- (void)run {
    for (int i = 0; i < 10000; i++) {
        if (i == 1) {
            [NSThread currentThread].threadPriority = 1.0;
        }
        NSLog (@"-----%@------%d", [NSThread currentThread].name, i);
    }
}

- (void)run2 {
    for (int i = 0; i < 10000; i++) {
        NSLog (@"-----%@------%d", [NSThread currentThread].name, i);
    }
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


