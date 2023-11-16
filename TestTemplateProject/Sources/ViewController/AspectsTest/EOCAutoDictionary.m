//
//  EOCAutoDictionary.m
//  TestTemplateProject
//
//  Created by Ben on 2023/11/16.
//  Copyright © 2023 iOSStudio. All rights reserved.
//

#import "EOCAutoDictionary.h"
#import <objc/runtime.h>

@interface EOCAutoDictionary ()

@property (nonatomic, strong) NSMutableDictionary *backingStore;

@end

@implementation EOCAutoDictionary

// 如果 setDate: 方法是需要等动态添加（打开@dynamic）的话，则动态添加的方法中的 _cmd 为 aspects__ 加上原始方法名前缀，需要注意一下。
// 此处即方法名会变成 aspects__setDate: （因为把原始实现放到了这个别名 selector 中）
@dynamic string, number, date, opaqueObject;

- (instancetype)init {
    if (self = [super init]) {
        _backingStore = [NSMutableDictionary new];
    }
    return self;
}

id autoDictionaryGetter(id self, SEL _cmd) {
    // Get the backing store from the object
    EOCAutoDictionary *typedSelf = (EOCAutoDictionary *)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    
    // The key is simply the selector name
    NSString *key = NSStringFromSelector(_cmd);
    
    // Return the value
    return [backingStore objectForKey:key];
}

void autoDictionarySetter(id self, SEL _cmd, id value) {
    // Get the backing store from the object
    EOCAutoDictionary *typedSelf = (EOCAutoDictionary *)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    
    /** The selector will be for example, "setOpaqueObject:".
     *  We need to remove the "set", ":" and lowercase the first
     *  letter of the remainder.
     */
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSMutableString *key = [selectorString mutableCopy];
    
    // Remove the ':' at the end
    [key deleteCharactersInRange:NSMakeRange(key.length - 1, 1)];
    
    // Remove the 'set' prefix
    // 如果 setDate: 方法是需要等动态添加的话，则动态添加的方法中的 _cmd 为 aspects__ 加上原始方法名前缀，需要注意一下。
    // 此处即方法名会变成 aspects__setDate: （因为把原始实现放到了这个别名 selector 中）
    if ([key hasPrefix:@"aspects__set"]) {
        [key deleteCharactersInRange:NSMakeRange(0, 12)];
    } else {
        [key deleteCharactersInRange:NSMakeRange(0, 3)];
    }
    
    // Lowercase the first character
    NSString *lowercaseFirstChar = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
    
    if (value) {
        [backingStore setObject:value forKey:key];
    } else {
        [backingStore removeObjectForKey:key];
    }
}

+ (BOOL)resolveInstanceMethod:(SEL)selector {
    NSString *selectorString = NSStringFromSelector(selector);
    
    if ([selectorString hasPrefix:@"set"]) {
        class_addMethod(self, selector, (IMP)autoDictionarySetter, "v@:@");
    } else {
        if ([selectorString isEqualToString:@"string"] ||
            [selectorString isEqualToString:@"number"] ||
            [selectorString isEqualToString:@"date"] ||
            [selectorString isEqualToString:@"opaqueObject"]) {
            class_addMethod(self, selector, (IMP)autoDictionaryGetter, "@@:");
        } else {
            return [super resolveInstanceMethod:selector];
        }
    }
    
    return YES;
}

@end




