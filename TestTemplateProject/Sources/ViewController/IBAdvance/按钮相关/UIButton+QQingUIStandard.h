//
//  UIButton+QQingUIStandard.h
//  QQingCommon
//
//  Created by Ben on 2021/4/29.
//  Copyright © 2021 QQingiOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 按钮控件规范
// https://lanhuapp.com/web/#/item/project/stage?pid=d82d477a-a7a0-4aaf-9c32-3d601a2d8cb9&image_id=9d372e47-24e9-4595-b5f4-6107e29cbc59
// 暂时不支持设置阴影，如果需要阴影需要自己添加一个兄弟视图设置阴影

@interface UIButton (QQingUIStandard)

#pragma mark - 置底按钮

// 单个实心蓝色
- (void)configAsQQingBottomSingleSolidBlue;

// 单个实心橙色
- (void)configAsQQingBottomSingleSolidOrange;

// 多个按钮时候的自由宽度实心蓝色
- (void)configAsQQingBottomSolidBlue;

// 多个按钮时候的自由宽度实心橙色
- (void)configAsQQingBottomSolidOrange;

// 多个按钮时候的自由宽度纯文字按钮
- (void)configAsQQingBottomPureText;

// 多个按钮时候的左边蓝色边框按钮
- (void)configAsQQingBottomBorderBlue;

// 多个按钮时候的左边橙色边框按钮
- (void)configAsQQingBottomBorderOrange;

#pragma mark - 页中按钮

- (void)configAsQQingLargeSolidBlue;
- (void)configAsQQingLargeSolidOrange;

- (void)configAsQQingMiddleSolidBlue;
- (void)configAsQQingMiddleBorderBlue;
- (void)configAsQQingMiddleBorderBlueWhenHasShadow;    // 注意这个方法不会加阴影，因为带阴影的边框颜色和不带阴影不一样，所以和 configAsQQingMiddleBorderBlue 方法不一样
- (void)configAsQQingMiddleBorderGray;

- (void)configAsQQingNormalSolidBlue;
- (void)configAsQQingNormalBorderBlue;
- (void)configAsQQingNormalBorderBlueWhenHasShadow;    // 注意这个方法不会加阴影，因为带阴影的边框颜色和不带阴影不一样，所以和 configAsQQingNormalBorderBlue 方法不一样
- (void)configAsQQingNormalBorderGray;

- (void)configAsQQingSmallSolidBlue;
- (void)configAsQQingSmallBorderBlue;
- (void)configAsQQingSmallBorderBlueWhenHasShadow;     // 注意这个方法不会加阴影，因为带阴影的边框颜色和不带阴影不一样，所以和 configAsQQingSmallBorderBlue 方法不一样
- (void)configAsQQingSmallBorderGray;

- (void)configAsQQingMiniSolidBlue;
- (void)configAsQQingMiniBorderBlue;
- (void)configAsQQingMiniBorderGray;

#pragma mark - 通用方法

// 渐变背景按钮设置方法
- (void)easySetupUIWithNormalBgGradientColors:(NSArray *)normalBgGradientColors
                   normalBgGradientStartPoint:(CGPoint)normalBgGradientStartPoint
                     normalBgGradientEndPoint:(CGPoint)normalBgGradientEndPoint
                         normalBgGradientSize:(CGSize)normalBgGradientSize
                      disableBgGradientColors:(NSArray *)disableBgGradientColors
                  disableBgGradientStartPoint:(CGPoint)disableBgGradientStartPoint
                    disableBgGradientEndPoint:(CGPoint)disableBgGradientEndPoint
                        disableBgGradientSize:(CGSize)disableBgGradientSize
                            selectedIconImage:(nullable UIImage *)selectedIconImage
                                    titleFont:(UIFont *)titleFont
                               titleFontColor:(UIColor *)titleFontColor
                                 cornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END


