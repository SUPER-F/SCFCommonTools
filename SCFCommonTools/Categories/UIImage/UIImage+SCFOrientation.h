//
//  UIImage+SCFOrientation.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/25.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIImage (SCFOrientation)


/**
 修正图片的方向

 @param srcImage 图片
 @return 修正方向后的图片
 */
+ (UIImage *)scf_imageFixOrientation:(UIImage *)srcImage;


/**
 旋转图片

 @param degrees 角度
 @return 旋转后的图片
 */
- (UIImage *)scf_imageRotatedByDegrees:(CGFloat)degrees;


/**
 旋转图片

 @param radians 弧度
 @return 旋转后的图片
 */
- (UIImage *)scf_imageRotatedByRadians:(CGFloat)radians;


/**
 垂直翻转

 @return 翻转后的图片
 */
- (UIImage *)scf_imageFlipVertical;


/**
 水平翻转

 @return 翻转后的图片
 */
- (UIImage *)scf_imageFlipHorizontal;


/**
 角度转弧度

 @param degrees 角度
 @return 弧度
 */
+ (CGFloat)scf_radiansFromDegrees:(CGFloat)degrees;


/**
 弧度转角度

 @param radians 弧度
 @return 角度
 */
+ (CGFloat)scf_degreesFromRadians:(CGFloat)radians;

@end
