//
//  UIImage+SCFResize.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/25.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIImage (SCFResize)


/**
 裁切图片
 只是使用CGRectIntegral去适配大小
 该方法忽略图片的 imageOrientation 设置

 @param rect 裁切位置
 @return 根据给定位置切割的图片
 */
- (UIImage *)imageCroppedToRect:(CGRect)rect;


/**
 生成缩略图
 如果透明边框是非零的，则在缩略图的边缘添加一个给定大小的透明边框。
 (增加至少一个像素大小的透明边框，在使用Core Animation旋转图像时，会产生反锯齿效果。)

 @param thumbnailSize 缩略图大小
 @param borderSize 边框大小
 @param cornerRadius 圆角大小
 @param quality 图片质量
 @return 生成的缩略图
 */
- (UIImage *)imageThumbnailWithResize:(CGSize)thumbnailSize
                        transparentBorder:(CGFloat)borderSize
                             cornerRadius:(CGFloat)cornerRadius
                     interpolationQuality:(CGInterpolationQuality)quality;


/**
 改变图片大小
 为了适应给定的大小，图片将不成比例的缩放

 @param newSize 给定大小
 @param quality 图片质量
 @return 改变大小后的图片
 */
- (UIImage *)imageResize:(CGSize)newSize
        interpolationQuality:(CGInterpolationQuality)quality;



/**
 根据给定的内容模式调整图像的大小，并考虑图像的方向

 @param newSize 给定大小
 @param contentMode 内容模式(暂支持 UIViewContentModeScaleAspectFill 和 UIViewContentModeScaleAspectFit)
 @param quality 图片质量
 @return 改变大小后的图片
 */
- (UIImage *)imageResize:(CGSize)newSize
                 contentMode:(UIViewContentMode)contentMode
        interpolationQuality:(CGInterpolationQuality)quality;

@end
