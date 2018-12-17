//
//  MagicMoveTransition.h
//  KYMagicMove
//
//  Created by Kitten Yang on 1/17/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "WKBaseAnimator.h"


///参数必传
@interface MagicMoveTransition : WKBaseAnimator

///终点以push为参照点
@property (nonatomic, assign) CGRect   endRect;//终点
@property (nonatomic, strong) UIView * sourceView;

@end
