//
//  JSONModelUsageVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/9/5.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "JSONModelUsageVC.h"
#import "ModelForJSONModel.h"

/**
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

@interface JSONModelUsageVC ()

@end

@implementation JSONModelUsageVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"JSONModel 用法测试";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)normalUsageCase {
//    // JSON->Model
//    UserForJSONModel *user = [[UserForJSONModel alloc] initWithDictionary:self.JSONDict error:nil];
//    // Model->JSON
//    NSDictionary *dict = [user toDictionary];
}

@end
