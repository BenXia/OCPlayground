//
//  LoadInitializeVC.m
//  TestTemplateProject
//
//  Created by Ben on 2020/11/19.
//  Copyright © 2020 iOSStudio. All rights reserved.
//

#import "LoadInitializeVC.h"
#import "Case2SuperClass.h"

// 类没有被引用进项目，就不会有load调用；但即使类文件被引用进来，但是没有使用，那么initialize也不会被调用。
// 可通过控制 .m 文件是否加入 target 来控制是否引用进项目


//                                   +(void)load                                                 +(void)initialize
//执行时机                          在程序运行后立即执行                                            在类的方法第一次被调时执行
//注意事项                         会阻塞应用程序启动流程。                                只有执行initialize的那个线程可以操作类或类实例。
//                             load中调用的其他类可能还未load                               其他线程都要先阻塞，等着initialize执行完。
//                         load中调用对象或类方法会引发其initialize               initialize中调用的类可能触发initialize后，其中用到当前类导致死锁
//                     Runtime调用+(void)load时没有autorelease pool

//若自身未定义，是否沿用父类的方法？    否（只相对runtime而言，手动调用还是会沿用父类）                                是
//                                不需要显式使用super调用父类中的方法                            不需要显式使用super调用父类中的方法

//类别中的定义                    全都执行，但后于类中的方法                                           覆盖类中的方法，只执行一个
//调用顺序                            父类->本类->分类                                           父类->本类(如果有分类直接调用分类，本类不会调用)
//能否保证只执行一次                   不能（用户手动调用）                                            不能（子类未定义会调用父类的）

@interface LoadInitializeVC ()

@end

@implementation LoadInitializeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Case2ChildClass 继承下了 +(void)load 而且可以被安全地当作普通类方法被使用。这也就是我之前所说的load和initialize被调用一次是相对 runtime 而言。
//    [Case2ChildClass load];
}

@end


