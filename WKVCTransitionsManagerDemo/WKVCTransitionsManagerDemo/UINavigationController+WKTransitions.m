//
//  UINavigationController+WKTransitions.m
//  WKVCTransitionsManagerDemo
//
//  Created by wangkun on 2017/11/6.
//  Copyright © 2017年 wangkun. All rights reserved.
//

#import "UINavigationController+WKTransitions.h"
#import <objc/runtime.h>
#import "WKAnimatorManager.h"
@interface UINavigationController ()


@end

@implementation UINavigationController (WKTransitions)


+ (void)load{

    
    Method originalMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(wk_pushViewController:animated:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
//    originalMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
//    swizzledMethod = class_getInstanceMethod([self class], @selector(wk_viewDidLoad));
//    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    originalMethod = class_getInstanceMethod([self class], @selector(popToRootViewControllerAnimated:));
    swizzledMethod = class_getInstanceMethod([self class], @selector(wk_popToRootViewControllerAnimated:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    originalMethod = class_getInstanceMethod([self class], @selector(popToViewController:animated:));
    swizzledMethod = class_getInstanceMethod([self class], @selector(wk_popToViewController:animated:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    originalMethod = class_getInstanceMethod([self class], @selector(popViewControllerAnimated:));
    swizzledMethod = class_getInstanceMethod([self class], @selector(wk_popViewControllerAnimated:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = [WKAnimatorManager sharedAnimatorManager];
}



- (void)wk_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self setAnimatorWithVC:viewController];
    [self wk_pushViewController:viewController animated:animated];
}

- (UIViewController *)wk_popViewControllerAnimated:(BOOL)animated
{
    [self setAnimatorWithVC:self.visibleViewController];
    return [self wk_popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)wk_popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self setAnimatorWithVC:viewController];
    return [self wk_popToViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)wk_popToRootViewControllerAnimated:(BOOL)animated
{
    [self setAnimatorWithVC:self.viewControllers.firstObject];
    return [self wk_popToRootViewControllerAnimated:animated];
}


- (void)setAnimatorWithVC:(UIViewController *)vc
{
    [WKAnimatorManager sharedAnimatorManager].animator = vc.wk_navAnimator;
}

@end
