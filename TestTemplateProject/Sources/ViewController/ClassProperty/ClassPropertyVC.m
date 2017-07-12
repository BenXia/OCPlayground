//
//  ClassPropertyVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/6/12.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "ClassPropertyVC.h"

@interface ClassPropertyVC ()

@property (weak, nonatomic) IBOutlet UILabel *testAttributedTextLabel;

@end

@implementation ClassPropertyVC

static NSInteger gMemberCount = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testAttributedTextLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:@"测试[[NSMutableAttributedString alloc] initWithString:]字体大小"];
    
    [ClassPropertyVC setGMemberCount:12];
    ClassPropertyVC.gMemberCount = 12;  // 使用 property 才能使用这种点语法
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog (@"gMemberCount: %zd", [ClassPropertyVC gMemberCount]);
    NSLog (@"gMemberCount: %zd", ClassPropertyVC.gMemberCount);  // 使用 property 才能使用这种点语法
}

+ (NSInteger)gMemberCount {
    return gMemberCount;
}

+ (void)setGMemberCount:(NSInteger)memberCount {
    gMemberCount = memberCount;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


