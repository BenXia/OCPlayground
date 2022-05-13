//
//  TestButtonQQingUIStandardVC.m
//  student
//
//  Created by Ben on 2021/5/6.
//

#import "TestButtonQQingUIStandardVC.h"
#import "QQingBottomButtonView.h"

@interface TestButtonQQingUIStandardVC () <QQingBottomButtonViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *bottomSingleSolidBlueButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomSingleSolidOrangeButton;

@property (weak, nonatomic) IBOutlet UIButton *largeSolidBlueButton;
@property (weak, nonatomic) IBOutlet UIButton *largeSolidOrangeButton;

@property (weak, nonatomic) IBOutlet UIButton *middleSolidBlueButton;
@property (weak, nonatomic) IBOutlet UIView *middleSolidBlueWithShadowButtonShadowView;
@property (weak, nonatomic) IBOutlet UIButton *middleSolidBlueWithShadowButton;
@property (weak, nonatomic) IBOutlet UIButton *middleBorderBlueButton;
@property (weak, nonatomic) IBOutlet UIView *middleBorderBlueWithShadowButtonShadowView;
@property (weak, nonatomic) IBOutlet UIButton *middleBorderBlueWithShadowButton;
@property (weak, nonatomic) IBOutlet UIButton *middleBorderGrayButton;

@property (weak, nonatomic) IBOutlet UIButton *normalSolidBlueButton;
@property (weak, nonatomic) IBOutlet UIView *normalSolidBlueWithShadowButtonShadowView;
@property (weak, nonatomic) IBOutlet UIButton *normalSolidBlueWithShadowButton;
@property (weak, nonatomic) IBOutlet UIButton *normalBorderBlueButton;
@property (weak, nonatomic) IBOutlet UIView *normalBorderBlueWithShadowButtonShadowView;
@property (weak, nonatomic) IBOutlet UIButton *normalBorderBlueWithShadowButton;
@property (weak, nonatomic) IBOutlet UIButton *normalBorderGrayButton;

@property (weak, nonatomic) IBOutlet UIButton *smallSolidBlueButton;
@property (weak, nonatomic) IBOutlet UIView *smallSolidBlueWithShadowButtonShadowView;
@property (weak, nonatomic) IBOutlet UIButton *smallSolidBlueWithShadowButton;
@property (weak, nonatomic) IBOutlet UIButton *smallBorderBlueButton;
@property (weak, nonatomic) IBOutlet UIView *smallBorderBlueWithShadowButtonShadowView;
@property (weak, nonatomic) IBOutlet UIButton *smallBorderBlueWithShadowButton;
@property (weak, nonatomic) IBOutlet UIButton *smallBorderGrayButton;

@property (weak, nonatomic) IBOutlet UIButton *miniBorderBlueButton;
@property (weak, nonatomic) IBOutlet UIButton *miniBorderGrayButton;

@property (weak, nonatomic) IBOutlet QQingBottomButtonView *singleButtonStyleBottomView;
@property (weak, nonatomic) IBOutlet QQingBottomButtonView *sameSizeTwoButtonStyleBottomView;
@property (weak, nonatomic) IBOutlet QQingBottomButtonView *leftSmallTwoButtonStyleBottomView;
@property (weak, nonatomic) IBOutlet QQingBottomButtonView *singleButtonStyleBottomView2;
@property (weak, nonatomic) IBOutlet QQingBottomButtonView *sameSizeTwoButtonStyleBottomView2;
@property (weak, nonatomic) IBOutlet QQingBottomButtonView *leftSmallTwoButtonStyleBottomView2;

@end

@implementation TestButtonQQingUIStandardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavTitleString:@"Button规范"];

    [self.bottomSingleSolidBlueButton configAsQQingBottomSingleSolidBlue];
    self.bottomSingleSolidBlueButton.selected = YES;
//    self.bottomSingleSolidBlueButton.enabled = NO;
    [self.bottomSingleSolidOrangeButton configAsQQingBottomSingleSolidOrange];
    self.bottomSingleSolidOrangeButton.selected = YES;
