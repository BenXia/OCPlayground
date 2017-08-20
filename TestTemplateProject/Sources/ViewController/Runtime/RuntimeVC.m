//
//  RuntimeVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/8/20.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "RuntimeVC.h"
#import "Person.h"
#import <objc/runtime.h>

@interface RuntimeVC ()

@end

@implementation RuntimeVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    Person* p = [[Person alloc] init];
    p.cjmAge = 20;
    p.cjmName = @"Jiaming Chen";
    
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([p class], &propertyCount);
    for (int i = 0; i < propertyCount; i++) {
        const char* name = property_getName(propertyList[i]);
        const char* attributes = property_getAttributes(propertyList[i]);
        NSLog(@"%s %s", name, attributes);
    }
    objc_property_attribute_t attributes = {
        "T@\"NSString\",C,N,V_studentIdentifier",
        "",
    };
    class_addProperty([p class], "studentIdentifier", &attributes, 1);
    objc_property_t property = class_getProperty([p class], "studentIdentifier");
    NSLog(@"%s %s", property_getName(property), property_getAttributes(property));
    
    propertyList = class_copyPropertyList([p class], &propertyCount);
    for (int i = 0; i < propertyCount; i++) {
        const char* name = property_getName(propertyList[i]);
        const char* attributes = property_getAttributes(propertyList[i]);
        NSLog(@"%s %s", name, attributes);
    }
    
    NSLog (@"p.age: %ld", p.cjmAge);
    //NSLog (@"p.studentIdentifier: %@", p.studentIdentifier);  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


