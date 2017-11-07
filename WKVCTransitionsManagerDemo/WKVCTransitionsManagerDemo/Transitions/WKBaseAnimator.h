//
//  WKBaseAnimator.h
//  WK天气
//
//  Created by qitian on 16/6/29.
//  Copyright © 2016年 王琨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIViewExt.h"

@interface WKBaseAnimator : NSObject<UIViewControllerAnimatedTransitioning>


/**
 *  YES  push/present  NO pop/dismiss
 */
@property (nonatomic) BOOL type;

/**
 *  动画执行时间(默认值为0.5s)
 */
@property (nonatomic) NSTimeInterval  transitionDuration;

/**
 *  子类复写方法
 */
- (void)present;

- (void)dismiss;

/**
 *  animateTransitionEvent 中有效
 */
@property (nonatomic, readonly, weak) UIViewController *fromViewController;

@property (nonatomic, readonly, weak) UIViewController *toViewController;

@property (nonatomic, readonly, weak) UIView           *containerView;

@property (nonatomic, weak, readonly) id <UIViewControllerContextTransitioning> transitionContext;

/**
 *  动画事件结束
 */
- (void)completeTransition;


@end
