//
//  UIButton+QQingUIStandard.m
//  QQingCommon
//
//  Created by Ben on 2021/4/29.
//  Copyright © 2021 QQingiOSTeam. All rights reserved.
//

#import "UIButton+QQingUIStandard.h"
#import <QQingBaseConfigurationLib/BaseConfiguration.h>
#import "UIImage+Utility.h"
#import "UIImage+GIF.h"
#import "SDImageGIFCoder.h"

@implementation UIButton (QQingUIStandard)

#pragma mark - 置底按钮

// 单个实心蓝色
- (void)configAsQQingBottomSingleSolidBlue {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingBottomSingleSolidBlue 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
    
    NSString *imagePath = [[NSBundle qqingCommonBundle] pathForResource:@"icon_ongoing_small" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    //UIImage *gifImage = [UIImage sd_imageWithGIFData:imageData];
    UIImage *gifImage = [[SDImageGIFCoder sharedCoder] decodedImageWithData:imageData options:@{ SDImageCoderDecodeThumbnailPixelSize: @(CGSizeMake(16, 16)) }];
    
    // 绝对布局直接修改 frame 的 width 和 height
    CGRect frameToSet = self.frame;
    frameToSet.origin.x = 16;
    frameToSet.size.width = kScreenWidth - 32;
    frameToSet.size.height = 46;
    self.frame = frameToSet;
    
    // 相对布局修改宽度和高度的约束
    BOOL hasWidthConstraint = NO;
    BOOL hasHeightConstraint = NO;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
            constraint.constant = frameToSet.size.width;
            hasWidthConstraint = YES;
        }
        
        if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            constraint.constant = frameToSet.size.height;
            hasHeightConstraint = YES;
        }
    }
    if (!hasWidthConstraint) {
        NSLayoutConstraint *newWidthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.width];
        [self addConstraint:newWidthConstraint];
    }
    if (!hasHeightConstraint) {
        NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
        [self addConstraint:newHeightConstraint];
    }
    
    [self easySetupUIWithNormalBgGradientColors:@[[UIColor colorWithRed:67/255.0 green:199/255.0 blue:253/255.0 alpha:1.0], [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0]]
                     normalBgGradientStartPoint:CGPointMake(1, 0.5)
                       normalBgGradientEndPoint:CGPointMake(0, 0.5)
                           normalBgGradientSize:frameToSet.size
                        disableBgGradientColors:@[[UIColor colorWithRed:67/255.0 green:199/255.0 blue:253/255.0 alpha:0.5], [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:0.5]]
                    disableBgGradientStartPoint:CGPointMake(1, 0.5)
                      disableBgGradientEndPoint:CGPointMake(0, 0.5)
                          disableBgGradientSize:frameToSet.size
                            selectedIconImage:gifImage
                                    titleFont:[UIFont systemFontOfSize:16]
                               titleFontColor:[UIColor whiteColor]
                                 cornerRadius:4];
    
    self.layer.borderWidth = 0;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.layer.borderColor = [UIColor clearColor].CGColor;
}

// 单个实心橙色
- (void)configAsQQingBottomSingleSolidOrange {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingBottomSingleSolidOrange 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
    
    NSString *imagePath = [[NSBundle qqingCommonBundle] pathForResource:@"icon_ongoing_small" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    //UIImage *gifImage = [UIImage sd_imageWithGIFData:imageData];
    UIImage *gifImage = [[SDImageGIFCoder sharedCoder] decodedImageWithData:imageData options:@{ SDImageCoderDecodeThumbnailPixelSize: @(CGSizeMake(16, 16)) }];
    
    // 绝对布局直接修改 frame 的 width 和 height
    CGRect frameToSet = self.frame;
    frameToSet.origin.x = 16;
    frameToSet.size.width = kScreenWidth - 32;
    frameToSet.size.height = 46;
    self.frame = frameToSet;
    
    // 相对布局修改宽度和高度的约束
    BOOL hasWidthConstraint = NO;
    BOOL hasHeightConstraint = NO;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
            constraint.constant = frameToSet.size.width;
            hasWidthConstraint = YES;
        }
        
        if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            constraint.constant = frameToSet.size.height;
            hasHeightConstraint = YES;
        }
    }
    if (!hasWidthConstraint) {
        NSLayoutConstraint *newWidthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.width];
        [self addConstraint:newWidthConstraint];
    }
    if (!hasHeightConstraint) {
        NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
        [self addConstraint:newHeightConstraint];
    }
    
    [self easySetupUIWithNormalBgGradientColors:@[[UIColor colorWithRed:255/255.0 green:135/255.0 blue:32/255.0 alpha:1.0], [UIColor colorWithRed:255/255.0 green:159/255.0 blue:33/255.0 alpha:1.0]]
                     normalBgGradientStartPoint:CGPointMake(0, 0.5)
                       normalBgGradientEndPoint:CGPointMake(1, 0.5)
                           normalBgGradientSize:frameToSet.size
                        disableBgGradientColors:@[[UIColor colorWithRed:255/255.0 green:135/255.0 blue:32/255.0 alpha:0.5], [UIColor colorWithRed:255/255.0 green:159/255.0 blue:33/255.0 alpha:0.5]]
                    disableBgGradientStartPoint:CGPointMake(0, 0.5)
                      disableBgGradientEndPoint:CGPointMake(1, 0.5)
                          disableBgGradientSize:frameToSet.size
                            selectedIconImage:gifImage
                                    titleFont:[UIFont systemFontOfSize:16]
                               titleFontColor:[UIColor whiteColor]
                                 cornerRadius:4];
    
    self.layer.borderWidth = 0;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.layer.borderColor = [UIColor clearColor].CGColor;
}

