//
//  HomePageVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/5/23.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "HomePageVC.h"
#import "PlaygroundVC.h"
#import "ClassPropertyVC.h"
#import "CategoryVC.h"
#import "LoadInitializeVC.h"
#import "ProxyTestVC.h"
#import "SafePushTestVC.h"
#import "RuntimeVC.h"
#import "AspectsTestVC.h"
#import "TimeSequenceVC.h"
#import "JSONToModelVC.h"
#import "BlockTestVC.h"
#import "SingletonVC.h"
#import "MultiThreadVC.h"
#import "CoreDataTestVC.h"
#import "RunLoopVC.h"
#import "MemoryManageVC.h"
#import "ARCVC.h"
#import "TaggedPointerTestVC.h"
#import "RACMLKVC.h"
#import "CrashTestVC.h"
#import "NoXibVC.h"
#import "BOOLTestVC.h"
#import "TextImageVC.h"
#import "CustomContainerVC.h"
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
    
    HomePageCellModel *model2 = [HomePageCellModel modelWithTitle:@"类属性"
                                                         subTitle:@"类属性的详细实现"
                                                          vcClass:[ClassPropertyVC class]
                                                     navigationVC:self.navigationController];
    
    // 知识点：self.xxx = nil 在 MRC 中就会对 self.xxx 执行 release 操作
    HomePageCellModel *model3 = [HomePageCellModel modelWithTitle:@"Category"
                                                         subTitle:@"测试一下 Category 中重写 dealloc 方法"
                                                          vcClass:[CategoryVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model4 = [HomePageCellModel modelWithTitle:@"Load & Initialize"
                                                         subTitle:@"调用时机、继承特性、类别定义等对比"
                                                          vcClass:[LoadInitializeVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model5 = [HomePageCellModel modelWithTitle:@"NSProxy"
                                                          subTitle:@"代理解决一些内存管理问题"
                                                           vcClass:[ProxyTestVC class]
                                                      navigationVC:self.navigationController];
    
    HomePageCellModel *model6 = [HomePageCellModel modelWithTitle:@"SafePush"
                                                          subTitle:@"SafePush一些测试"
                                                           vcClass:[SafePushTestVC class]
                                                      navigationVC:self.navigationController];
    
    // 知识点：换实现时候需要考虑，originSelector 继承链上没有，
    //        或者当前子类没有只有父类有的情况，exchange(impl1,impl2) 有空实现能交换成功，
    //        replace(method, impl) 时 impl 为空会无法 replace
    //
    // 知识点：struct object + obj_msgSend + struct super + 函数调用压栈出栈过程 + 大小端
    //
    //        实参占用调用者的栈空间，形参(如果是指针可能编译器优化成不占用)占用被调用者的栈空间
    //        (https://zhuanlan.zhihu.com/p/372748418)
    //        ((oldOldEbp), 形参, 局部变量, 实参n, ...实参1, 下一条指令地址, (oldEbp), 形参1, ...形参n, 局部变量...)
    //                      oldEbp                                               ebp                      esp
    //        ((oldOldEbp), 形参, 局部变量, 实参n, ...实参1, 下一条指令地址)
    //                      ebp                                      esp
    //
    //        函数返回时会恢复到调用者栈帧（函数返回值一般通过 eax（有时候 eax 加上 ebx) 寄存器保存）
    //        movl %ebp, %esp
    //        popl %ebp
    //
    //        低-低-小端（x86和一般的OS（如windows，FreeBSD，Linux）使用的是小端模式，iOS 基于 ARM 的 CPU 是小端模式）
    //        低-高-大端（Mac OS是大端模式 和 网络传输中采用大端模式）
    //
    // 知识点：class_copyPropertyList 只打印该 class 上自己的属性，不打印父类的
    //
    // 知识点：[obj class] 与 object_getClass(obj) 的区别
    //
    // 知识点：objc_getClass("xxx") 获取指向类对象的 isa 指针
    //        objc_getMetaClass("xxx") 获取指向元类对象的 isa 指针
    //
    // 知识点：[super xxx]; 会被转化为 obj_msgSendSuper(struct objc_super * superInfo = &info, SEL sel) 的调用
    //
    //       obj_msgSendSuper 的实现中通过传入的 superInfo->super_class 去这个类对象及其 super 类对象链中查找 sel 实现
    //       并在找到后调用 obj_msgSend(superInfo->receiver, sel) 执行
    //
    // 知识点：class: 任何一个类调用class方法：目的是获取方法调用者的类型
    //        superclass: 任何一个类调用superclass方法：目的是获取方法调用者的父类
    //        super: 不是指针，编译器指示符，表示去调用父类的方法，本质还是当前对象去调用父类方法
    //        ⚠️注意⚠️：super不是父类对象，仅仅是一个指向父类方法标志
    //
    // 知识点：runtime 的整个类、原类的图中的 isa、super_class 指向关系
    //
    // 知识点：+(xxx)xxx 与 -(xxx)xxx 方法只是分别被放在原类和类的对象的 method_list 中
    //        消息转发机制根据调用类方法和实例方法
    //        从 self->isa (类方法调用时候 self 为类对象，实例方法调用时候 self 为实例对象) 的对象及
    //        向上的 super 类对象链中递归查找 method_list 中有没有 selector 实现
    //
    // 知识点：给已经存在的类动态添加 property 和存储变量是不允许的，调用 valueForKey: 时候会崩溃
    
    HomePageCellModel *model7 = [HomePageCellModel modelWithTitle:@"runtime"
                                                         subTitle:@"运行时浅析"
                                                          vcClass:[RuntimeVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model8 = [HomePageCellModel modelWithTitle:@"Aspects"
                                                         subTitle:@"Aspects源码学习"
                                                          vcClass:[AspectsTestVC class]
                                                     navigationVC:self.navigationController];
    
    // 知识点： @unsafeify(self) 可避免 weak 表已经置为 nil 的情况
    HomePageCellModel *model9 = [HomePageCellModel modelWithTitle:@"时序"
                                                         subTitle:@"KVO、通知、RACSignal的时序研究"
                                                          vcClass:[TimeSequenceVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model10 = [HomePageCellModel modelWithTitle:@"字典转模型"
                                                         subTitle:@"JSONModel、Mantle、YYModel、MJExtension使用对比"
                                                          vcClass:[JSONToModelVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model11 = [HomePageCellModel modelWithTitle:@"Block测试"
                                                          subTitle:@"Block一些有趣测试"
                                                           vcClass:[BlockTestVC class]
                                                      navigationVC:self.navigationController];
    
    // 知识点： dispatch_once(&onceToken, ^{}) 同一个线程递归出现调用，会死锁
    HomePageCellModel *model12 = [HomePageCellModel modelWithTitle:@"单例注意点"
                                                         subTitle:@"在单例初始化时一定不能出现对单例的引用"
                                                          vcClass:[SingletonVC class]
                                                     navigationVC:self.navigationController];
    
    // 知识点：NSInvocationOperation/NSBlockOperation/CustomOperation
    //        1.start 调用情况下，会在执行 start 的线程中调用
    //        2.除了addExecutionBlock的NSBlockOperation特殊情况的 Operation 添加到主队列中执行，
    //          会在主线程串行执行，主线程中第一个 addBlock：的任务一般当时就开始调度执行，
    //          来不及 cancel/cancelAllOperations
    //        3.除了addExecutionBlock的NSBlockOperation特殊情况的添加到自定义队列中执行，
    //          会在后台线程并发执行，第一个 addBlock: 后只要任务还未调度执行，
    //          来的及 cancel/cancelAllOperations
    //        4.如果是添加到 mainQueue 中，其中 blockOperationWithBlock 中的任务肯定在主线程执行，
    //          addExecutionBlock 添加的任务不一定在创建该op的线程中执行，而且是并行的。
    //          但是 [NSOperationQueue.currentQueue isEqual:NSOperationQueue.mainQueue]）
    //        5.如果添加到新建的 operationQueue，其中 blockOperationWithBlock 中的任务
    //          和 addExecutionBlock 添加的任务可能会在其他线程中执行
    
    // 知识点：依赖关系的设置需要在任务添加到队列之前
    //        mainQueue 或者 maxConcurrentOperationCount为1的 operationQueue 可能会因为设置依赖，
    //        导致执行顺序和添加到队列中的顺序不一致
    
    // 知识点：多线程操作 self.intA = self.intA + 1; 即使属性是 atomic 也不能保证多线程安全，
    //        即读又写，需要锁来保证一段原子操作区域。
    
    // 知识点：多线程操作 self.videoPath = [NSString stringXXX...];
    //        如果属性不是 atomic 可能会导致同一个旧值被多个线程连续的 release，引起 crash
    
    // 知识点：在大部分情况下（派发到自定义serialQueue、系统globalQueue、自定义concurrentQueue时）
    //        dispatch_sync 所派发的 block 的执行线程和 dispatch_sync 上下文线程是同一个线程，
    //        只在派发到 dispatch_get_main_queue() 时情况有特殊，根据当前是主线程/非主线程，
    //        分别是死锁和 block 在主线程执行
    //
    // 知识点：因为 dispatch_sync 上述大部分情况下避免多线程切换的优化
    //        派发到自定义 serialQueue 不一定都在某一个线程中执行
    //        派发到系统 globalQueue、自定义 concurrentQueue 也不一定都在后台线程中执行
    //
    // 知识点：避免 dispatch_sync 在某个 serialQueue 中任务调用 dispatch_sync(serialQueue, ***) 引起死锁
    //
    // 知识点：测试 dispatch_sync + 自定义serialQueue，也可以起到线程安全的作用
    //        即使是 dispatch_sync(自定义serialQueue, ^{...}); 在调用时会优化成 block 在当前线程执行，
    //        避免线程切换，导致在不同线程中执行 block
    //        但是依然会保证所有 dispatch_sync 到该 serialQueue 的 block 会串行执行，保证线程安全

    // 知识点：可以通过资源信号量控制并发队列会并发的任务数量上限，避免使用过多的 concurrent_thread

    // 知识点：默认 dispatch_queue_create 函数生成的 Dispatch Queue 
    //        不管是 Serial Dispatch Queue 还是 Concurrent Dispatch Queue,
    //        都使用与默认优先级 Global Dispatch Queue 相同执行优先级的线程。
    //        而变更生成的 Dispatch Queue 的执行优先级要使用 dispatc_set_target_queue 函数。
    //
    // 知识点：dispatch_set_target_queue(concurrentQueue/serialQueue, dispatch_get_main_queue());
    //        则该 concurrentQueue/serialQueue 中还未执行的 block 会在主线程执行

    // 知识点：经典的多读一写互斥问题
    //        concurrentQueue + dispatch_async + dispatch_barrier_async
    //        pthread_rwlock_t
    //        两个互斥锁 pthread_mutex_t（操作系统书中有介绍）
    //        连个互斥锁 sem_t （操作系统书中有介绍）
    //        使用条件变量+互斥锁来实现。注意：条件变量必须和互斥锁一起使用，等待、释放的时候需要加锁。

    // 知识点：多线程数据竞争问题（多个线程更新相同的资源会导致数据的不一致）
    //        1.使用 gcd 的 serial queue，保证在一个线程中执行，可避免数据竞争问题
    //        2.dispatch_barrier_async
    //        3.dispatch_semaphore
    //        4.Lock
    //        5.mutext
    //        6.@synchronized() {}
    //        7.atomic function
    //        8.dispatch_once
    
    HomePageCellModel *model13 = [HomePageCellModel modelWithTitle:@"多线程"
                                                          subTitle:@"多线程一些有趣的测试"
                                                           vcClass:[MultiThreadVC class]
                                                      navigationVC:self.navigationController];
    
    HomePageCellModel *model14 = [HomePageCellModel modelWithTitle:@"CoreData"
                                                          subTitle:@"CoreData多线程测试"
                                                           vcClass:[CoreDataTestVC class]
                                                      navigationVC:self.navigationController];
    
    HomePageCellModel *model15 = [HomePageCellModel modelWithTitle:@"RunLoop"
                                                         subTitle:@"测试一些看源码产生的疑问"
                                                          vcClass:[RunLoopVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model16 = [HomePageCellModel modelWithTitle:@"Swift测试"
                                                          subTitle:@"Swift一些有趣测试"
                                                           vcClass:[SwiftBenTestVC class]
                                                      navigationVC:self.navigationController];
    
    
    // 知识点：迭代器访问中修改了集合，会导致迭代器重新计算迭代中间状态，方便后面迭代
    HomePageCellModel *model17 = [HomePageCellModel modelWithTitle:@"内存管理"
                                                          subTitle:@"内存管理各种测试"
                                                           vcClass:[MemoryManageVC class]
                                                      navigationVC:self.navigationController];
    
    HomePageCellModel *model18 = [HomePageCellModel modelWithTitle:@"内存管理"
                                                          subTitle:@"MRC/ARC混编测试"
                                                           vcClass:[ARCVC class]
                                                      navigationVC:self.navigationController];
    
    HomePageCellModel *model19 = [HomePageCellModel modelWithTitle:@"TaggedPointer"
                                                          subTitle:@"TaggedPointer对象测试"
                                                           vcClass:[TaggedPointerTestVC class]
                                                      navigationVC:self.navigationController];
    
    HomePageCellModel *model20 = [HomePageCellModel modelWithTitle:@"RAC内存泄漏"
                                                          subTitle:@"RAC中经典内存泄漏问题"
                                                           vcClass:[RACMLKVC class]
                                                      navigationVC:self.navigationController];
    
    HomePageCellModel *model21 = [HomePageCellModel modelWithTitle:@"crash 测试"
                                                         subTitle:@"测试点击 cell 触发 dimissVC"
                                                          vcClass:[CrashTestVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model22 = [HomePageCellModel modelWithTitle:@"纯代码ViewController"
                                                         subTitle:@"生命周期研究"
                                                          vcClass:[NoXibVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model23 = [HomePageCellModel modelWithTitle:@"BOOL's sharp corners"
                                                         subTitle:@"32位真机上 BOOL 与 bool 的区别"
                                                          vcClass:[BOOLTestVC class]
                                                     navigationVC:self.navigationController];
    
    HomePageCellModel *model24 = [HomePageCellModel modelWithTitle:@"图文混排"
                                                          subTitle:@"图文混排一些实现方式"
                                                           vcClass:[TextImageVC class]
                                                      navigationVC:self.navigationController];
    
    HomePageCellModel *model25 = [HomePageCellModel modelWithTitle:@"容器视图"
                                                          subTitle:@"自定义容器视图研究"
                                                           vcClass:[CustomContainerVC class]
                                                      navigationVC:self.navigationController];

    HomePageCellModel *model26 = [HomePageCellModel modelWithTitle:@"IB高级用法"
                                                          subTitle:@"IBInspectable/IBDesignable"
                                                           vcClass:[Test2021QQingUIVC class]
                                                      navigationVC:self.navigationController];
    
    self.dataSourceArray = [NSArray arrayWithObjects:model1, model2, model3, model4, model5, model6, model7, model8, model9, model10, model11, model12, model13, model14, model15, model16, model17, model18, model19, model20, model21, model22, model23, model24, model25, model26, nil];
    
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
    
    if (indexPath.row == 1) {
        CrashTestVC *vc = [[CrashTestVC alloc] init];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:^{}];
        return;
    }
    Block clickHandleBlock = [self.dataSourceArray objectAtIndex:indexPath.row].didSelectCellHandleBlock;
    if (clickHandleBlock) {
        clickHandleBlock();
    }
}


@end
