//
//  BenTestModelOCA.h
//  teacher
//
//  Created by Ben on 2019/7/24.
//

#import <Foundation/Foundation.h>
#import "BenTestModelOCB.h"

NS_ASSUME_NONNULL_BEGIN

@interface BenTestModelOCA : NSObject

@property (nonatomic, assign) BOOL adjusted;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) BenTestModelOCB *objB;

@end

NS_ASSUME_NONNULL_END