// 多个按钮时候的自由宽度实心蓝色
- (void)configAsQQingBottomSolidBlue {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingBottomSolidBlue 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
    
    NSString *imagePath = [[NSBundle qqingCommonBundle] pathForResource:@"icon_ongoing_small" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    //UIImage *gifImage = [UIImage sd_imageWithGIFData:imageData];
    UIImage *gifImage = [[SDImageGIFCoder sharedCoder] decodedImageWithData:imageData options:@{ SDImageCoderDecodeThumbnailPixelSize: @(CGSizeMake(16, 16)) }];
    
    // 绝对布局直接修改 frame 的 width 和 height
    CGRect frameToSet = self.frame;
    frameToSet.size.height = 46;
    self.frame = frameToSet;
    
    // 相对布局修改宽度和高度的约束
    BOOL hasHeightConstraint = NO;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
            [self removeConstraint:constraint];
        }
        
        if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            constraint.constant = frameToSet.size.height;
            hasHeightConstraint = YES;
        }
    }
    if (!hasHeightConstraint) {
        NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
        [self addConstraint:newHeightConstraint];
    }
    
    [self easySetupUIWithNormalBgGradientColors:@[[UIColor colorWithRed:67/255.0 green:199/255.0 blue:253/255.0 alpha:1.0], [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0]]
                     normalBgGradientStartPoint:CGPointMake(1, 0.5)
                       normalBgGradientEndPoint:CGPointMake(0, 0.5)
                           normalBgGradientSize:frameToSet.size
                        disableBgGradientColors:@[[UIColor colorWithRed:67/255.0 green:199/255.0 blue:253/255.0 alpha:0.5], [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:0.5]]
                    disableBgGradientStartPoint:CGPointMake(1, 0.5)
                      disableBgGradientEndPoint:CGPointMake(0, 0.5)
                          disableBgGradientSize:frameToSet.size
                            selectedIconImage:gifImage
                                    titleFont:[UIFont systemFontOfSize:16]
                               titleFontColor:[UIColor whiteColor]
                                 cornerRadius:4];
    
    self.layer.borderWidth = 0;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.layer.borderColor = [UIColor clearColor].CGColor;
}

// 多个按钮时候的自由宽度实心橙色
- (void)configAsQQingBottomSolidOrange {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingBottomSolidOrange 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
    
    NSString *imagePath = [[NSBundle qqingCommonBundle] pathForResource:@"icon_ongoing_small" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    //UIImage *gifImage = [UIImage sd_imageWithGIFData:imageData];
    UIImage *gifImage = [[SDImageGIFCoder sharedCoder] decodedImageWithData:imageData options:@{ SDImageCoderDecodeThumbnailPixelSize: @(CGSizeMake(16, 16)) }];
    
    // 绝对布局直接修改 frame 的 width 和 height
    CGRect frameToSet = self.frame;
    frameToSet.size.height = 46;
    self.frame = frameToSet;
    
    // 相对布局修改宽度和高度的约束
    BOOL hasHeightConstraint = NO;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
            [self removeConstraint:constraint];
        }
        
        if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            constraint.constant = frameToSet.size.height;
            hasHeightConstraint = YES;
        }
    }
    if (!hasHeightConstraint) {
        NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
        [self addConstraint:newHeightConstraint];
    }
    
    [self easySetupUIWithNormalBgGradientColors:@[[UIColor colorWithRed:255/255.0 green:135/255.0 blue:32/255.0 alpha:1.0], [UIColor colorWithRed:255/255.0 green:159/255.0 blue:33/255.0 alpha:1.0]]
                     normalBgGradientStartPoint:CGPointMake(0, 0.5)
                       normalBgGradientEndPoint:CGPointMake(1, 0.5)
                           normalBgGradientSize:frameToSet.size
                        disableBgGradientColors:@[[UIColor colorWithRed:255/255.0 green:135/255.0 blue:32/255.0 alpha:0.5], [UIColor colorWithRed:255/255.0 green:159/255.0 blue:33/255.0 alpha:0.5]]
                    disableBgGradientStartPoint:CGPointMake(0, 0.5)
                      disableBgGradientEndPoint:CGPointMake(1, 0.5)
                          disableBgGradientSize:frameToSet.size
                            selectedIconImage:gifImage
                                    titleFont:[UIFont systemFontOfSize:16]
                               titleFontColor:[UIColor whiteColor]
                                 cornerRadius:4];
}

// 多个按钮时候的自由宽度纯文字按钮
- (void)configAsQQingBottomPureText {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingBottomPureText 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
    
    // 绝对布局直接修改 frame 的 width 和 height
    CGRect frameToSet = self.frame;
    frameToSet.size.height = 46;
    self.frame = frameToSet;
    
    // 相对布局修改宽度和高度的约束
    BOOL hasHeightConstraint = NO;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
            [self removeConstraint:constraint];
        }
        
        if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            constraint.constant = frameToSet.size.height;
            hasHeightConstraint = YES;
        }
    }
    
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    [self setBackgroundImage:nil forState:UIControlStateDisabled];
    [self setImage:nil forState:UIControlStateSelected];

    self.titleLabel.font = [UIFont systemFontOfSize:16];
    
    self.layer.borderWidth = 0;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.cornerRadius = 0;
    self.layer.masksToBounds = NO;
    
    [self setTitleColor:[UIColor colorWithRed:99/255.0 green:103/255.0 blue:108/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithRed:99/255.0 green:103/255.0 blue:108/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor colorWithRed:99/255.0 green:103/255.0 blue:108/255.0 alpha:1.0] forState:UIControlStateSelected];
}

// 多个按钮时候的左边蓝色边框按钮
- (void)configAsQQingBottomBorderBlue {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingBottomBorderBlue 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif

    // 绝对布局直接修改 frame 的 width 和 height
    CGRect frameToSet = self.frame;
    frameToSet.size.height = 46;
    self.frame = frameToSet;
    
    // 相对布局修改宽度和高度的约束
    BOOL hasHeightConstraint = NO;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
            [self removeConstraint:constraint];
        }
        
        if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            constraint.constant = frameToSet.size.height;
            hasHeightConstraint = YES;
        }
    }
    
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    [self setBackgroundImage:nil forState:UIControlStateDisabled];
    [self setImage:nil forState:UIControlStateSelected];
    
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    
    self.layer.borderWidth = ([UIScreen mainScreen].scale >= 2) ? 0.5 : 1;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.layer.borderColor = [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0].CGColor;
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    
    [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateSelected];
}

// 多个按钮时候的左边橙色边框按钮
- (void)configAsQQingBottomBorderOrange {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingBottomBorderOrange 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
 
    // 绝对布局直接修改 frame 的 width 和 height
    CGRect frameToSet = self.frame;
    frameToSet.size.height = 46;
    self.frame = frameToSet;
    
    // 相对布局修改宽度和高度的约束
    BOOL hasHeightConstraint = NO;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
            [self removeConstraint:constraint];
        }
        
        if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            constraint.constant = frameToSet.size.height;
            hasHeightConstraint = YES;
        }
    }
    
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    [self setBackgroundImage:nil forState:UIControlStateDisabled];
    [self setImage:nil forState:UIControlStateSelected];
    
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    
    self.layer.borderWidth = ([UIScreen mainScreen].scale >= 2) ? 0.5 : 1;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.layer.borderColor = [UIColor colorWithRed:255/255.0 green:118/255.0 blue:53/255.0 alpha:1.0].CGColor;
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    
    [self setTitleColor:[UIColor colorWithRed:255/255.0 green:118/255.0 blue:53/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithRed:255/255.0 green:118/255.0 blue:53/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor colorWithRed:255/255.0 green:118/255.0 blue:53/255.0 alpha:1.0] forState:UIControlStateSelected];
}

