//
//  ProxyWithWeakTarget.h
//  TestTemplateProject
//
//  Created by Ben on 12/6/18.
//  Copyright (c) 2018 Ben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProxyWithWeakTarget : NSProxy

@property (nonatomic, weak) id target;

@end

NS_ASSUME_NONNULL_END
