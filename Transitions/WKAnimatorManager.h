//
//  WKAnimatorManager.h
//  WK天气
//
//  Created by qitian on 16/6/29.
//  Copyright © 2016年 王琨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WKBaseAnimator;



@interface WKAnimatorManager : NSObject<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) WKBaseAnimator * animator;

+ (instancetype)sharedAnimatorManager;


@end
