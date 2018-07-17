//
//  UIImage+SCFCapture.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/21.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIImage (SCFCapture)


/**
 截取指定view成图片

 @param view 被截取的view
 @return 转化后的image
 */
+ (UIImage *)imageCaptureWithView:(UIView *)view;


/**
 把原image转化为指定size的image

 @param rect 指定大小
 @param fromImage 原image
 @return 转化后的image
 */
+ (UIImage *)imageWithSize:(CGRect)rect fromImage:(UIImage *)fromImage;


/**
 截屏，转化为指定宽度等比例缩放的image

 @param aView 被截屏的view
 @param limitWidth 指定宽度
 @return 转化后的image
 */
+ (UIImage *)imageScreenshotWithView:(UIView *)aView limitWidth:(CGFloat)limitWidth;

@end
