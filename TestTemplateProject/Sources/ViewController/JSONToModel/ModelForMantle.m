//
//  ModelForMantle.m
//  TestTemplateProject
//
//  Created by Ben on 2017/8/27.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "ModelForMantle.h"

@implementation PhoneForMantle

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"name" : @"name",
             @"price" : @"price"};
}

@end

@implementation BookForMantle

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"name" : @"name"};
}

@end

@implementation UserForMantle

// 该map不光是JSON->Model, Model->JSON也会用到
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"name" : @"name",
             @"age" : @"age",
             @"sex" : @"sex",
             @"loginDate" : @"login_date",
             @"phone" : @"phone",
             @"books" : @"books"};
}

// 模型里面的模型
+ (NSValueTransformer *)phoneTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[PhoneForMantle class]];
}

// 模型里面的数组
+ (NSValueTransformer *)booksTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[BookForMantle class]];
}

// 时间
+ (NSValueTransformer *)loginDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *timeIntervalSince1970, BOOL *success, NSError *__autoreleasing *error) {
        NSTimeInterval timeInterval = [timeIntervalSince1970 doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        return date;
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        NSTimeInterval timeInterval = date.timeIntervalSince1970;
        return @(timeInterval).stringValue;
    }];
}

@end


