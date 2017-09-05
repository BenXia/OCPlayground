//
//  ModelForJSONModel.m
//  TestTemplateProject
//
//  Created by Ben on 2017/8/27.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "ModelForJSONModel.h"

@implementation BookForJSONModel
// 前面是服务器字段，后面是模型属性字段
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"name" : @"name"
                                                       }];
}
@end

@implementation PhoneForJSONModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"name" : @"name",
                                                       @"price" : @"price"
                                                       }];
}
@end

@implementation UserForJSONModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"name" : @"name",
                                                       @"age" : @"age",
                                                       @"sex" : @"sex",
                                                       @"login_date" : @"loginDate",
                                                       @"phone" : @"phone",
                                                       @"books" : @"books"
                                                       }];
}

// 允许所有字段为空
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end


