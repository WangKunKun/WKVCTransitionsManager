//
//  UIImage+Tint.m
//  Battle
//
//  Created by YinDongbing on 16/6/11.
//  Copyright © 2016年 lepin. All rights reserved.
//

#import "UIImage+Tint.h"

@implementation UIImage (Tint)

- (UIImage *)imageWithTintColor:(UIColor *)tintColor{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    UIRectFill(bounds);
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImage;
}

- (UIImage *)scaleWithFixedWidth:(CGFloat)width {
    
    float newHeight = self.size.height * (width / self.size.width);
    CGSize size     = CGSizeMake(width, newHeight);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
    
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageOut;
}

/**
 压图片质量
 
 @param image image
 @param maxSize 最大质量大小 kb单位
 @return Data
 */
+ (NSData *)compressionimage:(UIImage *)image maxSize:(CGFloat)maxSize
{
    if (!image) {
        return nil;
    }
    CGFloat maxFileSize = maxSize*1024;
    CGFloat compression = 0.9f;
    NSData *compressedData = UIImageJPEGRepresentation(image, compression);
    while ([compressedData length] > maxFileSize) {
        compression *= 0.9;
        compressedData = UIImageJPEGRepresentation([[self class] compressImage:image newWidth:image.size.width*compression], compression);
    }
    return compressedData;
}
/**
 *  等比缩放本图片大小
 *
 *  @param newImageWidth 缩放后图片宽度，像素为单位
 *
 *  @return self-->(image)
 */
+ (UIImage *)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth
{
    if (!image) return nil;
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = newImageWidth;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

+ (UIImage *)screenshotsWithFrame:(CGRect)frame
{
    UIView *screenWindow =[UIApplication sharedApplication].keyWindow;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize size = CGSizeMake(screenWindow.frame.size.width * scale, screenWindow.frame.size.height * scale);
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);//全屏截图，包括window
    [screenWindow drawViewHierarchyInRect:screenWindow.bounds afterScreenUpdates:NO];
    UIImage *viewImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect newFrame = CGRectMake(frame.origin.x * scale, frame.origin.y * scale, frame.size.width* scale, frame.size.height* scale);
    UIImage * imgeee = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([viewImage CGImage], newFrame)];
    return imgeee;
}



- (NSArray *)getTransparentPonits
{

    NSMutableArray * points = [NSMutableArray array];
    for (NSUInteger width = 0; width < self.size.width; width ++) {
        for (NSUInteger height = 0; height < self.size.height; height ++) {
            CGPoint point = CGPointMake(width, height);
            if ([self checkIsTransparentWithPoint:point]) {
                [points addObject:[NSValue valueWithCGPoint:point]];
            }
        }
    }
    return points;
}

- (NSArray *)getOpacityPonits
{
    NSMutableArray * points = [NSMutableArray array];
    for (NSUInteger width = 0; width < self.size.width; width ++) {
        for (NSUInteger height = 0; height < self.size.height; height ++) {
            CGPoint point = CGPointMake(width, height);
            if (![self checkIsTransparentWithPoint:point])
            {
                [points addObject:[NSValue valueWithCGPoint:point]];
            }
        }
    }
    return points;
}


- (BOOL)checkAlpha:(CGPoint)point data:(CFDataRef)dataref
{

    const UInt8* data = CFDataGetBytePtr(dataref);
    
    int pixelInfo = ((self.size.width  * point.y) + point.x ) * 4; // The image is png
    UInt8 red = data[pixelInfo];         // If you need this info, enable it
    UInt8 green = data[(pixelInfo + 1)]; // If you need this info, enable it
    UInt8 blue = data[pixelInfo + 2];    // If you need this info, enable it
    UInt8 alpha = data[pixelInfo + 3];     // I need only this info for my maze game

    UIColor* color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f];
    


    return alpha == 0;
}

- (BOOL)checkIsTransparentWithPoint:(CGPoint)point {
    
    
    
    unsigned char pixel[1] = {0};
    CGContextRef context = CGBitmapContextCreate(pixel,
                                                 1, 1, 8, 1, NULL,
                                                 kCGImageAlphaOnly);
    UIGraphicsPushContext(context);
    [self drawAtPoint:CGPointMake(-point.x, -point.y)];
    UIGraphicsPopContext();
    CGContextRelease(context);
    CGFloat alpha = pixel[0] / 255.f;
    
    return alpha < 0.01f;
}

@end
