//
//  UIViewController+WKTransitions.h
//  WKVCTransitionsManagerDemo
//
//  Created by wangkun on 2017/11/6.
//  Copyright © 2017年 wangkun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKBaseAnimator.h"
@interface UIViewController (WKTransitions)

@property (nonatomic, strong) WKBaseAnimator * wk_modelAnimator;//模态推送用
@property (nonatomic, strong) WKBaseAnimator * wk_navAnimator;//导航栏推送用

@end
