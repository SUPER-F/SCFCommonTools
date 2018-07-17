//
//  UIColor+SCFGradient.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/20.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIColor (SCFGradient)


/**
 渐变颜色

 @param fromColor 开始颜色
 @param toColor 结束颜色
 @param height 渐变高度
 @return 渐变颜色结果
 */
+ (UIColor *)gradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor withHeight:(CGFloat)height;

@end
