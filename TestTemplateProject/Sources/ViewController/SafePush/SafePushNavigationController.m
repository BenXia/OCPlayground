//
//  SafePushNavigationController.m
//
//  https://github.com/nexuspod/SafeTransition
//
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 WenBi
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "SafePushNavigationController.h"

typedef void (^APTransitionBlock)(void);

@interface SafePushNavigationController () <UINavigationControllerDelegate> {
    BOOL _transitionInProgress;
    NSMutableArray *_peddingBlocks;
    CGFloat _systemVersion;
}

@end

@implementation SafePushNavigationController

#pragma mark - Creating Navigation Controllers

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(pushViewController:animated:);
        SEL swizzledSelector = @selector(qqpushViewController:animated:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _transitionInProgress = NO;
    _peddingBlocks = [NSMutableArray arrayWithCapacity:2];
    _systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
}

/// 是否打开 safePush，默认一直打开，否则按照原逻辑，只在 iOS7 下打开
- (BOOL)needSafePush
{
    return YES;
    
//    if ([self alwaysSafePush])
//    {
//        return YES;
//    }
//    else
//    {
//        if ([g_commonConfig isOpenAllSafePush])
//        {
//            return _systemVersion < 12.0;
//        }
//        else
//        {
//            return _systemVersion < 8.0;
//        }
//    }
}

- (BOOL)alwaysSafePush
{
    return NO;
}

#pragma mark - Pushing and Popping Stack Items

- (void)qqpushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    UIViewController* topVC = [super topViewController];
//    if ([topVC isKindOfClass:[BaseViewController class]]) {
//        ((BaseViewController*)topVC).disappearType = ControllerDisappearTypePushed;
//    }
    if (! [self needSafePush]) {
        [super pushViewController:viewController animated:animated];
    }
    else {
        // NSLog(@"00000000");
        __weak typeof(self) weakSelf = self;
        [self addTransitionBlock:^{
            [weakSelf qqpushViewController:viewController animated:animated];
        }];
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
//    UIViewController* topVC = [super topViewController];
//    if ([topVC isKindOfClass:[BaseViewController class]]) {
//        ((BaseViewController*)topVC).disappearType = ControllerDisappearTypePoped;
//    }
    UIViewController *poppedViewController = nil;
    if (! [self needSafePush]) {
        poppedViewController = [super popViewControllerAnimated:animated];
    }
    else {
        __weak SafePushNavigationController *weakSelf = self;
        [self addTransitionBlock:^{
            UIViewController *viewController = [weakSelf superPopViewControllerAnimated:animated];
            if (viewController == nil) {
                weakSelf.transitionInProgress = NO;
            }
        }];
    }
    return poppedViewController;
}

- (UIViewController *)superPopViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    UIViewController* topVC = [super topViewController];
//    if ([topVC isKindOfClass:[BaseViewController class]]) {
//        ((BaseViewController*)topVC).disappearType = ControllerDisappearTypePoped;
//    }
    NSArray *poppedViewControllers = nil;
    if (! [self needSafePush]) {
        poppedViewControllers = [super popToViewController:viewController animated:animated];
    }
    else {
        __weak SafePushNavigationController *weakSelf = self;
        [self addTransitionBlock:^{
            if ([weakSelf.viewControllers containsObject:viewController]) {
                NSArray *viewControllers = [weakSelf superPopToViewController:viewController animated:animated];
                if (viewControllers.count == 0) {
                    weakSelf.transitionInProgress = NO;
                }
            }
            else {
                weakSelf.transitionInProgress = NO;
            }
        }];
    }
    return poppedViewControllers;
}

- (NSArray *)superPopToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    return [super popToViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
//    UIViewController* topVC = [super topViewController];
//    if ([topVC isKindOfClass:[BaseViewController class]]) {
//        ((BaseViewController*)topVC).disappearType = ControllerDisappearTypePoped;
//    }
    NSArray *poppedViewControllers = nil;
    if (! [self needSafePush]) {
        poppedViewControllers = [super popToRootViewControllerAnimated:animated];
    }
    else {
        __weak SafePushNavigationController *weakSelf = self;
        [self addTransitionBlock:^{
            NSArray *viewControllers = [weakSelf superPopToRootViewControllerAnimated:animated];
            if (viewControllers.count == 0) {
                weakSelf.transitionInProgress = NO;
            }
        }];
    }
    return poppedViewControllers;
}

- (NSArray *)superPopToRootViewControllerAnimated:(BOOL)animated
{
    return [super popToRootViewControllerAnimated:animated];
}

#pragma mark - Accessing Items on the Navigation Stack

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
    if (! [self needSafePush]) {
        [super setViewControllers:viewControllers animated:animated];
    }
    else {
        __weak SafePushNavigationController *weakSelf = self;
        [self addTransitionBlock:^{
            NSArray *originalViewControllers = weakSelf.viewControllers;
            NSLog(@"%s", __FUNCTION__);
            [weakSelf superSetViewControllers:viewControllers animated:animated];
            if (!animated || originalViewControllers.lastObject == viewControllers.lastObject) {
                weakSelf.transitionInProgress = NO;
            }
        }];
    }
}

- (void)superSetViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
    [super setViewControllers:viewControllers animated:animated];
}

#pragma mark - Transition Manager

- (void)addTransitionBlock:(void (^)(void))block
{
    if (![self isTransitionInProgress]) {
        // NSLog(@"111111111");
        self.transitionInProgress = YES;
        block();
    }
    else {
        [_peddingBlocks addObject:[block copy]];
        // NSLog(@"222222222 ----- %@", _peddingBlocks);
    }
}

- (BOOL)isTransitionInProgress
{
    return _transitionInProgress;
}

- (void)setTransitionInProgress:(BOOL)transitionInProgress
{
    // NSLog(@"3333333  ----- %@", _peddingBlocks);
    _transitionInProgress = transitionInProgress;
    if (!transitionInProgress && _peddingBlocks.count > 0) {
        //        _transitionInProgress = YES;    // 这一句要删除，否则 runNextTransition 时执行的 block 又会调到子类的实现中 addTransitionBlock:
        // NSLog(@"4444444");
        [self runNextTransition];
    }
}

- (void)runNextTransition
{
    APTransitionBlock block = _peddingBlocks.firstObject;
    [_peddingBlocks removeObject:block];
    // NSLog(@"55555555 --- %@", _peddingBlocks);
    block();
}

@end


