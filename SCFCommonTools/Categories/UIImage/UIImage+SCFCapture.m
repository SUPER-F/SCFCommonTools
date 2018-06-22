//
//  UIImage+SCFCapture.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/21.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIImage+SCFCapture.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (SCFCapture)

+ (UIImage *)scf_imageCaptureWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, [UIScreen mainScreen].scale);
    // iOS7 及其后续版本
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    }
    else {  // iOS7 之前版本
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

+ (UIImage *)scf_imageWithSize:(CGRect)rect fromImage:(UIImage *)fromImage {
    // 原图fromImage
    CGImageRef fromImageRef = fromImage.CGImage;
    // 自定义rect的截图区域
    CGImageRef subImageRef = CGImageCreateWithImageInRect(fromImageRef, rect);
    CGSize size;
    size.width = CGRectGetWidth(rect);
    size.height = CGRectGetHeight(rect);
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, rect, subImageRef);
    
    UIImage *subImage = [UIImage imageWithCGImage:subImageRef];
    
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    return subImage;
}

+ (UIImage *)scf_imageScreenshotWithView:(UIView *)aView limitWidth:(CGFloat)limitWidth {
    // 获取原view的transform
    CGAffineTransform oldTransform = aView.transform;
    
    CGAffineTransform scaleTransform = CGAffineTransformIdentity;
    if (!isnan(limitWidth) && limitWidth > 0) {
        CGFloat limitScale = limitWidth / CGRectGetWidth(aView.frame);
        CGAffineTransform transformScale = CGAffineTransformMakeScale(limitScale, limitScale);
        scaleTransform = CGAffineTransformConcat(oldTransform, transformScale);
    }
    if (!CGAffineTransformEqualToTransform(scaleTransform, CGAffineTransformIdentity)) {
        aView.transform = scaleTransform;
    }
    
    // 已经转换过后的frame
    CGRect actureFrame = aView.frame;
    // 已经转换过后的bounds
    CGRect actureBounds = aView.bounds;
    
    UIGraphicsBeginImageContextWithOptions(actureFrame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, actureFrame.size.width / 2.0, actureFrame.size.height / 2.0);
    CGContextConcatCTM(context, aView.transform);
    CGPoint anchorPoint = aView.layer.anchorPoint;
    CGContextTranslateCTM(context, -actureBounds.size.width * anchorPoint.x, -actureBounds.size.height *anchorPoint.y);
    if ([aView respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [aView drawViewHierarchyInRect:aView.bounds afterScreenUpdates:NO];
    }
    else {
        [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    // 恢复原view的transform
    aView.transform = oldTransform;
    
    return screenshot;
}

@end
