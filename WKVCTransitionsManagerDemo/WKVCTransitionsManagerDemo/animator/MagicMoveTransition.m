//
//  MagicMoveTransition.m
//  KYMagicMove
//
//  Created by Kitten Yang on 1/17/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "MagicMoveTransition.h"


@interface MagicMoveTransition()

@property (nonatomic, strong) UIView * tempView;//用于动画
@property (nonatomic, assign) CGRect startRect;//起点

@end


@implementation MagicMoveTransition

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.edgeType = UIRectEdgeLeft;
    }
    return self;
}

- (void)present{
    
    //获取两个VC 和 动画发生的容器
    UIViewController *fromVC = self.fromViewController;
    UIViewController *toVC   = self.toViewController;
    UIView *containerView = self.containerView;    
    //对Cell上的 imageView 截图，同时将这个 imageView 本身隐藏
    self.tempView = [self.sourceView snapshotViewAfterScreenUpdates:NO];
    self.tempView.frame = self.startRect = [containerView convertRect:self.sourceView.frame fromView:self.sourceView.superview];
    self.sourceView.hidden = YES;
    //设置第二个控制器的位置、透明度
    toVC.view.frame = [self.transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    //把动画前后的两个ViewController加到容器中,顺序很重要,snapShotView在上方
    [containerView addSubview:toVC.view];
    [containerView addSubview:self.tempView];
    
    
    //0.5就已经回复原状了，0.25就好了
    self.maxProgress = 0.25;
    //动起来。第二个控制器的透明度0~1；让截图SnapShotView的位置更新到最新；
    
    [UIView animateWithDuration:[self transitionDuration] delay:0.0f usingSpringWithDamping:0.8f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        [containerView layoutIfNeeded];
        toVC.view.alpha = 1.0;
        self.tempView.frame = self.endRect;
    } completion:^(BOOL finished) {
        //为了让回来的时候，cell上的图片显示，必须要让cell上的图片显示出来
        self.sourceView.hidden = NO;
        [self.tempView removeFromSuperview];
        //告诉系统动画结束
        [self completeTransition];
        
    }];
}

- (void)dismiss {
    
    UIViewController *fromVC = self.fromViewController;
    UIViewController *toVC   = self.toViewController;
    UIView *containerView = self.containerView;
    //初始化后一个VC的位置
    toVC.view.frame = [self.transitionContext finalFrameForViewController:toVC];
    //顺序很重要，
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [containerView addSubview:self.tempView];
    self.sourceView.hidden = YES;
    //发生动画
    [UIView animateWithDuration:[self transitionDuration] delay:0.0f usingSpringWithDamping:0.8f initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromVC.view.alpha = 0.0f;
        self.tempView.frame = self.startRect;
    } completion:^(BOOL finished) {
        self.sourceView.hidden = NO;
        [self.tempView removeFromSuperview];
        [self completeTransition];
    }];
}

- (NSTimeInterval)transitionDuration{
    return 0.6f;
}

@end




