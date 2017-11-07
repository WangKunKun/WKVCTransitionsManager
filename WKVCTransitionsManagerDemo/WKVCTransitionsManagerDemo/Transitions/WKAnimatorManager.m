//
//  WKAnimatorManager.m
//  WK天气
//
//  Created by qitian on 16/6/29.
//  Copyright © 2016年 王琨. All rights reserved.
//

#import "WKAnimatorManager.h"
#import "WKCircleSpreadAnimator.h"
#import "WKExpandAnimator.h"

typedef NS_ENUM(NSInteger, WKAnimatorStyle)
{
    WKAnimatorStyle_CircleSpread,
    WKAnimatorStyle_Expand,
    WKAnimatorStyle_None
    
};


@interface WKAnimatorManager ()

@property (nonatomic, assign) WKAnimatorStyle style;
//@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;
//@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer * edgePan;
//@property (nonatomic, strong) UINavigationController * edgePanVC;
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
    _style = animator == nil ? WKAnimatorStyle_None : ([animator isKindOfClass:[WKExpandAnimator class]] ? WKAnimatorStyle_Expand : WKAnimatorStyle_CircleSpread);
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
    BOOL flag = NO;// self.style == WKAnimatorStyle_Expand && operation == UINavigationControllerOperationPop;
    return flag ? nil : self.animator;
}

//左滑返回 暂未实现~
////下面这一圈都没用上 原因未知，需要调用使用··
//- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
//{
//    if ([animationController isKindOfClass:[WKBaseAnimator class]])
//    {
//        WKBaseAnimator * baseA = (WKBaseAnimator *)animationController;
//        if (baseA.type) {//pop
//            self.edgePanVC = navigationController;
//            self.edgePan.edges = UIRectEdgeLeft;
//            if (_edgePan.view) {
//                [_edgePan.view removeGestureRecognizer:_edgePan];
//            }
//            [navigationController.view addGestureRecognizer:self.edgePan];
//        }
//        else
//        {
//            return self.percentDrivenTransition;
//        }
//    }
//    
//
//    return nil;
//}

//- (UIPercentDrivenInteractiveTransition *)percentDrivenTransition
//{
//    if (!_percentDrivenTransition) {
//        _percentDrivenTransition = [UIPercentDrivenInteractiveTransition new];
//    }
//    return _percentDrivenTransition;
//}

//- (UIScreenEdgePanGestureRecognizer *)edgePan
//{
//    if (!_edgePan) {
//        _edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
//    }
//    return _edgePan;
//}
//
//- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)pan
//{
//    CGFloat progress = [pan translationInView:self.edgePanVC.view].x / self.edgePanVC.view.bounds.size.width;
//    switch (pan.state) {
//        case UIGestureRecognizerStateBegan:
//        {
//            [self.edgePanVC popViewControllerAnimated:YES];
//            self.percentDrivenTransition = [UIPercentDrivenInteractiveTransition new];
//        }
//            break;
//        case UIGestureRecognizerStateChanged:
//        {
//            [self.percentDrivenTransition updateInteractiveTransition:progress];
//        }
//            break;
//        case UIGestureRecognizerStateCancelled:
//        case UIGestureRecognizerStateEnded:
//        {
//            if (progress > 0.5) {
//                [self.percentDrivenTransition finishInteractiveTransition];
//            }
//            else
//            {
//                [self.percentDrivenTransition cancelInteractiveTransition];
//            }
//            self.percentDrivenTransition = nil;
//        }
//        default:
//            break;
//    }
//}

@end
