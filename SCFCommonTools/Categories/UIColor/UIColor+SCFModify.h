//
//  UIColor+SCFModify.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/21.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIColor (SCFModify)

// 反向颜色
- (UIColor *)colorInverted;

// 半透明颜色
- (UIColor *)colorTranslucency;


/**
 颜色变亮

 @param lighten 变亮参数
 @return 变亮后的颜色
 */
- (UIColor *)colorLighten:(CGFloat)lighten;


/**
 颜色变暗

 @param darken 变暗参数
 @return 变暗后的颜色
 */
- (UIColor *)colorDarken:(CGFloat)darken;

@end
