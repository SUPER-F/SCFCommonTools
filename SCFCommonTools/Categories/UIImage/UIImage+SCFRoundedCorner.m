//
//  UIImage+SCFRoundedCorner.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/25.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIImage+SCFRoundedCorner.h"
#import "UIImage+SCFAlpha.h"

@implementation UIImage (SCFRoundedCorner)

// Creates a copy of this image with rounded corners
// If borderSize is non-zero, a transparent border of the given size will also be added
// Original author: Björn Sållarp. Used with permission. See: http://blog.sallarp.com/iphone-uiimage-round-corners/
- (UIImage *)scf_imageRoundedCornerWithCornerSize:(CGFloat)cornerSize borderSize:(CGFloat)borderSize {
    // 如果图片没有alpha通道，则添加alpha通道
    UIImage *image = [self scf_imageAddAlpha];
    
    // 构建与新大小相同的上下文
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 image.size.width,
                                                 image.size.height,
                                                 CGImageGetBitsPerComponent(image.CGImage),
                                                 0,
                                                 CGImageGetColorSpace(image.CGImage),
                                                 CGImageGetBitmapInfo(image.CGImage));
    
    // 创建一个带有圆角的剪切路径
    CGContextBeginPath(context);
    [self scf_addRoundedRectToPath:CGRectMake(borderSize, borderSize, image.size.width - borderSize * 2.0, image.size.height - borderSize * 2.0)
                           context:context
                         ovalWidth:cornerSize
                        ovalHeight:cornerSize];
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), image.CGImage);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    UIImage *roundedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return roundedImage;
}

#pragma mark - private methods
// Adds a rectangular path to the given context and rounds its corners by the given extents
// Original author: Björn Sållarp. Used with permission. See: http://blog.sallarp.com/iphone-uiimage-round-corners/
- (void)scf_addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight {
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, ovalWidth, ovalHeight);
    CGFloat fw = CGRectGetWidth(rect) / ovalWidth;
    CGFloat fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh / 2.0);
    CGContextAddArcToPoint(context, fw, fh, fw / 2.0, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh / 2.0, 1);
    CGContextAddArcToPoint(context, 0, 0, fw / 2.0, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh / 2.0, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}


@end
