//
//  Case6SuperClass.h
//  TestTemplateProject
//
//  Created by Ben on 2020/11/19.
//  Copyright © 2020 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Case6SuperClass : NSObject

@end

@interface Case6ChildClass : Case6SuperClass

@end

@interface Case6AnotherClass : NSObject

- (void)doSomeMethod;

@end

NS_ASSUME_NONNULL_END


