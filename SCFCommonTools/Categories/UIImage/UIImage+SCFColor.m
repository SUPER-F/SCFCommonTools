//
//  UIImage+SCFColor.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/22.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIImage+SCFColor.h"

@implementation UIImage (SCFColor)

+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageCovertToGrayFromImage:(UIImage *)fromImage {
    CGFloat width = fromImage.size.width;
    CGFloat height = fromImage.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 width,
                                                 height,
                                                 8,
                                                 0,
                                                 colorSpace,
                                                 kCGImageAlphaNone);
    if (!context) {
        return nil;
    }
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), fromImage.CGImage);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    UIImage *grayImage = [UIImage imageWithCGImage:imageRef];
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CGImageRelease(imageRef);
    
    return grayImage;
}

- (UIColor *)imageColorAtPoint:(CGPoint)point {
    // 如果该点不在图片内，就返回空
    if (!CGRectContainsPoint(CGRectMake(0, 0, self.size.width, self.size.height), point)) {
        return nil;
    }
    
    CGImageRef imageRef = self.CGImage;
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    unsigned char *rawData = malloc(width * height * 4);
    if (!rawData) {
        return nil;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    size_t bitsPerComponent = 8;
    size_t bytesPerPixel = 4;
    size_t bytesPerRow = bytesPerPixel * width;
    CGContextRef context = CGBitmapContextCreate(rawData,
                                                 width,
                                                 height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    if (!context) {
        free(rawData);
        return nil;
    }
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    size_t byteIndex = bytesPerRow * point.y + point.x * bytesPerPixel;
    CGFloat red   = (CGFloat)rawData[byteIndex] / 255.0f;
    CGFloat green = (CGFloat)rawData[byteIndex + 1] / 255.0f;
    CGFloat blue  = (CGFloat)rawData[byteIndex + 2] / 255.0f;
    CGFloat alpha = (CGFloat)rawData[byteIndex + 3] / 255.0f;
    
    UIColor *resultColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    free(rawData);
    
    return resultColor;
}

- (UIColor *)imageColorAtPixel:(CGPoint)pixel {
    // 如果该像素点不在图片内，就返回空
    if (!CGRectContainsPoint(CGRectMake(0, 0, self.size.width, self.size.height), pixel)) {
        return nil;
    }
    
    // 创建一个1x1像素的字节数组和位图上下文来绘制像素
    CGFloat pointX = trunc(pixel.x);
    CGFloat pointY = trunc(pixel.y);
    
    CGImageRef imageRef = self.CGImage;
    
    CGFloat witdh = self.size.width;
    CGFloat height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    size_t bitsPerComponent = 8;
    size_t bytesPerPixel = 4;
    size_t bytesPerRow = bytesPerPixel * 1;
    unsigned char pixelData[4] = {0, 0, 0, 0};
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    if (!context) {
        return nil;
    }
    
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    // 绘制像素到位图上下文
    CGContextTranslateCTM(context, -pointX, pointY - height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, witdh, height), imageRef);
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    
    UIColor *resultColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    return resultColor;
}

@end