#pragma mark - 页中按钮

- (void)configAsQQingLargeSolidBlue {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingLargeSolidBlue 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
    
    NSString *imagePath = [[NSBundle qqingCommonBundle] pathForResource:@"icon_ongoing_small" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    //UIImage *gifImage = [UIImage sd_imageWithGIFData:imageData];
    UIImage *gifImage = [[SDImageGIFCoder sharedCoder] decodedImageWithData:imageData options:@{ SDImageCoderDecodeThumbnailPixelSize: @(CGSizeMake(16, 16)) }];
    
    // 绝对布局直接修改 frame 的 width 和 height
    CGRect frameToSet = self.frame;
    frameToSet.size.height = 46;
    self.frame = frameToSet;
    
    // 相对布局修改宽度和高度的约束
    BOOL hasHeightConstraint = NO;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            constraint.constant = frameToSet.size.height;
            hasHeightConstraint = YES;
        }
    }
    if (!hasHeightConstraint) {
        NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
        [self addConstraint:newHeightConstraint];
    }
    
    [self easySetupUIWithNormalBgGradientColors:@[[UIColor colorWithRed:67/255.0 green:199/255.0 blue:253/255.0 alpha:1.0], [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0]]
                     normalBgGradientStartPoint:CGPointMake(1, 0.5)
                       normalBgGradientEndPoint:CGPointMake(0, 0.5)
                           normalBgGradientSize:frameToSet.size
                        disableBgGradientColors:@[[UIColor colorWithRed:67/255.0 green:199/255.0 blue:253/255.0 alpha:0.5], [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:0.5]]
                    disableBgGradientStartPoint:CGPointMake(1, 0.5)
                      disableBgGradientEndPoint:CGPointMake(0, 0.5)
                          disableBgGradientSize:frameToSet.size
                            selectedIconImage:gifImage
                                    titleFont:[UIFont systemFontOfSize:16]
                               titleFontColor:[UIColor whiteColor]
                                 cornerRadius:frameToSet.size.height/2];
}
- (void)configAsQQingLargeSolidOrange {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingLargeSolidOrange 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
    
    NSString *imagePath = [[NSBundle qqingCommonBundle] pathForResource:@"icon_ongoing_small" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    //UIImage *gifImage = [UIImage sd_imageWithGIFData:imageData];
    UIImage *gifImage = [[SDImageGIFCoder sharedCoder] decodedImageWithData:imageData options:@{ SDImageCoderDecodeThumbnailPixelSize: @(CGSizeMake(16, 16)) }];
    
    // 绝对布局直接修改 frame 的 width 和 height
    CGRect frameToSet = self.frame;
    frameToSet.size.height = 46;
    self.frame = frameToSet;
    
    // 相对布局修改宽度和高度的约束
    BOOL hasHeightConstraint = NO;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            constraint.constant = frameToSet.size.height;
            hasHeightConstraint = YES;
        }
    }
    if (!hasHeightConstraint) {
        NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
        [self addConstraint:newHeightConstraint];
    }
    
    [self easySetupUIWithNormalBgGradientColors:@[[UIColor colorWithRed:255/255.0 green:135/255.0 blue:32/255.0 alpha:1.0], [UIColor colorWithRed:255/255.0 green:159/255.0 blue:33/255.0 alpha:1.0]]
                     normalBgGradientStartPoint:CGPointMake(0, 0.5)
                       normalBgGradientEndPoint:CGPointMake(1, 0.5)
                           normalBgGradientSize:frameToSet.size
                        disableBgGradientColors:@[[UIColor colorWithRed:255/255.0 green:135/255.0 blue:32/255.0 alpha:0.5], [UIColor colorWithRed:255/255.0 green:159/255.0 blue:33/255.0 alpha:0.5]]
                    disableBgGradientStartPoint:CGPointMake(0, 0.5)
                      disableBgGradientEndPoint:CGPointMake(1, 0.5)
                          disableBgGradientSize:frameToSet.size
                            selectedIconImage:gifImage
                                    titleFont:[UIFont systemFontOfSize:16]
                               titleFontColor:[UIColor whiteColor]
                                 cornerRadius:frameToSet.size.height/2];
}

- (void)configAsQQingMiddleSolidBlue {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingMiddleSolidBlue 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
    
    @weakify(self);
    [[RACObserve(self, titleLabel.text) onMainThread] subscribeNext:^(NSNumber* x) {
        @strongify(self);
        UIFont *titleFont = [UIFont systemFontOfSize:14];
        CGFloat widthToSet = 0;
        
        if (self.titleLabel.text.length <= 4) {
            widthToSet = 100;
        } else {
            widthToSet = [self.titleLabel.text textSizeForOneLineWithFont:titleFont].width + 40;
        }
        
        // 绝对布局直接修改 frame 的 width 和 height
        CGRect frameToSet = self.frame;
        frameToSet.size.width = widthToSet;
        frameToSet.size.height = 36;
        self.frame = frameToSet;
        
        // 相对布局修改宽度和高度的约束
        BOOL hasWidthConstraint = NO;
        BOOL hasHeightConstraint = NO;
        for (NSLayoutConstraint *constraint in self.constraints) {
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
                constraint.constant = frameToSet.size.width;
                hasWidthConstraint = YES;
            }
            
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                constraint.constant = frameToSet.size.height;
                hasHeightConstraint = YES;
            }
        }
        if (!hasWidthConstraint) {
            NSLayoutConstraint *newWidthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.width];
            [self addConstraint:newWidthConstraint];
        }
        if (!hasHeightConstraint) {
            NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
            [self addConstraint:newHeightConstraint];
        }
        
        [self easySetupUIWithNormalBgGradientColors:@[[UIColor colorWithRed:67/255.0 green:199/255.0 blue:253/255.0 alpha:1.0], [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0]]
                         normalBgGradientStartPoint:CGPointMake(1, 0.5)
                           normalBgGradientEndPoint:CGPointMake(0, 0.5)
                               normalBgGradientSize:frameToSet.size
                            disableBgGradientColors:@[[UIColor colorWithRed:67/255.0 green:199/255.0 blue:253/255.0 alpha:0.5], [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:0.5]]
                        disableBgGradientStartPoint:CGPointMake(1, 0.5)
                          disableBgGradientEndPoint:CGPointMake(0, 0.5)
                              disableBgGradientSize:frameToSet.size
                                selectedIconImage:nil
                                        titleFont:titleFont
                                   titleFontColor:[UIColor whiteColor]
                                     cornerRadius:frameToSet.size.height/2];
    }];
}
- (void)configAsQQingMiddleBorderBlue {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingMiddleBorderBlue 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
    
    @weakify(self);
    [[RACObserve(self, titleLabel.text) onMainThread] subscribeNext:^(NSNumber* x) {
        @strongify(self);
        UIFont *titleFont = [UIFont systemFontOfSize:14];
        CGFloat widthToSet = 0;
        
        if (self.titleLabel.text.length <= 4) {
            widthToSet = 100;
        } else {
            widthToSet = [self.titleLabel.text textSizeForOneLineWithFont:titleFont].width + 40;
        }
        
        // 绝对布局直接修改 frame 的 width 和 height
        CGRect frameToSet = self.frame;
        frameToSet.size.width = widthToSet;
        frameToSet.size.height = 36;
        self.frame = frameToSet;
        
        // 相对布局修改宽度和高度的约束
        BOOL hasWidthConstraint = NO;
        BOOL hasHeightConstraint = NO;
        for (NSLayoutConstraint *constraint in self.constraints) {
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
                constraint.constant = frameToSet.size.width;
                hasWidthConstraint = YES;
            }
            
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                constraint.constant = frameToSet.size.height;
                hasHeightConstraint = YES;
            }
        }
        if (!hasWidthConstraint) {
            NSLayoutConstraint *newWidthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.width];
            [self addConstraint:newWidthConstraint];
        }
        if (!hasHeightConstraint) {
            NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
            [self addConstraint:newHeightConstraint];
        }
        
        self.titleLabel.font = titleFont;
        self.layer.cornerRadius = frameToSet.size.height/2;
        self.layer.masksToBounds = YES;

