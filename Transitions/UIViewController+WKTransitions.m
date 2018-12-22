//
//  UIViewController+WKTransitions.m
//  WKVCTransitionsManagerDemo
//
//  Created by wangkun on 2017/11/6.
//  Copyright © 2017年 wangkun. All rights reserved.
//

#import "UIViewController+WKTransitions.h"
#import <objc/runtime.h>
#import "WKAnimatorManager.h"
@implementation UIViewController (WKTransitions)

- (void)setWk_navAnimator:(WKBaseAnimator *)wk_navAnimator
{
    objc_setAssociatedObject(self, @selector(wk_navAnimator), wk_navAnimator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setWk_modelAnimator:(WKBaseAnimator *)wk_modelAnimator
{
    objc_setAssociatedObject(self, @selector(wk_modelAnimator), wk_modelAnimator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WKBaseAnimator *)wk_navAnimator
{
    return objc_getAssociatedObject(self, _cmd);
}

- (WKBaseAnimator *)wk_modelAnimator
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)wk_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    [WKAnimatorManager sharedAnimatorManager].animator = viewControllerToPresent.wk_modelAnimator;
    [self wk_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)wk_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    [WKAnimatorManager sharedAnimatorManager].animator = self.wk_modelAnimator;
    [self wk_dismissViewControllerAnimated:flag completion:completion];
}

+ (void)load{
    Method originalMethod = class_getInstanceMethod([self class], @selector(presentViewController:animated:completion:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(wk_presentViewController:animated:completion:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    
    originalMethod = class_getInstanceMethod([self class], @selector(init));
    swizzledMethod = class_getInstanceMethod([self class], @selector(wk_init));
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    originalMethod = class_getInstanceMethod([self class], @selector(dismissViewControllerAnimated:completion:));
    swizzledMethod = class_getInstanceMethod([self class], @selector(wk_dismissViewControllerAnimated:completion:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (instancetype)wk_init
{
    UIViewController * vc = [self wk_init];
    vc.transitioningDelegate = [WKAnimatorManager sharedAnimatorManager];
    return vc;
}



@end
