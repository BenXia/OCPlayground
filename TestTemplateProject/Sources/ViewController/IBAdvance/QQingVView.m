//
//  QQingVView.m
//  student
//
//  Created by Ben on 2021/4/27.
//

#import "QQingVView.h"

@implementation QQingVView

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setCr:(CGFloat)cr {
    self.layer.cornerRadius = cr;
    self.layer.masksToBounds = YES;
}

@end