//        [self easySetupUIWithNormalBgGradientColors:@[[UIColor colorWithRed:67/255.0 green:199/255.0 blue:253/255.0 alpha:1.0], [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0]]
//                         normalBgGradientStartPoint:CGPointMake(1, 0.5)
//                           normalBgGradientEndPoint:CGPointMake(0, 0.5)
//                               normalBgGradientSize:frameToSet.size
//                            disableBgGradientColors:@[[UIColor colorWithRed:67/255.0 green:199/255.0 blue:253/255.0 alpha:0.5], [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:0.5]]
//                        disableBgGradientStartPoint:CGPointMake(1, 0.5)
//                          disableBgGradientEndPoint:CGPointMake(0, 0.5)
//                              disableBgGradientSize:frameToSet.size
//                                selectedIconImage:nil
//                                        titleFont:titleFont
//                                   titleFontColor:[UIColor whiteColor]
//                                     cornerRadius:frameToSet.size.height/2];
    }];
    
    self.layer.borderWidth = ([UIScreen mainScreen].scale >= 2) ? 0.5 : 1;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [[RACObserve(self, enabled) onMainThread] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x.boolValue ) {
            // 未禁用
            self.layer.borderColor = [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateSelected];
        } else {
            // 禁用
            self.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateSelected];
        }
    }];
}
- (void)configAsQQingMiddleBorderBlueWhenHasShadow {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingMiddleBorderBlueWhenHasShadow 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
    
    @weakify(self);
    [[RACObserve(self, titleLabel.text) onMainThread] subscribeNext:^(NSNumber* x) {
        @strongify(self);
        UIFont *titleFont = [UIFont systemFontOfSize:14];
        CGFloat widthToSet = 0;
        
        if (self.titleLabel.text.length <= 4) {
            widthToSet = 100;
        } else {
            widthToSet = [self.titleLabel.text textSizeForOneLineWithFont:titleFont].width + 40;
        }
        
        // 绝对布局直接修改 frame 的 width 和 height
        CGRect frameToSet = self.frame;
        frameToSet.size.width = widthToSet;
        frameToSet.size.height = 36;
        self.frame = frameToSet;
        
        // 相对布局修改宽度和高度的约束
        BOOL hasWidthConstraint = NO;
        BOOL hasHeightConstraint = NO;
        for (NSLayoutConstraint *constraint in self.constraints) {
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
                constraint.constant = frameToSet.size.width;
                hasWidthConstraint = YES;
            }
            
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                constraint.constant = frameToSet.size.height;
                hasHeightConstraint = YES;
            }
        }
        if (!hasWidthConstraint) {
            NSLayoutConstraint *newWidthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.width];
            [self addConstraint:newWidthConstraint];
        }
        if (!hasHeightConstraint) {
            NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
            [self addConstraint:newHeightConstraint];
        }
        
        self.titleLabel.font = titleFont;
        self.layer.cornerRadius = frameToSet.size.height/2;
        self.layer.masksToBounds = YES;

//        [self easySetupUIWithNormalBgGradientColors:@[[UIColor colorWithRed:67/255.0 green:199/255.0 blue:253/255.0 alpha:1.0], [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0]]
//                         normalBgGradientStartPoint:CGPointMake(1, 0.5)
//                           normalBgGradientEndPoint:CGPointMake(0, 0.5)
//                               normalBgGradientSize:frameToSet.size
//                            disableBgGradientColors:@[[UIColor colorWithRed:67/255.0 green:199/255.0 blue:253/255.0 alpha:0.5], [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:0.5]]
//                        disableBgGradientStartPoint:CGPointMake(1, 0.5)
//                          disableBgGradientEndPoint:CGPointMake(0, 0.5)
//                              disableBgGradientSize:frameToSet.size
//                                selectedIconImage:nil
//                                        titleFont:titleFont
//                                   titleFontColor:[UIColor whiteColor]
//                                     cornerRadius:frameToSet.size.height/2];
    }];
    
    self.layer.borderWidth = ([UIScreen mainScreen].scale >= 2) ? 0.5 : 1;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [[RACObserve(self, enabled) onMainThread] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x.boolValue ) {
            // 未禁用
            self.layer.borderColor = [UIColor colorWithRed:192/255.0 green:230/255.0 blue:255/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateSelected];
        } else {
            // 禁用
            self.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateSelected];
        }
    }];
}
- (void)configAsQQingMiddleBorderGray {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingMiddleBorderGray 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif

    @weakify(self);
    [[RACObserve(self, titleLabel.text) onMainThread] subscribeNext:^(NSNumber* x) {
        @strongify(self);
        UIFont *titleFont = [UIFont systemFontOfSize:14];
        CGFloat widthToSet = 0;
        
        if (self.titleLabel.text.length <= 4) {
            widthToSet = 100;
        } else {
            widthToSet = [self.titleLabel.text textSizeForOneLineWithFont:titleFont].width + 40;
        }
        
        // 绝对布局直接修改 frame 的 width 和 height
        CGRect frameToSet = self.frame;
        frameToSet.size.width = widthToSet;
        frameToSet.size.height = 36;
        self.frame = frameToSet;
        
        // 相对布局修改宽度和高度的约束
        BOOL hasWidthConstraint = NO;
        BOOL hasHeightConstraint = NO;
        for (NSLayoutConstraint *constraint in self.constraints) {
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
                constraint.constant = frameToSet.size.width;
                hasWidthConstraint = YES;
            }
            
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                constraint.constant = frameToSet.size.height;
                hasHeightConstraint = YES;
            }
        }
        if (!hasWidthConstraint) {
            NSLayoutConstraint *newWidthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.width];
            [self addConstraint:newWidthConstraint];
        }
        if (!hasHeightConstraint) {
            NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
            [self addConstraint:newHeightConstraint];
        }
        
        self.titleLabel.font = titleFont;
        self.layer.cornerRadius = frameToSet.size.height/2;
        self.layer.masksToBounds = YES;
    }];
    
    self.layer.borderWidth = ([UIScreen mainScreen].scale >= 2) ? 0.5 : 1;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [[RACObserve(self, enabled) onMainThread] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x.boolValue ) {
            // 未禁用
            self.layer.borderColor = [UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:99/255.0 green:103/255.0 blue:108/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:99/255.0 green:103/255.0 blue:108/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:99/255.0 green:103/255.0 blue:108/255.0 alpha:1.0] forState:UIControlStateSelected];
        } else {
            // 禁用
            self.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateSelected];
        }
    }];
}

