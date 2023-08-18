//
//  WeakSet.h
//  TestTemplateProject
//
//  Created by Ben on 2023/8/18.
//  Copyright © 2023 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakSet : NSObject

/**
 *  元素个数
 */
@property (readonly)            NSUInteger  count;

/**
 *  所有对象
 */
@property (readonly, copy)      NSArray    *allObjects;

/**
 *  获取一个对象
 */
@property (readonly, nonatomic) id          anyObject;

/**
 *  获取集合
 */
@property (readonly, copy)      NSSet      *setRepresentation;

- (id)member:(id)object;
- (NSEnumerator *)objectEnumerator;
- (void)addObject:(id)object;
- (void)removeObject:(id)object;
- (void)removeAllObjects;
- (BOOL)containsObject:(id)anObject;

@end

NS_ASSUME_NONNULL_END
