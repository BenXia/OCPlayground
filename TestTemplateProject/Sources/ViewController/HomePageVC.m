//
//  HomePageVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/5/23.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "HomePageVC.h"
#import "PlaygroundVC.h"
#import "TimeSequenceVC.h"
#import "ClassPropertyVC.h"
#import "SingletonVC.h"
#import "LoadInitializeVC.h"
#import "RuntimeVC.h"
#import "NoXibVC.h"
#import "JSONToModelVC.h"
#import "BOOLTestVC.h"
#import "RunLoopVC.h"
#import "CategoryVC.h"
#import "MemoryManageVC.h"
#import "ARCVC.h"
#import "RACMLKVC.h"
#import "ProxyTestVC.h"
#import "MultiThreadVC.h"
#import "SafePushTestVC.h"
#import "TextImageVC.h"
#import "BlockTestVC.h"
#import "CustomContainerVC.h"
#import "CoreDataTestVC.h"
#import "Test2021QQingUIVC.h"
#import "TestTemplateProject-Swift.h"

static const CGFloat kTableViewCellHeight = 60.0f;

@interface HomePageCellModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) Block didSelectCellHandleBlock;

+ (instancetype)modelWithTitle:(NSString *)title
                      subTitle:(NSString *)subTitle
                       vcClass:(Class)vcClass
                  navigationVC:(UINavigationController *)navigationVC;

+ (instancetype)modelWithTitle:(NSString *)title
                      subTitle:(NSString *)subTitle
      didSelectCellHandleBlock:(Block)didSelectCellHandleBlock;

@end

@implementation HomePageCellModel

+ (instancetype)modelWithTitle:(NSString *)title
                      subTitle:(NSString *)subTitle
                       vcClass:(Class)vcClass
                  navigationVC:(UINavigationController *)navigationVC {
    
    return [HomePageCellModel modelWithTitle:title
                                    subTitle:subTitle
                    didSelectCellHandleBlock:^{
                        UIViewController *vc = [[vcClass alloc] init];
                        [navigationVC pushViewController:vc animated:YES];
                    }];
}


+ (instancetype)modelWithTitle:(NSString *)title
                      subTitle:(NSString *)subTitle
      didSelectCellHandleBlock:(Block)didSelectCellHandleBlock {
    HomePageCellModel *model = [HomePageCellModel new];
    model.title = title;
    model.subTitle = subTitle;
    model.didSelectCellHandleBlock = didSelectCellHandleBlock;
    
    return model;
}

@end

@interface HomePageVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray <HomePageCellModel *> *dataSourceArray;

@end

