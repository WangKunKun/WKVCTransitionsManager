//
//  WKWindowedModelAnimator.m
//  WK天气
//
//  Created by qitian on 16/6/29.
//  Copyright © 2016年 王琨. All rights reserved.
//

#import "WKWindowedModelAnimator.h"

@implementation WKWindowedModelAnimator

- (void)present
{
    UIView *tempView = [self.fromViewController.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = self.fromViewController.view.frame;
    tempView.layer.cornerRadius = 10;
    tempView.layer.masksToBounds = YES;
    self.fromViewController.view.hidden = YES;

    [self.containerView addSubview:tempView];
    [self.containerView addSubview:self.toViewController.view];
    
    self.toViewController.view.frame = CGRectMake(0, self.containerView.height, self.containerView.width, _toViewHeight);
    self.toViewController.view.layer.cornerRadius = 10;
    self.toViewController.view.layer.masksToBounds = YES;

    //开始动画吧，使用产生弹簧效果的动画API
    [UIView animateWithDuration:self.transitionDuration delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 / 0.55 options:0 animations:^{
        //首先我们让vc2向上移动
        self.toViewController.view.transform = CGAffineTransformMakeTranslation(0, -_toViewHeight);
        //然后让截图视图缩小一点即可
        tempView.transform = CGAffineTransformMakeScale(0.85, 0.85);
    } completion:^(BOOL finished) {
        [self completeTransition];
    }];
}

- (void)dismiss
{
    NSArray *subviewsArray = self.containerView.subviews;
    UIView *tempView = subviewsArray[MIN(subviewsArray.count, MAX(0, subviewsArray.count - 2))];
    //动画吧
    [UIView animateWithDuration:self.transitionDuration animations:^{
        //因为present的时候都是使用的transform，这里的动画只需要将transform恢复就可以了
        self.fromViewController.view.transform = CGAffineTransformIdentity;
        tempView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self completeTransition];
        self.fromViewController.view.layer.cornerRadius = 0;

        self.toViewController.view.hidden = NO;
        [tempView removeFromSuperview];

    }];
}

@end
