//
//  CoreDataTestVC.m
//  TestTemplateProject
//
//  Created by Ben on 2021/2/26.
//  Copyright © 2021 iOSStudio. All rights reserved.
//

#import "CoreDataTestVC.h"
#import "Grades+CoreDataClass.h"
//#import <MagicalRecord/MagicalRecord+ShorthandMethods.h>

@interface CoreDataTestVC ()

@end

@implementation CoreDataTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 最新版本不支持缩写
//    [MagicalRecord enableShorthandMethods];
    [MagicalRecord setShouldDeleteStoreOnModelMismatch:YES];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"test.sqlite"];
    
    [self testMultiThreadCoreData];
}

- (void)testMultiThreadCoreData {
    NSArray *gss = [Grades MR_findAll];
    NSLog(@"1. gradeList: %tu", gss.count);
    
    // ⚠️：3-3 和 3-4 的顺序
    
    // 测试1: 主线程写，看下后台线程何时同步拿到更新数据
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), [CommonUtils coreDataOperationQueue], ^{
//        NSArray *gss = [Grades MR_findAll];
//        NSLog(@"2. gradeList: %tu", gss.count);
//    });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        dispatch_sync([CommonUtils coreDataOperationQueue], ^{
//            NSArray *gss = [Grades MR_findAll];
//            NSLog(@"3-1. gradeList: %tu", gss.count);
//        });
//
//        Grades *grades = [Grades MR_createEntity];
//        grades.id = [NSNumber numberWithInt:50];
//        grades.name = @"高中十五年级";
//        grades.shortName = @"十五年级";
//        grades.groupType = 3; //[NSNumber numberWithInt:3];
//        grades.groupName = @"高中";
//
//        dispatch_sync([CommonUtils coreDataOperationQueue], ^{
//            NSArray *gss = [Grades MR_findAll];
//            NSLog(@"3-2. gradeList: %tu", gss.count);
//        });
//
//        [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
//            NSArray *gss = [Grades MR_findAll];
//            NSLog(@"3-3. gradeList: %tu", gss.count);
//        }];
//
//        dispatch_sync([CommonUtils coreDataOperationQueue], ^{
//            NSArray *gss = [Grades MR_findAll];
//            NSLog(@"3-4. gradeList: %tu", gss.count);
//        });
//    });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), [CommonUtils coreDataOperationQueue], ^{
//        NSArray *gss = [Grades MR_findAll];
//        NSLog(@"4. gradeList: %tu", gss.count);
//    });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        NSArray *gss = [Grades MR_findAll];
//        NSLog(@"5. gradeList: %tu", gss.count);
//    });
    
    
    // 测试2: 后台线程写，看下主线程何时同步拿到更新数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *gss = [Grades MR_findAll];
        NSLog(@"2. gradeList: %tu", gss.count);
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), [CommonUtils coreDataOperationQueue], ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSArray *gss = [Grades MR_findAll];
            NSLog(@"3-1. gradeList: %tu", gss.count);
        });

        Grades *grades = [Grades MR_createEntity];
        grades.id = [NSNumber numberWithInt:50];
        grades.name = @"高中十五年级";
        grades.shortName = @"十五年级";
        grades.groupType = 3; //[NSNumber numberWithInt:3];
        grades.groupName = @"高中";

        dispatch_sync(dispatch_get_main_queue(), ^{
            NSArray *gss = [Grades MR_findAll];
            NSLog(@"3-2. gradeList: %tu", gss.count);
        });

        [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
            NSArray *gss = [Grades MR_findAll];
            NSLog(@"3-3. gradeList: %tu", gss.count);
        }];

        dispatch_sync(dispatch_get_main_queue(), ^{
            NSArray *gss = [Grades MR_findAll];
            NSLog(@"3-4. gradeList: %tu", gss.count);
        });
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *gss = [Grades MR_findAll];
        NSLog(@"4. gradeList: %tu", gss.count);
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSArray *gss = [Grades MR_findAll];
        NSLog(@"5. gradeList: %tu", gss.count);
    });
}

@end


