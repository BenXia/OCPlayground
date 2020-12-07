//
//  CustomContainerVC.h
//  student
//
//  Created by Ben on 2020/12/3.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CustomContainerVCDisplayMode) {
    CustomContainerVCDisplayModeCalendar = 0,
    CustomContainerVCDisplayModeList,
};

@interface CustomContainerVC : BaseViewController

@property (nonatomic, assign, readonly) CustomContainerVCDisplayMode displayMode;

@end

NS_ASSUME_NONNULL_END


