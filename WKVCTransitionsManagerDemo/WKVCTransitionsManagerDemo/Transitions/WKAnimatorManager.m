//
//  WKAnimatorManager.m
//  WK天气
//
//  Created by qitian on 16/6/29.
//  Copyright © 2016年 王琨. All rights reserved.
//

#import "WKAnimatorManager.h"
#import "WKBaseAnimator.h"
#import "UIViewController+WKTransitions.h"
#import "UINavigationController+WKTransitions.h"



@interface WKAnimatorManager ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer * edgePan;
@property (nonatomic, weak  ) UINavigationController * edgePanVC;
@property (nonatomic, assign) BOOL isLeftSWipPop;

@end

@implementation WKAnimatorManager

+ (instancetype)sharedAnimatorManager
{
    static WKAnimatorManager * m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [WKAnimatorManager new];
    });
    return m;
}

- (void)setAnimator:(WKBaseAnimator *)animator
{
    _animator = animator;

}
#pragma mark 模态推送代理
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    // 推出控制器的动画
    if (self.animator) {
        self.animator.type = YES;
    }
    return self.animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    // 退出控制器动画
    if (self.animator) {
        self.animator.type = NO;
    }
    return self.animator;
}

#pragma mark 导航栏推送代理
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC
{
    
    if (self.animator) {
        self.animator.type = UINavigationControllerOperationPush == operation;
    }
    return self.animator;
}

////下面这一圈都没用上 原因未知，需要调用使用··
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if ([animationController isKindOfClass:[WKBaseAnimator class]])
    {
        WKBaseAnimator * baseA = (WKBaseAnimator *)animationController;
        if (!baseA.type)
        {
            if (baseA.edgeType == UIRectEdgeNone)
            {
                return nil;
            }
            return self.percentDrivenTransition;
        }
    }
    
    return nil;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController * vc = (UIViewController *)viewController;
    if (vc.wk_navAnimator && vc.wk_navAnimator.edgeType != UIRectEdgeNone) {
        [self removeCustomEdgePan];
        self.edgePanVC = navigationController;
        self.edgePan.edges = vc.wk_navAnimator.edgeType;
        [self.edgePanVC.view addGestureRecognizer:self.edgePan];
    }
}


//系统左滑返回x实现方式
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.edgePan) {
        UIScreenEdgePanGestureRecognizer * pan = (UIScreenEdgePanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [pan locationInView:self.edgePanVC.view];
        return (point.x < 50);
    }
    return NO;

}


#pragma mark getter/setter
- (UIScreenEdgePanGestureRecognizer *)edgePan
{
    if (!_edgePan) {
        _edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
        _edgePan.delegate = self;
    }
    return _edgePan;
}

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:self.edgePanVC.view];
    CGFloat progress = point.x / self.edgePanVC.view.bounds.size.width;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.isLeftSWipPop = YES;
            self.percentDrivenTransition = [UIPercentDrivenInteractiveTransition new];
            [self.edgePanVC popViewControllerAnimated:YES];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.percentDrivenTransition updateInteractiveTransition:progress];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            if (progress > self.animator.maxProgress) {
                [self.percentDrivenTransition finishInteractiveTransition];
                [self removeCustomEdgePan];
            }
            else
            {
                [self.percentDrivenTransition cancelInteractiveTransition];
            }
            self.percentDrivenTransition = nil;
            self.isLeftSWipPop = NO;
        }
        default:
            break;
    }
}

- (void)removeCustomEdgePan
{
    if (self.edgePan.view) {
        [self.edgePan.view removeGestureRecognizer:self.edgePan];
    }
    self.edgePan.edges = UIRectEdgeNone;
}

@end
