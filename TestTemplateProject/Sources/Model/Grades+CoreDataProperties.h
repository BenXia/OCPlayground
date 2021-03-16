//
//  Grades+CoreDataProperties.h
//  
//
//  Created by Ben on 2021/3/16.
//
//

#import "Grades+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Grades (CoreDataProperties)

+ (NSFetchRequest<Grades *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *groupName;
@property (nonatomic) int32_t groupType;
@property (nullable, nonatomic, copy) NSNumber *id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *shortName;

@end

NS_ASSUME_NONNULL_END
