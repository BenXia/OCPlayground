//
//  MockTarget.h
//  TestTemplateProject
//
//  Created by Ben on 2023/11/16.
//  Copyright © 2023 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MockTarget : NSObject

@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSDate   *date;
@property (nonatomic, strong) id       opaqueObject;

@end

NS_ASSUME_NONNULL_END




