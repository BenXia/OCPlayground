//
//  UIView+BindAction.m
//  QQingCommon
//
//  Created by Yuan Bo on 2017/12/28.
//  Copyright © 2017年 QQingiOSTeam. All rights reserved.
//

#import "UIView+BindAction.h"
#import "ReactiveObjC.h"

@implementation UIView (BindAction)

- (void)bindGestureAction:(void(^)(void))action {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        if (action) {
            action();
        }
    }];
    [self addGestureRecognizer:tap];
    
}

- (void)clearAllGestureAction{
    NSArray *array = self.gestureRecognizers;
    for (UIGestureRecognizer *gens in array) {
        [self removeGestureRecognizer:gens];
    }
    
}

- (void)rebindGestureAction:(void(^)(void))action{
    [self clearAllGestureAction];
    [self bindGestureAction:action];
}

@end
