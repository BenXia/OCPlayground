//
//  ModelForJSONModel.h
//  TestTemplateProject
//
//  Created by Ben on 2017/8/27.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BookForJsonModel
@end

@interface BookForJSONModel : JSONModel
@property (nonatomic, copy, nullable) NSString *name;
@end

// PhoneForJSONModel
@interface PhoneForJSONModel : JSONModel
@property (nonatomic, copy, nullable) NSString *name;
@property (nonatomic, assign) double price;
@end

// UserForJSONModel
@interface UserForJSONModel : JSONModel
@property (nonatomic, copy, nullable) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) BOOL sex;
@property (nonatomic, strong, nullable) NSDate *loginDate;
@property (nonatomic, strong, nullable) PhoneForJSONModel *phone;
// 注意协议
@property (nonatomic, copy, nullable) NSArray<BookForJsonModel> *books;

@end


