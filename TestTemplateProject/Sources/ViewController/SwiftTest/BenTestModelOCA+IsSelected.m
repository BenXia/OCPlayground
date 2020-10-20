//
//  BenTestModelOCA+IsSelected.m
//  TestTemplateProject
//
//  Created by Ben on 2020/10/20.
//  Copyright © 2020 iOSStudio. All rights reserved.
//

#import "BenTestModelOCA+IsSelected.h"
#import <objc/runtime.h>

static char kBenTestModelOCAForImportSelectedKey;

@implementation BenTestModelOCA (IsSelected)

- (void)setIsSelected:(BOOL)isSelected {
    objc_setAssociatedObject(self, &kBenTestModelOCAForImportSelectedKey, @(isSelected), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)isSelected {
    return [objc_getAssociatedObject(self, &kBenTestModelOCAForImportSelectedKey) boolValue];
}

@end
