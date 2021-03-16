//
//  Grades+CoreDataProperties.m
//  
//
//  Created by Ben on 2021/3/16.
//
//

#import "Grades+CoreDataProperties.h"

@implementation Grades (CoreDataProperties)

+ (NSFetchRequest<Grades *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Grades"];
}

@dynamic groupName;
@dynamic groupType;
@dynamic id;
@dynamic name;
@dynamic shortName;

@end