- (void)configAsQQingNormalSolidBlue {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingNormalSolidBlue 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
    
    @weakify(self);
    [[RACObserve(self, titleLabel.text) onMainThread] subscribeNext:^(NSNumber* x) {
        @strongify(self);
        UIFont *titleFont = [UIFont systemFontOfSize:14];
        CGFloat widthToSet = 0;
        
        if (self.titleLabel.text.length <= 4) {
            widthToSet = 80;
        } else {
            widthToSet = [self.titleLabel.text textSizeForOneLineWithFont:titleFont].width + 24;
        }
        
        // 绝对布局直接修改 frame 的 width 和 height
        CGRect frameToSet = self.frame;
        frameToSet.size.width = widthToSet;
        frameToSet.size.height = 28;
        self.frame = frameToSet;
        
        // 相对布局修改宽度和高度的约束
        BOOL hasWidthConstraint = NO;
        BOOL hasHeightConstraint = NO;
        for (NSLayoutConstraint *constraint in self.constraints) {
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
                constraint.constant = frameToSet.size.width;
                hasWidthConstraint = YES;
            }
            
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                constraint.constant = frameToSet.size.height;
                hasHeightConstraint = YES;
            }
        }
        if (!hasWidthConstraint) {
            NSLayoutConstraint *newWidthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.width];
            [self addConstraint:newWidthConstraint];
        }
        if (!hasHeightConstraint) {
            NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
            [self addConstraint:newHeightConstraint];
        }
        
        [self easySetupUIWithNormalBgGradientColors:@[[UIColor colorWithRed:67/255.0 green:199/255.0 blue:253/255.0 alpha:1.0], [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0]]
                         normalBgGradientStartPoint:CGPointMake(1, 0.5)
                           normalBgGradientEndPoint:CGPointMake(0, 0.5)
                               normalBgGradientSize:frameToSet.size
                            disableBgGradientColors:@[[UIColor colorWithRed:67/255.0 green:199/255.0 blue:253/255.0 alpha:0.5], [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:0.5]]
                        disableBgGradientStartPoint:CGPointMake(1, 0.5)
                          disableBgGradientEndPoint:CGPointMake(0, 0.5)
                              disableBgGradientSize:frameToSet.size
                                selectedIconImage:nil
                                        titleFont:titleFont
                                   titleFontColor:[UIColor whiteColor]
                                     cornerRadius:frameToSet.size.height/2];
    }];
}
- (void)configAsQQingNormalBorderBlue {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingNormalBorderBlue 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
    
    @weakify(self);
    [[RACObserve(self, titleLabel.text) onMainThread] subscribeNext:^(NSNumber* x) {
        @strongify(self);
        UIFont *titleFont = [UIFont systemFontOfSize:14];
        CGFloat widthToSet = 0;
        
        if (self.titleLabel.text.length <= 4) {
            widthToSet = 80;
        } else {
            widthToSet = [self.titleLabel.text textSizeForOneLineWithFont:titleFont].width + 24;
        }
        
        // 绝对布局直接修改 frame 的 width 和 height
        CGRect frameToSet = self.frame;
        frameToSet.size.width = widthToSet;
        frameToSet.size.height = 28;
        self.frame = frameToSet;
        
        // 相对布局修改宽度和高度的约束
        BOOL hasWidthConstraint = NO;
        BOOL hasHeightConstraint = NO;
        for (NSLayoutConstraint *constraint in self.constraints) {
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
                constraint.constant = frameToSet.size.width;
                hasWidthConstraint = YES;
            }
            
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                constraint.constant = frameToSet.size.height;
                hasHeightConstraint = YES;
            }
        }
        if (!hasWidthConstraint) {
            NSLayoutConstraint *newWidthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.width];
            [self addConstraint:newWidthConstraint];
        }
        if (!hasHeightConstraint) {
            NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
            [self addConstraint:newHeightConstraint];
        }
        
        self.titleLabel.font = titleFont;
        self.layer.cornerRadius = frameToSet.size.height/2;
        self.layer.masksToBounds = YES;
    }];
    
    self.layer.borderWidth = ([UIScreen mainScreen].scale >= 2) ? 0.5 : 1;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [[RACObserve(self, enabled) onMainThread] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x.boolValue ) {
            // 未禁用
            self.layer.borderColor = [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateSelected];
        } else {
            // 禁用
            self.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateSelected];
        }
    }];
}
- (void)configAsQQingNormalBorderBlueWhenHasShadow {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingNormalBorderBlueWhenHasShadow 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
    
    @weakify(self);
    [[RACObserve(self, titleLabel.text) onMainThread] subscribeNext:^(NSNumber* x) {
        @strongify(self);
        UIFont *titleFont = [UIFont systemFontOfSize:14];
        CGFloat widthToSet = 0;
        
        if (self.titleLabel.text.length <= 4) {
            widthToSet = 80;
        } else {
            widthToSet = [self.titleLabel.text textSizeForOneLineWithFont:titleFont].width + 24;
        }
        
        // 绝对布局直接修改 frame 的 width 和 height
        CGRect frameToSet = self.frame;
        frameToSet.size.width = widthToSet;
        frameToSet.size.height = 28;
        self.frame = frameToSet;
        
        // 相对布局修改宽度和高度的约束
        BOOL hasWidthConstraint = NO;
        BOOL hasHeightConstraint = NO;
        for (NSLayoutConstraint *constraint in self.constraints) {
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
                constraint.constant = frameToSet.size.width;
                hasWidthConstraint = YES;
            }
            
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                constraint.constant = frameToSet.size.height;
                hasHeightConstraint = YES;
            }
        }
        if (!hasWidthConstraint) {
            NSLayoutConstraint *newWidthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.width];
            [self addConstraint:newWidthConstraint];
        }
        if (!hasHeightConstraint) {
            NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
            [self addConstraint:newHeightConstraint];
        }
        
        self.titleLabel.font = titleFont;
        self.layer.cornerRadius = frameToSet.size.height/2;
        self.layer.masksToBounds = YES;
    }];
    
    self.layer.borderWidth = ([UIScreen mainScreen].scale >= 2) ? 0.5 : 1;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [[RACObserve(self, enabled) onMainThread] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x.boolValue ) {
            // 未禁用
            self.layer.borderColor = [UIColor colorWithRed:192/255.0 green:230/255.0 blue:255/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateSelected];
        } else {
            // 禁用
            self.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateSelected];
        }
    }];
}
- (void)configAsQQingNormalBorderGray {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingNormalBorderGray 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif

    @weakify(self);
    [[RACObserve(self, titleLabel.text) onMainThread] subscribeNext:^(NSNumber* x) {
        @strongify(self);
        UIFont *titleFont = [UIFont systemFontOfSize:14];
        CGFloat widthToSet = 0;
        
        if (self.titleLabel.text.length <= 4) {
            widthToSet = 80;
        } else {
            widthToSet = [self.titleLabel.text textSizeForOneLineWithFont:titleFont].width + 24;
        }
        
        // 绝对布局直接修改 frame 的 width 和 height
        CGRect frameToSet = self.frame;
        frameToSet.size.width = widthToSet;
        frameToSet.size.height = 28;
        self.frame = frameToSet;
        
        // 相对布局修改宽度和高度的约束
        BOOL hasWidthConstraint = NO;
        BOOL hasHeightConstraint = NO;
        for (NSLayoutConstraint *constraint in self.constraints) {
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
                constraint.constant = frameToSet.size.width;
                hasWidthConstraint = YES;
            }
            
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                constraint.constant = frameToSet.size.height;
                hasHeightConstraint = YES;
            }
        }
        if (!hasWidthConstraint) {
            NSLayoutConstraint *newWidthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.width];
            [self addConstraint:newWidthConstraint];
        }
        if (!hasHeightConstraint) {
            NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
            [self addConstraint:newHeightConstraint];
        }
        
        self.titleLabel.font = titleFont;
        self.layer.cornerRadius = frameToSet.size.height/2;
        self.layer.masksToBounds = YES;
    }];
    
    self.layer.borderWidth = ([UIScreen mainScreen].scale >= 2) ? 0.5 : 1;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [[RACObserve(self, enabled) onMainThread] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x.boolValue ) {
            // 未禁用
            self.layer.borderColor = [UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:99/255.0 green:103/255.0 blue:108/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:99/255.0 green:103/255.0 blue:108/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:99/255.0 green:103/255.0 blue:108/255.0 alpha:1.0] forState:UIControlStateSelected];
        } else {
            // 禁用
            self.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateSelected];
        }
    }];
}

