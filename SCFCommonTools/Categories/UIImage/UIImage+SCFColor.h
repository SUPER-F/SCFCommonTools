//
//  UIImage+SCFColor.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/22.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIImage (SCFColor)


/**
 根据颜色生成纯色图片

 @param color 颜色
 @return 纯色图片
 */
+ (UIImage *)imageFromColor:(UIColor *)color;


/**
 转化为灰度图

 @param fromImage 原图片
 @return 转化后的灰度图
 */
+ (UIImage *)imageCovertToGrayFromImage:(UIImage *)fromImage;


/**
 获取图片某一点的颜色

 @param point 某一点
 @return 获取的颜色
 */
- (UIColor *)imageColorAtPoint:(CGPoint)point;


/**
 获取图片某一像素的颜色

 @param pixel 某一像素
 @return 获取的颜色
 */
- (UIColor *)imageColorAtPixel:(CGPoint)pixel;

@end
