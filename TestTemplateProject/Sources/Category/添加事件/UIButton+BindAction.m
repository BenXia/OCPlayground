//
//  UIButton+BindAction.m
//  QQingCommon
//
//  Created by zhouyihua on 16/03/2017.
//  Copyright © 2017 QQingiOSTeam. All rights reserved.
//

#import "UIButton+BindAction.h"
#import "ReactiveObjC.h"
#import <objc/runtime.h>

static const NSInteger tagOfBind = 9996;
static char kDisposableKey;

 
@interface UIButton()

@property (strong, nonatomic) RACDisposable *disposable;

@end

@implementation UIButton (BindAction)

- (void)bindOrOverrideAction:(void(^)(void))action {
    [self.disposable dispose];
    self.disposable = [[[self rac_signalForControlEvents:UIControlEventTouchUpInside] deliverOnMainThread] subscribeNext:^(id x) {
        action ? action() : nil;
    }];
}

- (UIButton *)bindAction:(void(^)(void))action {
    if (! [self hasBind]) {
        [[[self rac_signalForControlEvents:UIControlEventTouchUpInside] deliverOnMainThread] subscribeNext:^(id x) {
            
            action ? action() : nil;
        }];
    }
    return self;
}

- (BOOL)hasBind {
    if (self.tag == tagOfBind) {
        return YES;
    } else {
        self.tag = tagOfBind;
        return NO;
    }
}

- (void)setDisposable:(RACDisposable *)disposable {
    objc_setAssociatedObject(self, &kDisposableKey,
                             disposable,
                             OBJC_ASSOCIATION_ASSIGN);
}

- (RACDisposable *)disposable {
    return objc_getAssociatedObject(self, &kDisposableKey);
}

@end


