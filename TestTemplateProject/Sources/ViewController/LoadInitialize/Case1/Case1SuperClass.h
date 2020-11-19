//
//  Case1SuperClass.h
//  TestTemplateProject
//
//  Created by Ben on 2020/11/19.
//  Copyright © 2020 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Case1SuperClass : NSObject

@end

@interface Case1ChildClass : Case1SuperClass

@end

@interface Case1AnotherClass : NSObject

- (void)doSomeMethod;

@end

NS_ASSUME_NONNULL_END


