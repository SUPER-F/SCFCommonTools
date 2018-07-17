//
//  UIImage+SCFRoundedCorner.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/25.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIImage (SCFRoundedCorner)


/**
 创建一个带有圆角的图像副本
 如果边界大小为非零，也将添加给定大小的透明边界

 @param cornerSize 圆角尺寸
 @param borderSize 边框尺寸
 @return 结果图片
 */
- (UIImage *)imageRoundedCornerWithCornerSize:(CGFloat)cornerSize borderSize:(CGFloat)borderSize;

@end
