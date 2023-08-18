//
//  WeakArray.h
//  TestTemplateProject
//
//  Created by Ben on 2023/8/18.
//  Copyright © 2023 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakArray : NSObject

@property (readonly, copy) NSArray    *allObjects;
@property (readonly)       NSUInteger  count;

- (id)objectAtIndex:(NSUInteger)index;
- (void)addObject:(id)object;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)insertObject:(id)object atIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withPointer:(id)object;
- (void)compact;

@end

NS_ASSUME_NONNULL_END




