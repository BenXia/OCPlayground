//
//  UIView+BindAction.h
//  QQingCommon
//
//  Created by Yuan Bo on 2017/12/28.
//  Copyright © 2017年 QQingiOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

 
@interface UIView (BindAction)

//便捷添加方法 不管验证是否已经添加
- (void)bindGestureAction:(void(^)(void))action;

- (void)clearAllGestureAction;

- (void)rebindGestureAction:(void(^)(void))action;


@end
