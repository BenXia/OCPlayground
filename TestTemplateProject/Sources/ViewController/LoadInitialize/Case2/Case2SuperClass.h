//
//  Case2SuperClass.h
//  TestTemplateProject
//
//  Created by Ben on 2020/11/19.
//  Copyright © 2020 iOSStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Case2SuperClass : NSObject

@end

@interface Case2ChildClass : Case2SuperClass

@end

@interface Case2AnotherClass : NSObject

- (void)doSomeMethod;

@end

NS_ASSUME_NONNULL_END


