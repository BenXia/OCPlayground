//
//  YYModelUsageVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/9/5.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "YYModelUsageVC.h"
#import "ModelForYYModel.h"

/**
 *
 *        特点                                       支持情况
 *  1.[NSNull null]                                   　✔︎
 *  2.嵌套Model                                  　      ✔︎
 *  3.NSArray中为Model                                  ✔︎
 *  4.字段需要换转处理                                  　 ✔︎
 *  5.字段 JSON 中没有                                   ✔︎
 *  6.未知字段(向后兼容）                                  ✔︎
 *  7.继承情况下多态的支持                                 ✔︎
 *  8.NSCoding 协议(持久化)的支持                         ✔︎
 *  9.异常情况: NSString <-> NSNumber                    ✔︎
 *  10.异常情况: NSString <-> NSUInteger                 ✔︎
 *  11.异常情况: NSArray <-> NSString                    ✘
 *
 */

@interface YYModelUsageVC ()

@end

@implementation YYModelUsageVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"YYModel 用法测试";
    
    // 对应模型的特点: 1、有NSNull对象, 2、模型里面嵌套模型, 3、模型里面有数组，数组里面有模型.
    self.JSONDict = [self getJSONObject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end