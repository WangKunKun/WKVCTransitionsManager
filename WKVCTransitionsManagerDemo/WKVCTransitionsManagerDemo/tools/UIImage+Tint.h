//
//  UIImage+Tint.h
//  Battle
//
//  Created by YinDongbing on 16/6/11.
//  Copyright © 2016年 lepin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tint)

- (UIImage *)imageWithTintColor:(UIColor *)tintColor;
- (UIImage *)scaleWithFixedWidth:(CGFloat)width;
+ (NSData *)compressionimage:(UIImage *)image maxSize:(CGFloat)maxSize;
+ (UIImage *)screenshotsWithFrame:(CGRect)frame;


- (NSArray *)getOpacityPonits;//获得不透明点
- (NSArray *)getTransparentPonits;//获得透明点 透明度 小于0.01 即透明

@end
