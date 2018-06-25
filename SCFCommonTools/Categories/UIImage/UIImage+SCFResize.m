//
//  UIImage+SCFResize.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/25.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIImage+SCFResize.h"
#import "UIImage+SCFRoundedCorner.h"
#import "UIImage+SCFAlpha.h"

@implementation UIImage (SCFResize)

- (UIImage *)scf_imageCroppedToRect:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return croppedImage;
}

- (UIImage *)scf_imageThumbnailWithResize:(CGSize)thumbnailSize
                        transparentBorder:(CGFloat)borderSize
                             cornerRadius:(CGFloat)cornerRadius
                     interpolationQuality:(CGInterpolationQuality)quality {
    
    UIImage *resizedImage = [self scf_imageResize:thumbnailSize contentMode:UIViewContentModeScaleAspectFill interpolationQuality:quality];
    
    // 切割所有超出缩略图大小的位置
    // 被切割的rect必须在图片上
    // 围绕原点，以便以后调用CGRectIntegral时不会改变大小
    CGRect cropRect = CGRectMake(round((resizedImage.size.width - thumbnailSize.width) / 2.0),
                                 round((resizedImage.size.height - thumbnailSize.height) / 2.0),
                                 thumbnailSize.width,
                                 thumbnailSize.height);
    UIImage *croppedImage = [resizedImage scf_imageCroppedToRect:cropRect];
    
    UIImage *transparentBorderImage = borderSize ? [croppedImage scf_imageAddTransparentBorderWithWidth:borderSize] : croppedImage;
    
    return [transparentBorderImage scf_imageRoundedCornerWithCornerSize:cornerRadius borderSize:borderSize];
}

- (UIImage *)scf_imageResize:(CGSize)newSize
        interpolationQuality:(CGInterpolationQuality)quality {
    BOOL drawTransposed;
    
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            drawTransposed = YES;
            break;
            
        default:
            drawTransposed = NO;
            break;
    }
    
    return [self scf_imageResized:newSize
                        transform:[self scf_transformForOrientationWithSize:newSize]
                   drawTransposed:drawTransposed
             interpolationQuality:quality];
}

- (UIImage *)scf_imageResize:(CGSize)newSize
                 contentMode:(UIViewContentMode)contentMode
        interpolationQuality:(CGInterpolationQuality)quality {
    
    CGFloat horizontalRatio = newSize.width / self.size.width;
    CGFloat verticalRatio = newSize.height / self.size.height;
    CGFloat ratio;
    
    switch (contentMode) {
        case UIViewContentModeScaleAspectFill:
            ratio = MAX(horizontalRatio, verticalRatio);
            break;
            
        case UIViewContentModeScaleAspectFit:
            ratio = MIN(horizontalRatio, verticalRatio);
            break;
            
        default:
            [NSException raise:NSInvalidArgumentException format:@"Unsupported content mode: %@", @(contentMode)];
            break;
    }
    
    CGSize size = CGSizeMake(round(self.size.width * ratio), round(self.size.height * ratio));
    
    return [self scf_imageResize:size interpolationQuality:quality];
}

#pragma mark - private methods
//新图像的方向将是UIImageOrientationUp，与当前图像的方向无关
- (UIImage *)scf_imageResized:(CGSize)newSize
                    transform:(CGAffineTransform)transform
               drawTransposed:(BOOL)transpose
         interpolationQuality:(CGInterpolationQuality)quality {
    
    CGRect newRect = CGRectIntegral(CGRectMake(0.0f, 0.0f, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0.0f, 0.0f, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    
    uint32_t bitmapInfo = CGImageGetBitmapInfo(imageRef);
    if (bitmapInfo == kCGImageAlphaLast || bitmapInfo == kCGImageAlphaNone) {
        bitmapInfo = kCGImageAlphaNoneSkipLast;
    }
    
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 newRect.size.width,
                                                 newRect.size.height,
                                                 CGImageGetBitsPerComponent(imageRef),
                                                 0,
                                                 CGImageGetColorSpace(imageRef),
                                                 bitmapInfo);
    
    // 根据图像的方向旋转或翻转图像
    CGContextConcatCTM(context, transform);
    
    // 设置重新扫描时的质量级别
    CGContextSetInterpolationQuality(context, quality);
    
    CGContextDrawImage(context, transpose ? transposedRect : newRect, imageRef);
    
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGContextRelease(context);
    CGImageRelease(newImageRef);
    
    return newImage;
}

- (CGAffineTransform)scf_transformForOrientationWithSize:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored: {
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        }
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored: {
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        }
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored: {
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        }
            
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored: {
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        }
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored: {
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        }
            
        default:
            break;
    }
    
    return transform;
}

@end
