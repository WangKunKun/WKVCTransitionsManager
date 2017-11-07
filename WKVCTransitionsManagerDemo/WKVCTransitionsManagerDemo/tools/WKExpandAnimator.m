//
//  WKExpandAnimator.m
//  WK天气
//
//  Created by wangkun on 2017/10/18.
//  Copyright © 2017年 王琨. All rights reserved.
//

#import "WKExpandAnimator.h"
#import "UIImage+Tint.h"

@interface WKExpandAnimator ()

@property (nonatomic, assign) NSTimeInterval firstAnimTime;
@property (nonatomic, assign) NSTimeInterval secondAnimTime;

@property (nonatomic, strong) UIImageView * IV;
@property (nonatomic, strong) UIView * tempView;


@end

@implementation WKExpandAnimator


- (void)present
{
    [self.containerView addSubview:self.toViewController.view];
    
    UIView *tempView = [self.fromViewController.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = self.fromViewController.view.frame;
    [self.containerView addSubview:tempView];
    tempView.tag = 999;
    self.tempView = tempView;
    //满足展开的恶趣味
//    UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.containerView.width, self.containerView.height)];
//    whiteView.backgroundColor = [UIColor whiteColor];
//    [self.containerView addSubview:whiteView];
//    whiteView.alpha = 0;
    
    UIImage * image = [UIImage screenshotsWithFrame:self.viewFrame];
    UIImageView * iv = [[UIImageView alloc] initWithImage:image];
    iv.frame = self.viewFrame;
    [self.containerView addSubview:iv];
    iv.tag = 1000;
    self.IV = iv;
    if (self.firstAnimTime == 0) {
        CGFloat distance = fabs(_moveViewNewTop - iv.top);
        NSTimeInterval time = distance * (0.7 / SCREEN_HEIGHT);
        self.firstAnimTime = time < self.secondAnimTime ? self.secondAnimTime : time;
    }
    [UIView animateWithDuration:self.firstAnimTime animations:^{
        iv.top = _moveViewNewTop;//自己设置
        iv.center = CGPointMake(self.containerView.center.x, iv.center.y);
//        whiteView.alpha = 0.5;
        tempView.alpha = 0.0;
//        whiteView.topS =   + iv.heightS;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:self.secondAnimTime animations:^{
                iv.alpha = 0.0;
//                whiteView.top = self.containerView.height;
            } completion:^(BOOL finished) {
                if (finished) {
//                    [whiteView removeFromSuperview];
                    [self completeTransition];
                }

            }];
        }
    }];

}

- (void)dismiss
{

    
    [self.containerView addSubview:self.toViewController.view];
    [self.containerView sendSubviewToBack:self.toViewController.view];
    
    [self.containerView bringSubviewToFront:self.tempView];
    [self.containerView bringSubviewToFront:self.IV];
    
    UIView *newtempView = [self.fromViewController.view snapshotViewAfterScreenUpdates:NO];
    newtempView.frame = self.fromViewController.view.frame;
    [self.containerView insertSubview:newtempView belowSubview:self.tempView];
    
    [UIView animateWithDuration:self.secondAnimTime animations:^{
        self.IV.alpha = 1.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:self.firstAnimTime animations:^{
                self.IV.frame = self.viewFrame;
                self.tempView.alpha = 1.0;
                newtempView.alpha = 0.0;
            } completion:^(BOOL finished) {
                if (finished) {
                    [self.IV removeFromSuperview];
                    [self.tempView removeFromSuperview];
                    [newtempView removeFromSuperview];
                    [self.containerView bringSubviewToFront:self.toViewController.view];
                    [self completeTransition];
                }
            }];
        }
    }];
}


- (NSTimeInterval)secondAnimTime
{
    return 0.15;
}


@end
