//
//  UIView+UIView_InspectableExtend.m
//  student
//
//  Created by Ben on 2021/4/27.
//

#import "UIView+UIView_InspectableExtend.h"

@implementation UIView (UIView_InspectableExtend)

- (void)setCcr:(CGFloat)ccr {
    self.layer.cornerRadius = ccr;
    self.layer.masksToBounds = YES;
}

@end


