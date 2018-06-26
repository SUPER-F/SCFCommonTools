//
//  UIImageView+SCFAddition.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/25.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIImageView (SCFAddition)


/**
 根据bundle中的图片名创建imageview

 @param imageName bundle中的图片名
 @return 创建的imageview
 */
+ (UIImageView *)scf_imageViewWithImageNamed:(NSString *)imageName;


/**
 根据frame创建imageview

 @param frame imageview的frame
 @return 创建的imageview
 */
+ (UIImageView *)scf_imageViewWithFrame:(CGRect)frame;


/**
 根据可伸缩图片名和frame创建imageview

 @param imageName 图片名
 @param frame imageview的frame
 @return imageview
 */
+ (UIImageView *)scf_imageViewStretchableImageNamed:(NSString *)imageName frame:(CGRect)frame;


/**
 创建imageview动画

 @param imageArray 图片名称数组
 @param duration 动画时间
 @return imageview
 */
+ (UIImageView *)scf_imageViewWithImageArray:(NSArray *)imageArray duration:(NSTimeInterval)duration;


/**
 根据可伸缩图片名设置imageview的image

 @param imageName 图片名
 */
- (void)scf_setStretchableImageWithName:(NSString *)imageName;

#pragma mark - 画水印

/**
 图片水印

 @param image 设置的图片
 @param markImage 图片水印
 @param rect 水印位置
 */
- (void)scf_setImage:(UIImage *)image withWaterMarkImage:(UIImage *)markImage inRect:(CGRect)rect;


/**
 文字水印

 @param image 设置的图片
 @param markString 文字水印
 @param rect 水印位置
 @param color 文字颜色
 @param font 文字大小
 */
- (void)scf_setImage:(UIImage *)image withWaterMarkString:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;


/**
 文字水印

 @param image 设置的图片
 @param markString 文字水印
 @param point 水印的点
 @param color 文字颜色
 @param font 文字大小
 */
- (void)scf_setImage:(UIImage *)image withWaterMarkString:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font;

@end
