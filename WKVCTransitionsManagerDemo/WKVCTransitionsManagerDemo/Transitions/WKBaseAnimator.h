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

///是否支持滑动返回，以及滑动返回触发的位置  默认 UIRectEdgeNone 不支持滑动返回
///warnning 注意 如果是希望支持，动画不能是layer层级动画，需要是view层级动画
@property (nonatomic) UIRectEdge edgeType;

///和上述属性配合适合 做滑返回时，进程超过多少执行返回 0~1之间
@property (nonatomic, assign) CGFloat maxProgress;
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
