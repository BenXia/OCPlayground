//
//  Case3SuperClass.h
//  TestTemplateProject
//
//  Created by Ben on 2020/11/19.
//  Copyright © 2020 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Case3SuperClass : NSObject

@end

@interface Case3ChildClass : Case3SuperClass

@end

@interface Case3AnotherClass : NSObject

- (void)doSomeMethod;

@end

NS_ASSUME_NONNULL_END


