//
//  UIButton+BindAction.h
//  QQingCommon
//
//  Created by zhouyihua on 16/03/2017.
//  Copyright © 2017 QQingiOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

 
@interface UIButton (BindAction)

// 目前以 tag 作为是否绑定的标记，以后在改吧（主线程操作）
- (UIButton *)bindAction:(void(^)(void))action;

- (void)bindOrOverrideAction:(void(^)(void))action;

@end


