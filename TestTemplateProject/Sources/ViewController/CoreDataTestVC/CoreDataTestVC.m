//
//  CoreDataTestVC.m
//  TestTemplateProject
//
//  Created by Ben on 2021/2/26.
//  Copyright © 2021 iOSStudio. All rights reserved.
//

#import "CoreDataTestVC.h"
#import "Grades+CoreDataClass.h"

@interface CoreDataTestVC ()

@end

@implementation CoreDataTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [MagicalRecord enableShorthandMethods];
    [MagicalRecord setShouldDeleteStoreOnModelMismatch:YES];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"test.sqlite"];
}

- (void)testMultiThreadCoreData {
//    NSArray *gss = [Grades MR_findAll];
//    NSLog(@"1. gradeList: %d", gss.count);
    
    // 测试1: 主线程写，看下后台线程何时同步拿到更新数据
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), [QQingUtils coreDataOperationQueue], ^{
//        NSArray *gss = [Grades findAll];
//        NSLog(@"2. gradeList: %d", gss.count);
//    });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        dispatch_sync([QQingUtils coreDataOperationQueue], ^{
//            NSArray *gss = [Grades findAll];
//            NSLog(@"3-1. gradeList: %d", gss.count);
//        });
//
//        Grades *grades = [Grades createEntityQQ];
//        grades.id = [NSNumber numberWithInt:50];
//        grades.name = @"高中十五年级";
//        grades.shortName = @"十五年级";
//        grades.groupType = [NSNumber numberWithInt:GPBGradeGroupType_SeniorSchoolGradeGroupType];
//        grades.groupName = @"高中";
//
//        dispatch_sync([QQingUtils coreDataOperationQueue], ^{
//            NSArray *gss = [Grades findAll];
//            NSLog(@"3-2. gradeList: %d", gss.count);
//        });
//
//        [[NSManagedObjectContext defaultContextQQ] saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
//            NSArray *gss = [Grades findAll];
//            NSLog(@"3-3. gradeList: %d", gss.count);
//        }];
//
//        dispatch_sync([QQingUtils coreDataOperationQueue], ^{
//            NSArray *gss = [Grades findAll];
//            NSLog(@"3-4. gradeList: %d", gss.count);
//        });
//    });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), [QQingUtils coreDataOperationQueue], ^{
//        NSArray *gss = [Grades findAll];
//        NSLog(@"4. gradeList: %d", gss.count);
//    });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        NSArray *gss = [Grades findAll];
//        NSLog(@"5. gradeList: %d", gss.count);
//    });
    
    
    // 测试2: 后台线程写，看下主线程何时同步拿到更新数据
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSArray *gss = [Grades findAll];
//        NSLog(@"2. gradeList: %d", gss.count);
//    });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), [QQingUtils coreDataOperationQueue], ^{
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSArray *gss = [Grades findAll];
//            NSLog(@"3-1. gradeList: %d", gss.count);
//        });
//
//        Grades *grades = [Grades createEntityQQ];
//        grades.id = [NSNumber numberWithInt:50];
//        grades.name = @"高中十五年级";
//        grades.shortName = @"十五年级";
//        grades.groupType = [NSNumber numberWithInt:GPBGradeGroupType_SeniorSchoolGradeGroupType];
//        grades.groupName = @"高中";
//
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSArray *gss = [Grades findAll];
//            NSLog(@"3-2. gradeList: %d", gss.count);
//        });
//
//        [[NSManagedObjectContext contextForCurrentThread] saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
//            NSArray *gss = [Grades findAll];
//            NSLog(@"3-3. gradeList: %d", gss.count);
//        }];
//
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSArray *gss = [Grades findAll];
//            NSLog(@"3-4. gradeList: %d", gss.count);
//        });
//    });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSArray *gss = [Grades findAll];
//        NSLog(@"4. gradeList: %d", gss.count);
//    });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        NSArray *gss = [Grades findAll];
//        NSLog(@"5. gradeList: %d", gss.count);
//    });
}

@end


