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


//                                   +(void)load               +(void)initialize
//执行时机                          在程序运行后立即执行          在类的方法第一次被调时执行
//若自身未定义，是否沿用父类的方法？             否                          是
//类别中的定义                    全都执行，但后于类中的方法        覆盖类中的方法，只执行一个


@interface LoadInitializeVC ()

@end

@implementation LoadInitializeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [Case2ChildClass load];
}

@end


