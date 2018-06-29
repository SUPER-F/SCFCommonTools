//
//  UIImage+SCFOrientation.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/25.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIImage+SCFOrientation.h"

@implementation UIImage (SCFOrientation)

+ (UIImage *)scf_imageFixOrientation:(UIImage *)srcImage {
    if (srcImage.imageOrientation == UIImageOrientationUp) {
        return srcImage;
    }
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (srcImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored: {
            transform = CGAffineTransformTranslate(transform, srcImage.size.width, srcImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        }
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored: {
            transform = CGAffineTransformTranslate(transform, srcImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        }
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored: {
            transform = CGAffineTransformTranslate(transform, 0, srcImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        }
            
        default:
            break;
    }
    
    switch (srcImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored: {
            transform = CGAffineTransformTranslate(transform, srcImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        }
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored: {
            transform = CGAffineTransformTranslate(transform, srcImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        }
            
        default:
            break;
    }
    
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 srcImage.size.width,
                                                 srcImage.size.height,
                                                 CGImageGetBitsPerComponent(srcImage.CGImage),
                                                 0,
                                                 CGImageGetColorSpace(srcImage.CGImage),
                                                 CGImageGetBitmapInfo(srcImage.CGImage));
    CGContextConcatCTM(context, transform);
    
    switch (srcImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored: {
            CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, srcImage.size.height, srcImage.size.width), srcImage.CGImage);
            break;
        }
            
        default:
            CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, srcImage.size.width, srcImage.size.height), srcImage.CGImage);
            break;
    }
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(context);
    CGImageRelease(imageRef);
    
    return image;
}

- (UIImage *)scf_flipIsHorizontal:(BOOL)isHorizontal {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextClipToRect(context, rect);
    if (isHorizontal) {
        CGContextRotateCTM(context, M_PI);
        CGContextTranslateCTM(context, -rect.size.width, -rect.size.height);
    }
    CGContextDrawImage(context, rect, self.CGImage);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)scf_imageFlipVertical {
    return [self scf_flipIsHorizontal:NO];
}

- (UIImage *)scf_imageFlipHorizontal {
    return [self scf_flipIsHorizontal:YES];
}

- (UIImage *)scf_imageRotatedByDegrees:(CGFloat)degrees {
    // 计算旋转视图中包含绘图空间的框的大小
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.size.width, self.size.height)];
    CGAffineTransform transform = CGAffineTransformMakeRotation([UIImage scf_radiansFromDegrees:degrees]);
    rotatedViewBox.transform = transform;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // 创建位图的上下文
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 把原点移到图像的中间，这样我们就可以围绕中心旋转和缩放
    CGContextTranslateCTM(context, rotatedSize.width / 2.0, rotatedSize.height / 2.0);
    
    // 旋转图像背景
    CGContextRotateCTM(context, [UIImage scf_radiansFromDegrees:degrees]);
    
    // 将旋转/缩放的图像绘制到上下文中
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(-self.size.width / 2.0, -self.size.height / 2.0, self.size.width, self.size.height), self.CGImage);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)scf_imageRotatedByRadians:(CGFloat)radians {
    return [self scf_imageRotatedByDegrees:[UIImage scf_degreesFromRadians:radians]];
}

+ (CGFloat)scf_radiansFromDegrees:(CGFloat)degrees {
    return degrees * M_PI / 180.0f;
}

+ (CGFloat)scf_degreesFromRadians:(CGFloat)radians {
    return radians * 180.0f / M_PI;
}

@end
