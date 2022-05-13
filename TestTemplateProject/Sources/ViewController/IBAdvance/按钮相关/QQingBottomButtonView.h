//
//  QQingBottomButtonView.h
//  student
//
//  Created by Ben on 2021/6/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, QQingBottomButtonViewStyleType) {
    kQQingBottomButtonViewStyleType_OnlyOneButton = 0,
    kQQingBottomButtonViewStyleType_SameSizeTwoButton = 1,
    kQQingBottomButtonViewStyleType_LeftSmallRightLarge = 2
};

@protocol QQingBottomButtonViewDelegate <NSObject>

@optional
- (void)didClickBottomButtonViewLeftButton:(UIButton *)leftButton;
- (void)didClickBottomButtonViewRightButton:(UIButton *)rightButton;

@end


//IB_DESIGNABLE
@interface QQingBottomButtonView : UIView

@property (nonatomic, assign) IBInspectable int qqingStyleType;     // 对应上面的 QQingBottomButtonViewStyleType
@property (nonatomic, assign) IBInspectable BOOL isUsedForPayment;  // 用于支付、购买相关情况下的按钮颜色是橙色配色

@property (nonatomic, strong) IBInspectable NSString *leftButtonTitle;
@property (nonatomic, strong) IBInspectable NSString *rightButtonTitle;
@property (nonatomic, assign) IBInspectable BOOL disableAdaptiPhoneX; // 禁掉自动适配刘海屏高度，即高度写死为64

// 样式为 kQQingBottomButtonViewStyleType_OnlyOneButton 时，取 leftButton
@property (nonatomic, readonly, nullable, weak) UIButton *leftButton;
@property (nonatomic, readonly, nullable, weak) UIButton *rightButton;

@property (nonatomic, nullable, weak) id<QQingBottomButtonViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END


