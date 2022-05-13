//
//  QQingBottomButtonView.m
//  student
//
//  Created by Ben on 2021/6/8.
//

#import "QQingBottomButtonView.h"

static const CGFloat kButtonOffsetX = 16;
static const CGFloat kButtonOffsetY = 9;
static const CGFloat kButtonHeight = 46;
static const CGFloat kBottomButtonViewHeight = 64;

@interface QQingBottomButtonView ()

// 样式为 kQQingBottomButtonViewStyleType_OnlyOneButton 时，取 leftButton
@property (nonatomic, readwrite, nullable, weak) UIButton *leftButton;
@property (nonatomic, readwrite, nullable, weak) UIButton *rightButton;

@end

@implementation QQingBottomButtonView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInitWithFrame:self.frame];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInitWithFrame:frame];
    }
    return self;
}

- (void)commonInitWithFrame:(CGRect)frame {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton = leftButton;
    self.rightButton = rightButton;
    [self.leftButton setTitle:self.leftButtonTitle forState:UIControlStateNormal];
    [self.rightButton setTitle:self.rightButtonTitle forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(didClickLeftButton) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(didClickRightButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat currentViewWidth = kScreenWidth;
    
    QQingBottomButtonViewStyleType styleType = (QQingBottomButtonViewStyleType)self.qqingStyleType;
    
    switch (styleType) {
        case kQQingBottomButtonViewStyleType_SameSizeTwoButton: {
            CGFloat buttonGap = 11;
            CGFloat buttonWidth = (currentViewWidth - (kButtonOffsetX * 2) - buttonGap) / 2;
            self.leftButton.frame = CGRectMake(kButtonOffsetX, kButtonOffsetY, buttonWidth, kButtonHeight);
            self.rightButton.frame = CGRectMake(kButtonOffsetX + buttonWidth + buttonGap, kButtonOffsetY, buttonWidth, kButtonHeight);
            self.rightButton.hidden = NO;
            
            if (self.isUsedForPayment) {
                [self.leftButton configAsQQingBottomBorderOrange];
                [self.rightButton configAsQQingBottomSolidOrange];
            } else {
                [self.leftButton configAsQQingBottomBorderBlue];
                [self.rightButton configAsQQingBottomSolidBlue];
            }
        }
            break;
        case kQQingBottomButtonViewStyleType_LeftSmallRightLarge: {
            CGFloat buttonGap = 10;
            CGFloat leftButtonWidth = 85;
            CGFloat rightButtonWidth = currentViewWidth - (kButtonOffsetX * 2) - buttonGap - leftButtonWidth;
            self.leftButton.frame = CGRectMake(kButtonOffsetX, kButtonOffsetY, leftButtonWidth, kButtonHeight);
            self.rightButton.frame = CGRectMake(kButtonOffsetX + leftButtonWidth + buttonGap, kButtonOffsetY, rightButtonWidth, kButtonHeight);
            self.rightButton.hidden = NO;
            
            [self.leftButton configAsQQingBottomPureText];
            if (self.isUsedForPayment) {
                [self.rightButton configAsQQingBottomSolidOrange];
            } else {
                [self.rightButton configAsQQingBottomSolidBlue];
            }
        }
            break;
        case kQQingBottomButtonViewStyleType_OnlyOneButton:
        default: {
            CGFloat leftButtonWidth = currentViewWidth - (kButtonOffsetX * 2);
            self.leftButton.frame = CGRectMake(kButtonOffsetX, kButtonOffsetY, leftButtonWidth, kButtonHeight);
            self.rightButton.frame = CGRectMake(kButtonOffsetX + leftButtonWidth + kButtonOffsetX, kButtonOffsetY, 0, kButtonHeight);
            self.rightButton.hidden = YES;
            
            if (self.isUsedForPayment) {
                [self.leftButton configAsQQingBottomSingleSolidOrange];
            } else {
                [self.leftButton configAsQQingBottomSingleSolidBlue];
            }
        }
    }
}

- (void)setQqingStyleType:(int)qqingStyleType {
    _qqingStyleType = qqingStyleType;
    
    [self setNeedsLayout];
}

- (void)setIsUsedForPayment:(BOOL)isUsedForPayment {
    _isUsedForPayment = isUsedForPayment;
    
    [self setNeedsLayout];
}

- (void)setLeftButtonTitle:(NSString *)leftButtonTitle {
    _leftButtonTitle = leftButtonTitle;
    
    [self.leftButton setTitle:leftButtonTitle forState:UIControlStateNormal];
}

- (void)setRightButtonTitle:(NSString *)rightButtonTitle {
    _rightButtonTitle = rightButtonTitle;
    
    [self.rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
}

- (void)setDisableAdaptiPhoneX:(BOOL)disableAdaptiPhoneX {
    _disableAdaptiPhoneX = disableAdaptiPhoneX;
    
    [self invalidateIntrinsicContentSize];
}

- (CGSize)intrinsicContentSize {
    return self.disableAdaptiPhoneX ? CGSizeMake(kScreenWidth, kBottomButtonViewHeight) : CGSizeMake(kScreenWidth, kBottomButtonViewHeight + kPortraitBottomDangerAreaHeight);
}

- (void)didClickLeftButton {
    if ([self.delegate respondsToSelector:@selector(didClickBottomButtonViewLeftButton:)]) {
        [self.delegate didClickBottomButtonViewLeftButton:self.leftButton];
    }
}

- (void)didClickRightButton {
    if ([self.delegate respondsToSelector:@selector(didClickBottomButtonViewRightButton:)]) {
        [self.delegate didClickBottomButtonViewRightButton:self.rightButton];
    }
}

@end


