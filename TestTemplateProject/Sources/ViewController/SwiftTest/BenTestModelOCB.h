//
//  BenTestModelOCB.h
//  teacher
//
//  Created by Ben on 2019/7/24.
//

#import <Foundation/Foundation.h>
#import "BenTestModelOCC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BenTestModelOCB : NSObject

@property (nonatomic, assign) BOOL adjusted;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) BenTestModelOCC *objC;

@end

NS_ASSUME_NONNULL_END