- (void)configAsQQingSmallSolidBlue {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingSmallSolidBlue 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
    
    @weakify(self);
    [[RACObserve(self, titleLabel.text) onMainThread] subscribeNext:^(NSNumber* x) {
        @strongify(self);
        UIFont *titleFont = [UIFont systemFontOfSize:12];
        CGFloat widthToSet = 0;
        
        if (self.titleLabel.text.length <= 4) {
            widthToSet = 80;
        } else {
            widthToSet = [self.titleLabel.text textSizeForOneLineWithFont:titleFont].width + 24;
        }
        
        // 绝对布局直接修改 frame 的 width 和 height
        CGRect frameToSet = self.frame;
        frameToSet.size.width = widthToSet;
        frameToSet.size.height = 26;
        self.frame = frameToSet;
        
        // 相对布局修改宽度和高度的约束
        BOOL hasWidthConstraint = NO;
        BOOL hasHeightConstraint = NO;
        for (NSLayoutConstraint *constraint in self.constraints) {
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
                constraint.constant = frameToSet.size.width;
                hasWidthConstraint = YES;
            }
            
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                constraint.constant = frameToSet.size.height;
                hasHeightConstraint = YES;
            }
        }
        if (!hasWidthConstraint) {
            NSLayoutConstraint *newWidthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.width];
            [self addConstraint:newWidthConstraint];
        }
        if (!hasHeightConstraint) {
            NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
            [self addConstraint:newHeightConstraint];
        }
        
        [self easySetupUIWithNormalBgGradientColors:@[[UIColor colorWithRed:67/255.0 green:199/255.0 blue:253/255.0 alpha:1.0], [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0]]
                         normalBgGradientStartPoint:CGPointMake(1, 0.5)
                           normalBgGradientEndPoint:CGPointMake(0, 0.5)
                               normalBgGradientSize:frameToSet.size
                            disableBgGradientColors:@[[UIColor colorWithRed:67/255.0 green:199/255.0 blue:253/255.0 alpha:0.5], [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:0.5]]
                        disableBgGradientStartPoint:CGPointMake(1, 0.5)
                          disableBgGradientEndPoint:CGPointMake(0, 0.5)
                              disableBgGradientSize:frameToSet.size
                                selectedIconImage:nil
                                        titleFont:titleFont
                                   titleFontColor:[UIColor whiteColor]
                                     cornerRadius:frameToSet.size.height/2];
    }];
}
- (void)configAsQQingSmallBorderBlue {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingSmallBorderBlue 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
    
    @weakify(self);
    [[RACObserve(self, titleLabel.text) onMainThread] subscribeNext:^(NSNumber* x) {
        @strongify(self);
        UIFont *titleFont = [UIFont systemFontOfSize:12];
        CGFloat widthToSet = 0;
        
        if (self.titleLabel.text.length <= 4) {
            widthToSet = 80;
        } else {
            widthToSet = [self.titleLabel.text textSizeForOneLineWithFont:titleFont].width + 24;
        }
        
        // 绝对布局直接修改 frame 的 width 和 height
        CGRect frameToSet = self.frame;
        frameToSet.size.width = widthToSet;
        frameToSet.size.height = 26;
        self.frame = frameToSet;
        
        // 相对布局修改宽度和高度的约束
        BOOL hasWidthConstraint = NO;
        BOOL hasHeightConstraint = NO;
        for (NSLayoutConstraint *constraint in self.constraints) {
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
                constraint.constant = frameToSet.size.width;
                hasWidthConstraint = YES;
            }
            
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                constraint.constant = frameToSet.size.height;
                hasHeightConstraint = YES;
            }
        }
        if (!hasWidthConstraint) {
            NSLayoutConstraint *newWidthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.width];
            [self addConstraint:newWidthConstraint];
        }
        if (!hasHeightConstraint) {
            NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
            [self addConstraint:newHeightConstraint];
        }
        
        self.titleLabel.font = titleFont;
        self.layer.cornerRadius = frameToSet.size.height/2;
        self.layer.masksToBounds = YES;
    }];
    
    self.layer.borderWidth = ([UIScreen mainScreen].scale >= 2) ? 0.5 : 1;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [[RACObserve(self, enabled) onMainThread] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x.boolValue ) {
            // 未禁用
            self.layer.borderColor = [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateSelected];
        } else {
            // 禁用
            self.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateSelected];
        }
    }];
}
- (void)configAsQQingSmallBorderBlueWhenHasShadow {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingSmallBorderBlueWhenHasShadow 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
    
    @weakify(self);
    [[RACObserve(self, titleLabel.text) onMainThread] subscribeNext:^(NSNumber* x) {
        @strongify(self);
        UIFont *titleFont = [UIFont systemFontOfSize:12];
        CGFloat widthToSet = 0;
        
        if (self.titleLabel.text.length <= 4) {
            widthToSet = 80;
        } else {
            widthToSet = [self.titleLabel.text textSizeForOneLineWithFont:titleFont].width + 24;
        }
        
        // 绝对布局直接修改 frame 的 width 和 height
        CGRect frameToSet = self.frame;
        frameToSet.size.width = widthToSet;
        frameToSet.size.height = 26;
        self.frame = frameToSet;
        
        // 相对布局修改宽度和高度的约束
        BOOL hasWidthConstraint = NO;
        BOOL hasHeightConstraint = NO;
        for (NSLayoutConstraint *constraint in self.constraints) {
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
                constraint.constant = frameToSet.size.width;
                hasWidthConstraint = YES;
            }
            
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                constraint.constant = frameToSet.size.height;
                hasHeightConstraint = YES;
            }
        }
        if (!hasWidthConstraint) {
            NSLayoutConstraint *newWidthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.width];
            [self addConstraint:newWidthConstraint];
        }
        if (!hasHeightConstraint) {
            NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
            [self addConstraint:newHeightConstraint];
        }
        
        self.titleLabel.font = titleFont;
        self.layer.cornerRadius = frameToSet.size.height/2;
        self.layer.masksToBounds = YES;
    }];
    
    self.layer.borderWidth = ([UIScreen mainScreen].scale >= 2) ? 0.5 : 1;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [[RACObserve(self, enabled) onMainThread] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x.boolValue ) {
            // 未禁用
            self.layer.borderColor = [UIColor colorWithRed:192/255.0 green:230/255.0 blue:255/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateSelected];
        } else {
            // 禁用
            self.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateSelected];
        }
    }];
}
- (void)configAsQQingSmallBorderGray {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingSmallBorderGray 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif

    @weakify(self);
    [[RACObserve(self, titleLabel.text) onMainThread] subscribeNext:^(NSNumber* x) {
        @strongify(self);
        UIFont *titleFont = [UIFont systemFontOfSize:12];
        CGFloat widthToSet = 0;
        
        if (self.titleLabel.text.length <= 4) {
            widthToSet = 80;
        } else {
            widthToSet = [self.titleLabel.text textSizeForOneLineWithFont:titleFont].width + 24;
        }
        
        // 绝对布局直接修改 frame 的 width 和 height
        CGRect frameToSet = self.frame;
        frameToSet.size.width = widthToSet;
        frameToSet.size.height = 26;
        self.frame = frameToSet;
        
        // 相对布局修改宽度和高度的约束
        BOOL hasWidthConstraint = NO;
        BOOL hasHeightConstraint = NO;
        for (NSLayoutConstraint *constraint in self.constraints) {
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
                constraint.constant = frameToSet.size.width;
                hasWidthConstraint = YES;
            }
            
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                constraint.constant = frameToSet.size.height;
                hasHeightConstraint = YES;
            }
        }
        if (!hasWidthConstraint) {
            NSLayoutConstraint *newWidthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.width];
            [self addConstraint:newWidthConstraint];
        }
        if (!hasHeightConstraint) {
            NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
            [self addConstraint:newHeightConstraint];
        }
        
        self.titleLabel.font = titleFont;
        self.layer.cornerRadius = frameToSet.size.height/2;
        self.layer.masksToBounds = YES;
    }];
    
    self.layer.borderWidth = ([UIScreen mainScreen].scale >= 2) ? 0.5 : 1;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [[RACObserve(self, enabled) onMainThread] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x.boolValue ) {
            // 未禁用
            self.layer.borderColor = [UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:99/255.0 green:103/255.0 blue:108/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:99/255.0 green:103/255.0 blue:108/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:99/255.0 green:103/255.0 blue:108/255.0 alpha:1.0] forState:UIControlStateSelected];
        } else {
            // 禁用
            self.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateSelected];
        }
    }];
}