//    self.bottomSingleSolidOrangeButton.enabled = NO;
    
    [self.largeSolidBlueButton configAsQQingLargeSolidBlue];
    self.largeSolidBlueButton.selected = YES;
//    self.largeSolidBlueButton.enabled = NO;
    [self.largeSolidOrangeButton configAsQQingLargeSolidOrange];
    self.largeSolidOrangeButton.selected = YES;
//    self.largeSolidOrangeButton.enabled = NO;

    [self.middleSolidBlueButton configAsQQingMiddleSolidBlue];
//    self.middleSolidBlueButton.enabled = NO;
    self.middleSolidBlueWithShadowButtonShadowView.layer.cornerRadius = 18;
    self.middleSolidBlueWithShadowButtonShadowView.layer.shadowColor = [UIColor colorWithRed:102/255.0 green:206/255.0 blue:255/255.0 alpha:0.4].CGColor;
    self.middleSolidBlueWithShadowButtonShadowView.layer.shadowOffset = CGSizeMake(0,2);
    self.middleSolidBlueWithShadowButtonShadowView.layer.shadowOpacity = 1;
    self.middleSolidBlueWithShadowButtonShadowView.layer.shadowRadius = 4;
    [self.middleSolidBlueWithShadowButton configAsQQingMiddleSolidBlue];
    [self.middleBorderBlueButton configAsQQingMiddleBorderBlue];
//    self.middleBorderBlueButton.enabled = NO;
    self.middleBorderBlueWithShadowButtonShadowView.layer.cornerRadius = 18;
    self.middleBorderBlueWithShadowButtonShadowView.layer.shadowColor = [UIColor colorWithRed:102/255.0 green:206/255.0 blue:255/255.0 alpha:0.4].CGColor;
    self.middleBorderBlueWithShadowButtonShadowView.layer.shadowOffset = CGSizeMake(0,2);
    self.middleBorderBlueWithShadowButtonShadowView.layer.shadowOpacity = 1;
    self.middleBorderBlueWithShadowButtonShadowView.layer.shadowRadius = 4;
    [self.middleBorderBlueWithShadowButton configAsQQingMiddleBorderBlueWhenHasShadow];
    [self.middleBorderGrayButton configAsQQingMiddleBorderGray];