@implementation HomePageVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    HomePageCellModel *model1 = [HomePageCellModel modelWithTitle:@"操场"
                                                         subTitle:@"Do whatever you want here"
                                                          vcClass:[PlaygroundVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model2 = [HomePageCellModel modelWithTitle:@"时序"
                                                         subTitle:@"KVO、通知、RACSignal的时序研究"
                                                          vcClass:[TimeSequenceVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model3 = [HomePageCellModel modelWithTitle:@"类属性"
                                                         subTitle:@"类属性的详细实现"
                                                          vcClass:[ClassPropertyVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model4 = [HomePageCellModel modelWithTitle:@"单例注意点"
                                                         subTitle:@"在单例初始化时一定不能出现对单例的引用"
                                                          vcClass:[SingletonVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model5 = [HomePageCellModel modelWithTitle:@"Load & Initialize"
                                                         subTitle:@"调用时机、继承特性、类别定义等对比"
                                                          vcClass:[LoadInitializeVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model6 = [HomePageCellModel modelWithTitle:@"runtime"
                                                         subTitle:@"运行时浅析"
                                                          vcClass:[RuntimeVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model7 = [HomePageCellModel modelWithTitle:@"纯代码ViewController"
                                                         subTitle:@"生命周期研究"
                                                          vcClass:[NoXibVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model8 = [HomePageCellModel modelWithTitle:@"字典转模型"
                                                         subTitle:@"JSONModel、Mantle、YYModel、MJExtension使用对比"
                                                          vcClass:[JSONToModelVC class]
                                                     navigationVC:self.navigationController];

    HomePageCellModel *model9 = [HomePageCellModel modelWithTitle:@"BOOL's sharp corners"
                                                         subTitle:@"32位真机上 BOOL 与 bool 的区别"
                                                          vcClass:[BOOLTestVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model10 = [HomePageCellModel modelWithTitle:@"RunLoop"
                                                         subTitle:@"测试一些看源码产生的疑问"
                                                          vcClass:[RunLoopVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model11 = [HomePageCellModel modelWithTitle:@"Category"
                                                         subTitle:@"测试一下 Category 中重写 dealloc 方法"
                                                          vcClass:[CategoryVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model12 = [HomePageCellModel modelWithTitle:@"内存管理"
                                                          subTitle:@"内存管理相关测试"
                                                           vcClass:[MemoryManageVC class]
                                                      navigationVC:self.navigationController];
    
    HomePageCellModel *model13 = [HomePageCellModel modelWithTitle:@"内存管理"
                                                          subTitle:@"MRC/ARC相关测试"
                                                           vcClass:[ARCVC class]
                                                      navigationVC:self.navigationController];
    
    HomePageCellModel *model14 = [HomePageCellModel modelWithTitle:@"RAC内存泄漏"
                                                          subTitle:@"RAC中经典内存泄漏问题"
                                                           vcClass:[RACMLKVC class]
                                                      navigationVC:self.navigationController];
    
    
    HomePageCellModel *model15 = [HomePageCellModel modelWithTitle:@"NSProxy"
                                                          subTitle:@"代理解决一些内存管理问题"
                                                           vcClass:[ProxyTestVC class]
                                                      navigationVC:self.navigationController];
    
    HomePageCellModel *model16 = [HomePageCellModel modelWithTitle:@"多线程"
                                                          subTitle:@"多线程一些有趣的测试"
                                                           vcClass:[MultiThreadVC class]
                                                      navigationVC:self.navigationController];
    
    HomePageCellModel *model17 = [HomePageCellModel modelWithTitle:@"SafePush"
                                                          subTitle:@"SafePush一些测试"
                                                           vcClass:[SafePushTestVC class]
                                                      navigationVC:self.navigationController];
    
    HomePageCellModel *model18 = [HomePageCellModel modelWithTitle:@"图文混排"
                                                          subTitle:@"图文混排一些实现方式"
                                                           vcClass:[TextImageVC class]
                                                      navigationVC:self.navigationController];
    
    HomePageCellModel *model19 = [HomePageCellModel modelWithTitle:@"Block测试"
                                                          subTitle:@"Block一些有趣测试"
                                                           vcClass:[BlockTestVC class]
                                                      navigationVC:self.navigationController];
    
    HomePageCellModel *model20 = [HomePageCellModel modelWithTitle:@"Swift测试"
                                                          subTitle:@"Swift一些有趣测试"
                                                           vcClass:[SwiftBenTestVC class]
                                                      navigationVC:self.navigationController];
    
    HomePageCellModel *model21 = [HomePageCellModel modelWithTitle:@"容器视图"
                                                          subTitle:@"自定义容器视图研究"
                                                           vcClass:[CustomContainerVC class]
                                                      navigationVC:self.navigationController];
    
    HomePageCellModel *model22 = [HomePageCellModel modelWithTitle:@"CoreData"
                                                          subTitle:@"CoreData多线程测试"
                                                           vcClass:[CoreDataTestVC class]
                                                      navigationVC:self.navigationController];
    
    HomePageCellModel *model23 = [HomePageCellModel modelWithTitle:@"IB高级用法"
                                                          subTitle:@"IBInspectable/IBDesignable"
                                                           vcClass:[Test2021QQingUIVC class]
                                                      navigationVC:self.navigationController];
    
    self.dataSourceArray = [NSArray arrayWithObjects:model1, model2, model3, model4, model5, model6, model7, model8, model9, model10, model11, model12, model13, model14, model15, model16, model17, model18, model19, model20, model21, model22, model23, nil];
    
//    NSLog (@"self.view.frame: %@", NSStringFromCGRect(self.view.frame));
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"首页";
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
//    NSLog (@"HomePageVC viewWillAppear");
//    NSLog (@"self.view.frame: %@", NSStringFromCGRect(self.view.frame));
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    NSLog (@"HomePageVC viewWillLayoutSubviews");
//    NSLog (@"self.view.frame: %@", NSStringFromCGRect(self.view.frame));
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
//    NSLog (@"HomePageVC viewDidLayoutSubviews");
//    NSLog (@"self.view.frame: %@", NSStringFromCGRect(self.view.frame));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    NSLog (@"HomePageVC viewDidAppear");
//    NSLog (@"self.view.frame: %@", NSStringFromCGRect(self.view.frame));
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self printA];
//        [self printB];
//    });
    
//    [self performSelector:@selector(printA) withObject:nil afterDelay:3];
}

- (void)printA {
    NSLog (@"===========>A");
}

- (void)printB {
    NSLog (@"===========>B");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

//    NSLog (@"HomePageVC viewWillDisappear");
//    NSLog (@"self.view.frame: %@", NSStringFromCGRect(self.view.frame));
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
//    NSLog (@"HomePageVC viewDidDisappear");
//    NSLog (@"self.view.frame: %@", NSStringFromCGRect(self.view.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellReuseIdentifier = @"HomePageCellReuseIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellReuseIdentifier];
    }
    
    cell.textLabel.textColor = [UIColor darkTextColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    cell.textLabel.text = [self.dataSourceArray objectAtIndex:indexPath.row].title;
    cell.detailTextLabel.text = [self.dataSourceArray objectAtIndex:indexPath.row].subTitle;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTableViewCellHeight;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Block clickHandleBlock = [self.dataSourceArray objectAtIndex:indexPath.row].didSelectCellHandleBlock;
    if (clickHandleBlock) {
        clickHandleBlock();
    }
}


@end
