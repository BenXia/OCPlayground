//
//  ModelForMantle.h
//  TestTemplateProject
//
//  Created by Ben on 2017/8/27.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, Sex) {
    SexMale,
    SexFemale
};

@interface BookForMantle : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy, nullable) NSString *name;
@end

@interface PhoneForMantle : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy, nullable) NSString *name;
@property (nonatomic, assign) double price;
@end

@interface UserForMantle : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy, nullable) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign)  Sex sex;
@property (nonatomic, strong, nullable) NSDate *loginDate;
@property (nonatomic, strong, nullable) PhoneForMantle *phone;
@property (nonatomic, copy, nullable) NSArray<BookForMantle *> *books;
@end