- (void)configAsQQingMiniSolidBlue {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingMiniSolidBlue 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
    
    @weakify(self);
    [[RACObserve(self, titleLabel.text) onMainThread] subscribeNext:^(NSNumber* x) {
        @strongify(self);
        UIFont *titleFont = [UIFont systemFontOfSize:12];
        CGFloat widthToSet = 0;
        
        widthToSet = [self.titleLabel.text textSizeForOneLineWithFont:titleFont].width + 16;
        
        if (widthToSet < 40) {
            widthToSet = 40;
        }
        
        // 绝对布局直接修改 frame 的 width 和 height
        CGRect frameToSet = self.frame;
        frameToSet.size.width = widthToSet;
        frameToSet.size.height = 18;
        self.frame = frameToSet;
        
        // 相对布局修改宽度和高度的约束
        BOOL hasWidthConstraint = NO;
        BOOL hasHeightConstraint = NO;
        for (NSLayoutConstraint *constraint in self.constraints) {
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
                constraint.constant = frameToSet.size.width;
                hasWidthConstraint = YES;
            }
            
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                constraint.constant = frameToSet.size.height;
                hasHeightConstraint = YES;
            }
        }
        if (!hasWidthConstraint) {
            NSLayoutConstraint *newWidthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.width];
            [self addConstraint:newWidthConstraint];
        }
        if (!hasHeightConstraint) {
            NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
            [self addConstraint:newHeightConstraint];
        }
        
        [self easySetupUIWithNormalBgGradientColors:@[[UIColor colorWithRed:67/255.0 green:199/255.0 blue:253/255.0 alpha:1.0], [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0]]
                         normalBgGradientStartPoint:CGPointMake(1, 0.5)
                           normalBgGradientEndPoint:CGPointMake(0, 0.5)
                               normalBgGradientSize:frameToSet.size
                            disableBgGradientColors:@[[UIColor colorWithRed:67/255.0 green:199/255.0 blue:253/255.0 alpha:0.5], [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:0.5]]
                        disableBgGradientStartPoint:CGPointMake(1, 0.5)
                          disableBgGradientEndPoint:CGPointMake(0, 0.5)
                              disableBgGradientSize:frameToSet.size
                                selectedIconImage:nil
                                        titleFont:titleFont
                                   titleFontColor:[UIColor whiteColor]
                                     cornerRadius:frameToSet.size.height/2];
    }];
}

