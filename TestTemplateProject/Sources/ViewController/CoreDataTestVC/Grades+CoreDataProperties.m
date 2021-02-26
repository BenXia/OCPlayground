//
//  Grades+CoreDataProperties.m
//  TestTemplateProject
//
//  Created by Ben on 2021/2/26.
//  Copyright © 2021 iOSStudio. All rights reserved.
//
//

#import "Grades+CoreDataProperties.h"

@implementation Grades (CoreDataProperties)

+ (NSFetchRequest<Grades *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Grades"];
}

@dynamic groupName;
@dynamic id;
@dynamic name;
@dynamic shortName;
@dynamic groupType;

@end
