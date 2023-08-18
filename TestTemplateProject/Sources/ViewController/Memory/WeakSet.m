//
//  WeakSet.m
//  TestTemplateProject
//
//  Created by Ben on 2023/8/18.
//  Copyright © 2023 iOSStudio. All rights reserved.
//

#import "WeakSet.h"

@interface WeakSet () {
    NSHashTable  *_hashTable;
}

@end

@implementation WeakSet

- (instancetype)init {
    self = [super init];
    if (self) {
        _hashTable = [NSHashTable weakObjectsHashTable];
    }
    
    return self;
}

- (id)member:(id)object {
    return [_hashTable member:object];
}

- (NSEnumerator *)objectEnumerator {
    return [_hashTable objectEnumerator];
}

- (void)addObject:(id)object {
    [_hashTable addObject:object];
}

- (void)removeObject:(id)object {
    [_hashTable removeObject:object];
}

- (void)removeAllObjects {
    [_hashTable removeAllObjects];
}

- (BOOL)containsObject:(id)anObject {
    return [_hashTable containsObject:anObject];
}

@synthesize count = _count;
- (NSUInteger)count {
    return _hashTable.count;
}

@synthesize allObjects = _allObjects;
- (NSArray *)allObjects {
    return [_hashTable allObjects];
}

@synthesize anyObject = _anyObject;
- (id)anyObject {
    return [_hashTable anyObject];
}

@synthesize setRepresentation = _setRepresentation;
- (NSSet *)setRepresentation {
    return [_hashTable setRepresentation];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", _hashTable.allObjects];
}

@end




