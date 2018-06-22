//
//  UIImage+SCFScale.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/22.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

//
//  UIImage+FX.h
//
//  Version 1.2.3
//
//  Created by Nick Lockwood on 31/10/2011.
//  Copyright (c) 2011 Charcoal Design
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/FXImageView
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import "UIImage+SCFScale.h"

@implementation UIImage (SCFScale)

- (UIImage *)scf_imageCroppedToRect:(CGRect)rect {
    // begin drawing context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    
    // draw
    [self drawAtPoint:CGPointMake(-rect.origin.x, -rect.origin.y)];
    
    // capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // end drawing context
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)scf_imageScaledToSize:(CGSize)size {
    // avoid redundant drawing
    if (CGSizeEqualToSize(self.size, size)) {
        return self;
    }
    
    // begin drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    // draw
    [self drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    
    // capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // end drawing context
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)scf_imageScaledToFitSize:(CGSize)size {
    if (CGSizeEqualToSize(self.size, size)) {
        return self;
    }
    // calculate rect
    CGFloat aspect = self.size.width / self.size.height;
    if (size.width / aspect <= size.height) {
        return [self scf_imageScaledToSize:CGSizeMake(size.width, size.width / aspect)];
    }
    else {
        return [self scf_imageScaledToSize:CGSizeMake(size.height * aspect, size.height)];
    }
}

- (UIImage *)scf_imageScaledToFillSize:(CGSize)size {
    if (CGSizeEqualToSize(self.size, size)) {
        return self;
    }
    // calculate rect
    CGFloat aspect = self.size.width / self.size.height;
    if (size.width / aspect >= size.height) {
        return [self scf_imageScaledToSize:CGSizeMake(size.width, size.width / aspect)];
    }
    else {
        return [self scf_imageScaledToSize:CGSizeMake(size.height * aspect, size.height)];
    }
}

- (UIImage *)scf_imageCroppedAndScaledToSize:(CGSize)size
                                 contentMode:(UIViewContentMode)contentMode
                                    padToFit:(BOOL)padToFit {
    // calculate rect
    CGRect rect = CGRectZero;
    switch (contentMode) {
        case UIViewContentModeScaleAspectFit: {
            CGFloat aspect = self.size.width / self.size.height;
            if (size.width / aspect <= size.height) {
                rect = CGRectMake(0.0f, (size.height - size.width / aspect) / 2.0f, size.width, size.width / aspect);
            }
            else {
                rect = CGRectMake((size.width - size.height * aspect) / 2.0f, 0.0f, size.height * aspect, size.height);
            }
            break;
        }
            
        case UIViewContentModeScaleAspectFill: {
            CGFloat aspect = self.size.width / self.size.height;
            if (size.width / aspect >= size.height) {
                rect = CGRectMake(0.0f, (size.height - size.width / aspect) / 2.0f, size.width, size.width / aspect);
            }
            else {
                rect = CGRectMake((size.width - size.height * aspect) / 2.0f, 0.0f, size.height * aspect, size.height);
            }
            break;
        }
            
        case UIViewContentModeCenter: {
            rect = CGRectMake((size.width - self.size.width) / 2.0f, (size.height - self.size.height) / 2.0f, self.size.width, self.size.height);
            break;
        }
            
        case UIViewContentModeTop: {
            rect = CGRectMake((size.width - self.size.width) / 2.0f, 0.0f, self.size.width, self.size.height);
            break;
        }
            
        case UIViewContentModeBottom: {
            rect = CGRectMake((size.width - self.size.width) / 2.0f, size.height - self.size.height, self.size.width, self.size.height);
            break;
        }
            
        case UIViewContentModeLeft: {
            rect = CGRectMake(0.0f, (size.height - self.size.height) / 2.0f, self.size.width, self.size.height);
            break;
        }
            
        case UIViewContentModeRight: {
            rect = CGRectMake(size.width - self.size.height, (size.height - self.size.height) / 2.0f, self.size.width, self.size.height);
            break;
        }
            
        case UIViewContentModeTopLeft: {
            rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
            break;
        }
            
        case UIViewContentModeTopRight: {
            rect = CGRectMake(size.width - self.size.width, 0.0f, self.size.width, self.size.height);
            break;
        }
            
        case UIViewContentModeBottomLeft: {
            rect = CGRectMake(0.0f, size.height - self.size.height, self.size.width, self.size.height);
            break;
        }
            
        case UIViewContentModeBottomRight: {
            rect = CGRectMake(size.width - self.size.width, size.height - self.size.height, self.size.width, self.size.height);
            break;
        }
            
        default: {
            rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
            break;
        }
    }
    
    if (!padToFit) {
        // remove padding
        if (rect.size.width < size.width) {
            size.width = rect.size.width;
            rect.origin.x = 0.0f;
        }
        if (rect.size.height < size.height) {
            size.height = rect.size.height;
            rect.origin.y = 0.0f;
        }
    }
    
    // avoid redundant drawing
    if (CGSizeEqualToSize(self.size, size)) {
        return self;
    }
    
    // begin drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    // draw
    [self drawInRect:rect];
    
    // capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // end drawing context
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)scf_imageReflectedWithScale:(CGFloat)scale {
    // get reflection dimensions
    CGFloat height = ceil(self.size.height * scale);
    CGSize size = CGSizeMake(self.size.width, height);
    CGRect bounds = CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    // begin drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // clip to gradient
    CGContextClipToMask(context, bounds, [UIImage scf_imageRefGradientMask]);
    
    // draw reflected image
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextTranslateCTM(context, 0.0f, -self.size.height);
    [self drawInRect:CGRectMake(0.0f, 0.0f, self.size.width, self.size.height)];
    
    // capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // end drawing context
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)scf_imageReflectedWithScale:(CGFloat)scale gap:(CGFloat)gap alpha:(CGFloat)alpha {
    // get reflected image
    UIImage *reflection = [self scf_imageReflectedWithScale:scale];
    CGFloat reflectionOffsset = reflection.size.height + gap;
    
    // begin drawing context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width, self.size.height + reflectionOffsset * 2.0f), NO, 0.0f);
    
    // draw reflection
    [reflection drawAtPoint:CGPointMake(0.0f, reflectionOffsset + self.size.height + gap) blendMode:kCGBlendModeNormal alpha:alpha];
    
    // draw image
    [self drawAtPoint:CGPointMake(0.0f, reflectionOffsset)];
    
    // capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // end drawing context
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)scf_imageWithShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur {
    // get size
    CGSize border = CGSizeMake(fabs(offset.width) + blur, fabs(offset.height) + blur);
    
    CGSize size = CGSizeMake(self.size.width + border.width * 2.0f, self.size.height + border.height * 2.0f);
    
    // begin drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set up shadow
    CGContextSetShadowWithColor(context, offset, blur, color.CGColor);
    
    // draw with shadow
    [self drawAtPoint:CGPointMake(border.width, border.height)];
    
    // capture reslutant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // end drawing context
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)scf_imageWithCornerRadius:(CGFloat)radius {
    // begin drawing context
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // clip image
    CGContextBeginPath(context);
    // 线条开始位置 (0.0f, radis) ，最左侧
    CGContextMoveToPoint(context, 0.0f, radius);
    // 线条结束位置 (0.0f, self.size.height - radius)
    CGContextAddLineToPoint(context, 0.0f, self.size.height - radius);
    // 上下文 圆心位置(radius, self.size.height - radius) 半径radius 起始角度M_PI，结束角度M_PI / 2.0f度 （1是顺时针0是逆时针）
    CGContextAddArc(context, radius, self.size.height - radius, radius, M_PI, M_PI / 2.0f, 1);
    CGContextAddLineToPoint(context, self.size.width - radius, self.size.height);
    CGContextAddArc(context, self.size.width - radius, self.size.height - radius, radius, M_PI / 2.0f, 0.0f, 1);
    CGContextAddLineToPoint(context, self.size.width, radius);
    CGContextAddArc(context, self.size.width - radius, radius, radius, 0.0f, -M_PI / 2.0f, 1);
    CGContextAddLineToPoint(context, radius, 0.0f);
    CGContextAddArc(context, radius, radius, radius, -M_PI / 2.0f, M_PI, 1);
    CGContextClip(context);
    
    // draw image
    [self drawAtPoint:CGPointZero];
    
    // capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // end drawing context
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)scf_imageWithAlpha:(CGFloat)alpha {
    // begin drawing context
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    // draw with alpha
    [self drawAtPoint:CGPointZero blendMode:kCGBlendModeNormal alpha:alpha];
    
    // capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // end drawing context
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)scf_imageWithMaskFromImage:(UIImage *)fromImage {
    // begin drawing context
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // apply mask
    CGContextClipToMask(context, CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), fromImage.CGImage);
    
    // draw image
    [self drawAtPoint:CGPointZero];
    
    // capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // end drawing context
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)scf_imageWithMaskFromImageAlpha {
    // get dimensions
    size_t width = CGImageGetWidth(self.CGImage);
    size_t height = CGImageGetHeight(self.CGImage);
    
    // create alpha image
    size_t bytesPerRow = ((width + 3) / 4) * 4;
    void *data = calloc(bytesPerRow * height, sizeof(unsigned char *));
    CGContextRef context = CGBitmapContextCreate(data,
                                                 width,
                                                 height,
                                                 8,
                                                 bytesPerRow,
                                                 NULL,
                                                 kCGImageAlphaOnly);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, width, height), self.CGImage);
    
    // invert alpha pixels
    for (NSInteger y = 0; y < height; y++) {
        for (NSInteger x = 0; x < width; x++) {
            NSInteger index = y * bytesPerRow + x;
            ((unsigned char *)data)[index] = 255 - ((unsigned char *)data)[index];
        }
    }
    
    // create mask image
    CGImageRef maskRef = CGBitmapContextCreateImage(context);
    UIImage *image = [UIImage imageWithCGImage:maskRef];
    
    CGContextRelease(context);
    CGImageRelease(maskRef);
    
    return image;
}

#pragma mark - private methods
+ (CGImageRef)scf_imageRefGradientMask {
    static CGImageRef sharedMask = NULL;
    if (sharedMask == NULL) {
        // create gradient mask
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(1.0f, 256.0f), YES, 0.0f);
        CGContextRef gradientContext = UIGraphicsGetCurrentContext();
        CGFloat colors[] = {0.0f, 1.0f, 1.0f, 1.0f};
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
        CGPoint gradientStartPoint = CGPointMake(0.0f, 0.0f);
        CGPoint gradientEndPoint = CGPointMake(0.0f, 256.0f);
        CGContextDrawLinearGradient(gradientContext,
                                    gradient,
                                    gradientStartPoint,
                                    gradientEndPoint,
                                    kCGGradientDrawsAfterEndLocation);
        sharedMask = CGBitmapContextCreateImage(gradientContext);
        CGGradientRelease(gradient);
        CGColorSpaceRelease(colorSpace);
        UIGraphicsEndImageContext();
    }
    return sharedMask;
}

@end
