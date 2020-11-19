//
//  Case5SuperClass.h
//  TestTemplateProject
//
//  Created by Ben on 2020/11/19.
//  Copyright © 2020 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Case5SuperClass : NSObject

@end

@interface Case5ChildClass : Case5SuperClass

@end

@interface Case5AnotherClass : NSObject

- (void)doSomeMethod;

@end

NS_ASSUME_NONNULL_END


