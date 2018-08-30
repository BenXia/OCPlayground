//
//  PlaygroundVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/6/12.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "PlaygroundVC.h"

static const NSCalendarUnit kDateComponentFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

@interface PlaygroundVC ()

@property (weak, nonatomic) IBOutlet UILabel *testAttributedTextLabel;

@end

@implementation PlaygroundVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testAttributedTextLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:@"测试[[NSMutableAttributedString alloc] initWithString:]字体大小"];
    
    // 打开下面代码会触发无穷递归（栈溢出）
    //self.view = nil;
    // UIView *view = (UIView *)self.view;
    
    // 自定义线程中注意 for 循环最好加局部的 NSAutoReleasePool
    //[NSThread detachNewThreadSelector:@selector(doSomeThing:) toTarget:self withObject:nil];
    
    // 多线程测试
//    NSLog (@"线程UI的优先级为: %g", [NSThread threadPriority]);
//    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
//    thread1.name = @"线程A";
//    NSLog (@"线程的优先级A为：%g", thread1.threadPriority);
//    thread1.threadPriority = 0.0;
//    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(run2) object:nil];
//    thread2.name = @"线程B";
//    NSLog (@"线程的优先级B为：%g", thread2.threadPriority);
//    thread2.threadPriority = 0.5;
//    [thread1 start];
//    [thread2 start];
//    for (int i = 0; i < 10000; i++) {
//        NSLog (@"-----%@------%d", [NSThread currentThread], i);
//    }
    
    // NSDateComponents 测试
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:6*60*60];
    NSDate *nowDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [calendar components:kDateComponentFlags fromDate:nowDate];
    NSLog (@"comps: %@ \ntimeZone: %@\n\n", comps, comps.timeZone);
    
    comps.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:11*60*60];
    
    // comps 中设置的 timeZone 在下面这个接口中将会有用
    NSDate *showDate = [calendar dateFromComponents:comps];
    
    NSLog (@"comps: %@ \n\nshowDate: %@\n\n", comps, showDate);
    
    NSLog (@"%@  test float format", [self stringWithMaxTwoDecimal:1.006]);
}

- (NSString *)stringWithMaxTwoDecimal:(double)num {
    return [NSString stringWithFormat:@"%@", @([[NSString stringWithFormat:@"%.2f", num] floatValue])];
}

- (void)loadView {
    [super loadView];
}

- (void)doSomeThing:(NSObject *)userInfo {
    int max_loop_times = 999999;
    for (int i = 0; i < max_loop_times; i++) {
        @autoreleasepool {
            int randNum = rand();
            NSString *tmpString = [NSString stringWithFormat:@"%d", randNum];
            NSLog(@"%@", tmpString);
        }
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog (@"PlaygroundVC viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog (@"PlaygroundVC viewDidAppear");
    
    
    UIView *viewA = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    viewA.backgroundColor = [UIColor redColor];
    [self.view addSubview:viewA];
    
    UIView *viewB = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    viewB.backgroundColor = [UIColor yellowColor];
    [viewA addSubview:viewB];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        viewA.bounds = CGRectMake(30, 30, 90, 90);
    });
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


