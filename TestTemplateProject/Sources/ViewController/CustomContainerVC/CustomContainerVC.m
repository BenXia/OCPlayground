//
//  CustomContainerVC.m
//  student
//
//  Created by Ben on 2020/12/3.
//

#import "CustomContainerVC.h"
#import "ContainerLeftChildVC.h"
#import "ContainerRightChildVC.h"

static NSString *kCustomContainerVCSwitchDisplayModeAnimationID = @"kCustomContainerVCSwitchDisplayModeAnimationID";

static BOOL s_inSwitchAnimation = NO;

@interface CustomContainerVC ()

@property (weak, nonatomic) IBOutlet UIButton *switchDisplayModeButton;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, strong) ContainerLeftChildVC *leftChildVC;
@property (nonatomic, strong) ContainerRightChildVC *rightChildVC;

@property (nonatomic, assign, readwrite) CustomContainerVCDisplayMode displayMode;

@end

@implementation CustomContainerVC

#pragma mark - View life cycle

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self initUIRelated];
}

- (BOOL)preferHideNavBar {
    return YES;
}

#pragma mark - Private methods

- (void)initUIRelated {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.displayMode = CustomContainerVCDisplayModeCalendar;
    [self addChildViewController:self.leftChildVC];
    [self addChildViewController:self.rightChildVC];
    
    _leftChildVC.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    _rightChildVC.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    
    if (self.displayMode == CustomContainerVCDisplayModeCalendar) {
        [_switchDisplayModeButton setTitle:@"列表" forState:UIControlStateNormal];
        [_containerView addSubview:self.leftChildVC.view];
    } else {
        [_switchDisplayModeButton setTitle:@"日历" forState:UIControlStateNormal];
        [_containerView addSubview:self.rightChildVC.view];
    }
}

#pragma mark - IBActions

- (IBAction)didClickSwitchDisplayModeButton:(UIButton *)sender {
    if (s_inSwitchAnimation) {
        return;
    }
    
    s_inSwitchAnimation = YES;
    
    
    CustomContainerVCDisplayMode displayModeToSet = CustomContainerVCDisplayModeCalendar;
    NSString *buttonTitleToUse = @"";
    UIViewController *vcToShow = nil;
    UIViewController *vcToRemove = nil;
    UIViewAnimationTransition animationTransitionToUse = UIViewAnimationTransitionNone;
    UIViewAnimationOptions optionTransitionToUse = UIViewAnimationOptionTransitionNone;
    
    if (_displayMode == CustomContainerVCDisplayModeCalendar) {
        displayModeToSet = CustomContainerVCDisplayModeList;
        buttonTitleToUse = @"日历";
        vcToShow = self.rightChildVC;
        vcToRemove = self.leftChildVC;
        animationTransitionToUse = UIViewAnimationTransitionFlipFromRight;
        optionTransitionToUse = UIViewAnimationOptionTransitionFlipFromLeft;
    } else {
        displayModeToSet = CustomContainerVCDisplayModeCalendar;
        buttonTitleToUse = @"列表";
        vcToShow = self.leftChildVC;
        vcToRemove = self.rightChildVC;
        animationTransitionToUse = UIViewAnimationTransitionFlipFromLeft;
        optionTransitionToUse = UIViewAnimationOptionTransitionFlipFromRight;
    }
    
    // 方案1:
    [vcToShow viewWillAppear:YES];
    [vcToRemove viewWillDisappear:YES];
    [UIView transitionFromView:vcToRemove.view
                        toView:vcToShow.view
                      duration:0.5f
                       options:UIViewAnimationOptionCurveEaseInOut|optionTransitionToUse
                    completion:^(BOOL finished) {
        [vcToRemove viewDidDisappear:YES];
        [vcToShow viewDidAppear:YES];
        
        _displayMode = displayModeToSet;
        [_switchDisplayModeButton setTitle:buttonTitleToUse forState:UIControlStateNormal];

        s_inSwitchAnimation = NO;
    }];
    
    // 方案2:
//    [UIView transitionWithView:_containerView
//                      duration:0.5f
//                       options:UIViewAnimationOptionCurveEaseInOut|optionTransitionToUse
//                    animations:^{
//        [vcToShow viewWillAppear:YES];
//        [vcToRemove viewWillDisappear:YES];
//        if (vcToRemove && vcToRemove.view.superview) {
//            [vcToRemove.view removeFromSuperview];
//        }
//        if (vcToShow) {
//            [_containerView addSubview:vcToShow.view];
//        }
//        [vcToRemove viewDidDisappear:YES];
//        [vcToShow viewDidAppear:YES];
//    } completion:^(BOOL finished) {
//        _displayMode = displayModeToSet;
//        [_switchDisplayModeButton setTitle:buttonTitleToUse forState:UIControlStateNormal];
//
//        s_inSwitchAnimation = NO;
//    }];
    
    // 方案3:
//    [UIView beginAnimations:kCustomContainerVCSwitchDisplayModeAnimationID context:(__bridge_retained void *)@{ @"displayModeToSet": @(displayModeToSet), @"buttonTitleToUse": buttonTitleToUse}];
//    [UIView setAnimationDuration:1];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationTransition:animationTransitionToUse forView:_containerView cache:YES];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
//
//    [vcToShow viewWillAppear:YES];
//    [vcToRemove viewWillDisappear:YES];
//    if (vcToRemove && vcToRemove.view.superview) {
//        [vcToRemove.view removeFromSuperview];
//    }
//    if (vcToShow) {
//        [_containerView addSubview:vcToShow.view];
//    }
//    [vcToRemove viewDidDisappear:YES];
//    [vcToShow viewDidAppear:YES];
//
//    [UIView commitAnimations];
}

//- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
//    if ([animationID isEqualToString:kCustomContainerVCSwitchDisplayModeAnimationID]) {
//        NSDictionary *dict = (__bridge_transfer id)context;
//
//        if (dict && [dict isKindOfClass:[NSDictionary class]]) {
//            CustomContainerVCDisplayMode displayModeToSet = (CustomContainerVCDisplayMode)([dict[@"displayModeToSet"] integerValue]);
//            NSString *buttonTitleToUse = dict[@"buttonTitleToUse"];
//
//            _displayMode = displayModeToSet;
//            [_switchDisplayModeButton setTitle:buttonTitleToUse forState:UIControlStateNormal];
//        }
//
//        s_inSwitchAnimation = NO;
//    }
//}

#pragma mark - Properties

- (ContainerLeftChildVC *)leftChildVC {
    if (!_leftChildVC) {
        _leftChildVC = [[ContainerLeftChildVC alloc] init];
    }
    
    return _leftChildVC;
}

- (ContainerRightChildVC *)rightChildVC {
    if (!_rightChildVC) {
        _rightChildVC = [[ContainerRightChildVC alloc] init];
    }
    
    return _rightChildVC;
}

@end