- (void)configAsQQingMiniBorderBlue {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingMiniBorderBlue 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif
    
    @weakify(self);
    [[RACObserve(self, titleLabel.text) onMainThread] subscribeNext:^(NSNumber* x) {
        @strongify(self);
        UIFont *titleFont = [UIFont systemFontOfSize:12];
        CGFloat widthToSet = 0;
        
        widthToSet = [self.titleLabel.text textSizeForOneLineWithFont:titleFont].width + 16;
        
        if (widthToSet < 40) {
            widthToSet = 40;
        }
        
        // 绝对布局直接修改 frame 的 width 和 height
        CGRect frameToSet = self.frame;
        frameToSet.size.width = widthToSet;
        frameToSet.size.height = 18;
        self.frame = frameToSet;
        
        // 相对布局修改宽度和高度的约束
        BOOL hasWidthConstraint = NO;
        BOOL hasHeightConstraint = NO;
        for (NSLayoutConstraint *constraint in self.constraints) {
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
                constraint.constant = frameToSet.size.width;
                hasWidthConstraint = YES;
            }
            
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                constraint.constant = frameToSet.size.height;
                hasHeightConstraint = YES;
            }
        }
        if (!hasWidthConstraint) {
            NSLayoutConstraint *newWidthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.width];
            [self addConstraint:newWidthConstraint];
        }
        if (!hasHeightConstraint) {
            NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
            [self addConstraint:newHeightConstraint];
        }
        
        self.titleLabel.font = titleFont;
        self.layer.cornerRadius = frameToSet.size.height/2;
        self.layer.masksToBounds = YES;
    }];
    
    self.layer.borderWidth = ([UIScreen mainScreen].scale >= 2) ? 0.5 : 1;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [[RACObserve(self, enabled) onMainThread] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x.boolValue ) {
            // 未禁用
            self.layer.borderColor = [UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateSelected];
        } else {
            // 禁用
            self.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateSelected];
        }
    }];
}
- (void)configAsQQingMiniBorderGray {
#ifdef DEBUG
    if (self.buttonType != UIButtonTypeCustom) {
        [QQingUtils showFailImageToastWithText:@"使用工具方法 configAsQQingMiniBorderGray 需要按钮样式为 UIButtonTypeCustom"];
    }
#endif

    @weakify(self);
    [[RACObserve(self, titleLabel.text) onMainThread] subscribeNext:^(NSNumber* x) {
        @strongify(self);
        UIFont *titleFont = [UIFont systemFontOfSize:12];
        CGFloat widthToSet = 0;
        
        widthToSet = [self.titleLabel.text textSizeForOneLineWithFont:titleFont].width + 16;
        
        if (widthToSet < 40) {
            widthToSet = 40;
        }
        
        // 绝对布局直接修改 frame 的 width 和 height
        CGRect frameToSet = self.frame;
        frameToSet.size.width = widthToSet;
        frameToSet.size.height = 18;
        self.frame = frameToSet;
        
        // 相对布局修改宽度和高度的约束
        BOOL hasWidthConstraint = NO;
        BOOL hasHeightConstraint = NO;
        for (NSLayoutConstraint *constraint in self.constraints) {
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
                constraint.constant = frameToSet.size.width;
                hasWidthConstraint = YES;
            }
            
            if (constraint.firstItem == self && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                constraint.constant = frameToSet.size.height;
                hasHeightConstraint = YES;
            }
        }
        if (!hasWidthConstraint) {
            NSLayoutConstraint *newWidthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.width];
            [self addConstraint:newWidthConstraint];
        }
        if (!hasHeightConstraint) {
            NSLayoutConstraint *newHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frameToSet.size.height];
            [self addConstraint:newHeightConstraint];
        }
        
        self.titleLabel.font = titleFont;
        self.layer.cornerRadius = frameToSet.size.height/2;
        self.layer.masksToBounds = YES;
    }];
    
    self.layer.borderWidth = ([UIScreen mainScreen].scale >= 2) ? 0.5 : 1;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [[RACObserve(self, enabled) onMainThread] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x.boolValue ) {
            // 未禁用
            self.layer.borderColor = [UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:99/255.0 green:103/255.0 blue:108/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:99/255.0 green:103/255.0 blue:108/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:99/255.0 green:103/255.0 blue:108/255.0 alpha:1.0] forState:UIControlStateSelected];
        } else {
            // 禁用
            self.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor colorWithRed:156/255.0 green:157/255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateSelected];
        }
    }];
}

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
                                 cornerRadius:(CGFloat)cornerRadius {

    UIImage *normalBgGradientImage = [UIImage gradientImageWithColors:normalBgGradientColors startPoint:normalBgGradientStartPoint endPoint:normalBgGradientEndPoint andSize:normalBgGradientSize];
    [self setBackgroundImage:normalBgGradientImage forState:UIControlStateNormal];
//    [self setBackgroundImage:normalBgGradientImage forState:UIControlStateHighlighted];
    
    UIImage *disableBgGradientImage = [UIImage gradientImageWithColors:disableBgGradientColors startPoint:disableBgGradientStartPoint endPoint:disableBgGradientEndPoint andSize:disableBgGradientSize];
    [self setBackgroundImage:disableBgGradientImage forState:UIControlStateDisabled];
    
    if (selectedIconImage) {
        [self setImage:selectedIconImage forState:UIControlStateSelected];
        self.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 2);
    }

    self.titleLabel.font = titleFont;
    
    [self setTitleColor:titleFontColor forState:UIControlStateNormal];
    [self setTitleColor:titleFontColor forState:UIControlStateHighlighted];
    [self setTitleColor:titleFontColor forState:UIControlStateSelected];
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

@end


