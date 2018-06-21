//
//  UIImage+SCFAlpha.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/21.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIImage+SCFAlpha.h"

@implementation UIImage (SCFAlpha)

- (BOOL)scf_imageHasAlpha {
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst
            || alpha == kCGImageAlphaLast
            || alpha == kCGImageAlphaPremultipliedFirst
            || alpha == kCGImageAlphaPremultipliedLast);
}

- (UIImage *)scf_imageAddAlpha {
    if ([self scf_imageHasAlpha]) {
        return self;
    }
    
    CGImageRef imageRef = self.CGImage;
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    // bitsPerComponent和bitmapInfo值是硬编码的，以防止出现“不支持的参数组合”错误
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 width,
                                                 height,
                                                 8,
                                                 0,
                                                 CGImageGetColorSpace(imageRef),
                                                 kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    
    // 将图像绘制到上下文中并检索新的图像，该图像现在有一个alpha层
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGImageRef imageRefWithAlpha = CGBitmapContextCreateImage(context);
    
    // 添加alpha通道后的image
    UIImage *imageWithAlpha = [UIImage imageWithCGImage:imageRefWithAlpha];
    
    CGContextRelease(context);
    CGImageRelease(imageRefWithAlpha);
    
    return imageWithAlpha;
}

- (UIImage *)scf_imageAddTransparentBorderWithWidth:(NSUInteger)borderWidth {
    // 如果没有alpha通道，则增加alpha通道
    UIImage *image = [self scf_imageAddAlpha];
    
    CGRect newRect = CGRectMake(0, 0, image.size.width + borderWidth * 2, image.size.height + borderWidth * 2);
    
    // 构建与新大小相同的上下文
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL,
                                                       newRect.size.width,
                                                       newRect.size.height,
                                                       CGImageGetBitsPerComponent(self.CGImage),
                                                       0,
                                                       CGImageGetColorSpace(self.CGImage),
                                                       CGImageGetBitmapInfo(self.CGImage));
    // 在上下文的中心绘制图像，在边缘处留下一个空隙
    CGRect imageLocation = CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height);
    CGContextDrawImage(bitmapContext, imageLocation, self.CGImage);
    CGImageRef borderImageRef = CGBitmapContextCreateImage(bitmapContext);
    
    // 创建一个蒙版使边框透明，并将其与图像结合
    CGImageRef maskImageRef = [UIImage scf_imageNewBorderMask:borderWidth size:newRect.size];
    CGImageRef transparentBorderImageRef = CGImageCreateWithMask(borderImageRef, maskImageRef);
    
    // 添加透明边框后的image
    UIImage *transparentBorderImage = [UIImage imageWithCGImage:transparentBorderImageRef];
    
    CGContextRelease(bitmapContext);
    CGImageRelease(borderImageRef);
    CGImageRelease(maskImageRef);
    CGImageRelease(transparentBorderImageRef);
    
    return transparentBorderImage;
}

- (UIImage *)scf_imageCutTransparentBorderToBetterSize {
    CGImageRef inImage = self.CGImage;
    CFDataRef m_dataRef = CGDataProviderCopyData(CGImageGetDataProvider(inImage));
    
    UInt8 *m_pixelBuf = (UInt8 *)CFDataGetBytePtr(m_dataRef);
    
    CGFloat width = CGImageGetWidth(inImage);
    CGFloat height = CGImageGetHeight(inImage);
    
    CGPoint top, left, right, bottom;
    //轮询确定image不透明的top, left, right, bottom
    BOOL breakOut = NO;
    for (int x = 0; breakOut == NO && x < width; x++) {
        for (int y = 0; y < height; y++) {
            int loc = x + (y * width);
            loc *= 4;
            if (m_pixelBuf[loc + 3] != 0) {
                left = CGPointMake(x, y);
                breakOut = YES;
                break;
            }
        }
    }
    
    breakOut = NO;
    for (int y = 0; breakOut == NO && y < height; y++) {
        for (int x = 0; x < width; x++) {
            int loc = x + (y * width);
            loc *= 4;
            if (m_pixelBuf[loc + 3] != 0) {
                top = CGPointMake(x, y);
                breakOut = YES;
                break;
            }
        }
    }
    
    breakOut = NO;
    for (int y = height - 1; breakOut == NO && y >= 0; y--) {
        for (int x = width - 1; x >= 0; x--) {
            int loc = x + (y * width);
            loc *= 4;
            if (m_pixelBuf[loc + 3] != 0) {
                bottom = CGPointMake(x, y);
                breakOut = YES;
                break;
            }
        }
    }
    
    breakOut = NO;
    for (int x = width - 1; breakOut == NO && x >= 0; x--) {
        for (int y = height - 1; y >= 0; y--) {
            int loc = x + (y * width);
            loc *= 4;
            if (m_pixelBuf[loc + 3] != 0) {
                right = CGPointMake(x, y);
                breakOut = YES;
                break;
            }
        }
    }
    
    CGFloat scale = self.scale;
    // 裁切尺寸
    CGRect cropRect = CGRectMake(left.x / scale, top.y / scale, (right.x - left.x) / scale, (bottom.y - top.y) / scale);
    
    UIGraphicsBeginImageContextWithOptions(cropRect.size, NO, scale);
    [self drawAtPoint:CGPointMake(-cropRect.origin.x, -cropRect.origin.y)
            blendMode:kCGBlendModeCopy
                alpha:1.0];
    
    // 裁切后的image
    UIImage *croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    CFRelease(m_dataRef);
    
    return croppedImage;
}

#pragma mark - private methods
// 创建一个蒙版，使外缘透明，其他一切都不透明
// 尺寸必须包括整个蒙版(不透明部分+透明边框)
// 调用方通过调用CGImageRelease来释放返回的引用
+ (CGImageRef)scf_imageNewBorderMask:(NSUInteger)borderSize size:(CGSize)size {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // 构建与新大小相同的上下文
    CGContextRef maskContext = CGBitmapContextCreate(NULL,
                                                     size.width,
                                                     size.height,
                                                     8,  // 8 bit grayscale
                                                     0,
                                                     colorSpace,
                                                     kCGBitmapByteOrderDefault | kCGImageAlphaNone);
    
    // 一个全透明的蒙版
    CGContextSetFillColorWithColor(maskContext, [UIColor blackColor].CGColor);
    CGContextFillRect(maskContext, CGRectMake(0, 0, size.width, size.height));
    
    // 使内部部分(边框内)不透明
    CGContextSetFillColorWithColor(maskContext, [UIColor whiteColor].CGColor);
    CGContextFillRect(maskContext, CGRectMake(borderSize, borderSize, size.width - borderSize * 2, size.height - borderSize * 2));
    
    // 从上下文获取image
    CGImageRef maskImageRef = CGBitmapContextCreateImage(maskContext);
    
    CGContextRelease(maskContext);
    CGColorSpaceRelease(colorSpace);
    
    return maskImageRef;
}

@end
