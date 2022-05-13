//
//  QQingButton.m
//  student
//
//  Created by Ben on 2021/4/27.
//

#import "QQingButton.h"

const NSString *kQqingTypeKey = @"kQqingTypeKey";

@implementation QQingButton

- (void)setCr:(CGFloat)cr {
    self.layer.cornerRadius = cr;
    self.layer.masksToBounds = YES;
}

- (void)setQqingType:(int)qqingType {
    objc_setAssociatedObject(self, @selector(qqingType), [NSNumber numberWithInt:qqingType], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self invalidateIntrinsicContentSize];
}

- (int)qqingType {
    int typeToReturn = [objc_getAssociatedObject(self, @selector(qqingType)) intValue];
    return typeToReturn;
}

- (CGSize)intrinsicContentSize {
    return self.qqingType == 1 ? CGSizeMake(100, 100) : CGSizeMake(250, 250);
//    return CGSizeMake(0, [self isTypeCombine] ? [self maxViewHeight] : 0);
}

@end
