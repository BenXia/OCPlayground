//
//  Grades+CoreDataProperties.h
//  TestTemplateProject
//
//  Created by Ben on 2021/2/26.
//  Copyright © 2021 iOSStudio. All rights reserved.
//
//

#import "Grades+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Grades (CoreDataProperties)

+ (NSFetchRequest<Grades *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *groupName;
@property (nullable, nonatomic, copy) NSNumber *id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *shortName;
@property (nonatomic) int32_t groupType;

@end

NS_ASSUME_NONNULL_END