//    self.middleBorderGrayButton.enabled = NO;

    [self.normalSolidBlueButton configAsQQingNormalSolidBlue];
    self.normalSolidBlueWithShadowButtonShadowView.layer.cornerRadius = 14;
    self.normalSolidBlueWithShadowButtonShadowView.layer.shadowColor = [UIColor colorWithRed:102/255.0 green:206/255.0 blue:255/255.0 alpha:0.4].CGColor;
    self.normalSolidBlueWithShadowButtonShadowView.layer.shadowOffset = CGSizeMake(0,1);
    self.normalSolidBlueWithShadowButtonShadowView.layer.shadowOpacity = 1;
    self.normalSolidBlueWithShadowButtonShadowView.layer.shadowRadius = 3;
    [self.normalSolidBlueWithShadowButton configAsQQingNormalSolidBlue];
    [self.normalBorderBlueButton configAsQQingNormalBorderBlue];
    self.normalBorderBlueWithShadowButtonShadowView.layer.cornerRadius = 14;
    self.normalBorderBlueWithShadowButtonShadowView.layer.shadowColor = [UIColor colorWithRed:102/255.0 green:206/255.0 blue:255/255.0 alpha:0.4].CGColor;
    self.normalBorderBlueWithShadowButtonShadowView.layer.shadowOffset = CGSizeMake(0,1);
    self.normalBorderBlueWithShadowButtonShadowView.layer.shadowOpacity = 1;
    self.normalBorderBlueWithShadowButtonShadowView.layer.shadowRadius = 3;
    [self.normalBorderBlueWithShadowButton configAsQQingNormalBorderBlueWhenHasShadow];
    [self.normalBorderGrayButton configAsQQingNormalBorderGray];

    [self.smallSolidBlueButton configAsQQingSmallSolidBlue];
    self.smallSolidBlueWithShadowButtonShadowView.layer.cornerRadius = 13;
    self.smallSolidBlueWithShadowButtonShadowView.layer.shadowColor = [UIColor colorWithRed:102/255.0 green:206/255.0 blue:255/255.0 alpha:0.4].CGColor;
    self.smallSolidBlueWithShadowButtonShadowView.layer.shadowOffset = CGSizeMake(0,1);
    self.smallSolidBlueWithShadowButtonShadowView.layer.shadowOpacity = 1;
    self.smallSolidBlueWithShadowButtonShadowView.layer.shadowRadius = 3;
    [self.smallSolidBlueWithShadowButton configAsQQingSmallSolidBlue];
    [self.smallBorderBlueButton configAsQQingSmallBorderBlue];
    self.smallBorderBlueWithShadowButtonShadowView.layer.cornerRadius = 13;
    self.smallBorderBlueWithShadowButtonShadowView.layer.shadowColor = [UIColor colorWithRed:102/255.0 green:206/255.0 blue:255/255.0 alpha:0.4].CGColor;
    self.smallBorderBlueWithShadowButtonShadowView.layer.shadowOffset = CGSizeMake(0,1);
    self.smallBorderBlueWithShadowButtonShadowView.layer.shadowOpacity = 1;
    self.smallBorderBlueWithShadowButtonShadowView.layer.shadowRadius = 3;
    [self.smallBorderBlueWithShadowButton configAsQQingSmallBorderBlueWhenHasShadow];
    [self.smallBorderGrayButton configAsQQingSmallBorderGray];

    [self.miniBorderBlueButton configAsQQingMiniBorderBlue];
    [self.miniBorderGrayButton configAsQQingMiniBorderGray];
    
    self.singleButtonStyleBottomView.delegate = self;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.singleButtonStyleBottomView.isUsedForPayment = YES;
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.singleButtonStyleBottomView.qqingStyleType = kQQingBottomButtonViewStyleType_SameSizeTwoButton;
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.singleButtonStyleBottomView.qqingStyleType = kQQingBottomButtonViewStyleType_LeftSmallRightLarge;
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.singleButtonStyleBottomView.leftButtonTitle = @"上一步";
//        self.singleButtonStyleBottomView.rightButtonTitle = @"确认提交";
//        self.singleButtonStyleBottomView.qqingStyleType = kQQingBottomButtonViewStyleType_SameSizeTwoButton;
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(40 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.singleButtonStyleBottomView.qqingStyleType = kQQingBottomButtonViewStyleType_OnlyOneButton;
//        self.singleButtonStyleBottomView.isUsedForPayment = NO;
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(50 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.singleButtonStyleBottomView.qqingStyleType = kQQingBottomButtonViewStyleType_LeftSmallRightLarge;
//        self.singleButtonStyleBottomView.isUsedForPayment = YES;
//    });
    
    self.sameSizeTwoButtonStyleBottomView.delegate = self;
    self.leftSmallTwoButtonStyleBottomView.delegate = self;
    self.singleButtonStyleBottomView2.delegate = self;
    self.sameSizeTwoButtonStyleBottomView2.delegate = self;
    self.sameSizeTwoButtonStyleBottomView2.disableAdaptiPhoneX = YES;
    self.leftSmallTwoButtonStyleBottomView2.delegate = self;
}

#pragma mark - QQingBottomButtonViewDelegate

- (void)didClickBottomButtonViewLeftButton:(UIButton *)leftButton {
    [QQingUtils showToastWithText:@"点击了左边按钮"];
}

- (void)didClickBottomButtonViewRightButton:(UIButton *)rightButton {
    [QQingUtils showToastWithText:@"点击了右边按钮"];
}

@end


