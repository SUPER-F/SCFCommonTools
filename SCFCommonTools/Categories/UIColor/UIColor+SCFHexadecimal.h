//
//  UIColor+SCFHexadecimal.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/20.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIColor (SCFHexadecimal)

// 十六进制颜色值转UIColor
+ (UIColor *)scf_colorWithHex:(UInt32)hex;
+ (UIColor *)scf_colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;

// 十六进制颜色值字符串转UIColor
+ (UIColor *)scf_colorWithHexString:(NSString *)hexString;

// UIColor转十六进制字符串
- (NSString *)scf_hexString;

@end
