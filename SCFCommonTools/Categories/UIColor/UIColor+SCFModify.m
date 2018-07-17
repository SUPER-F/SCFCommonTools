//
//  UIColor+SCFModify.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/21.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIColor+SCFModify.h"

@implementation UIColor (SCFModify)

- (UIColor *)colorInverted {
    NSArray *components = [self componentArray];
    return [UIColor colorWithRed:1 - [components[0] doubleValue]
                           green:1 - [components[1] doubleValue]
                            blue:1 - [components[2] doubleValue]
                           alpha:[components[3] doubleValue]];
}

- (UIColor *)colorTranslucency {
    //指定HSB，参数是：色调（hue），饱和的（saturation），亮度（brightness）
    CGFloat hue = 0, saturation = 0, brightness = 0, alpha = 0;
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    return [UIColor colorWithHue:hue
                      saturation:saturation * 1.158
                      brightness:brightness * 0.95
                           alpha:alpha];
}

- (UIColor *)colorLighten:(CGFloat)lighten {
    //指定HSB，参数是：色调（hue），饱和的（saturation），亮度（brightness）
    CGFloat hue = 0, saturation = 0, brightness = 0, alpha = 0;
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    return [UIColor colorWithHue:hue
                      saturation:saturation * (1 - lighten)
                      brightness:brightness * (1 + lighten)
                           alpha:alpha];
}

- (UIColor *)colorDarken:(CGFloat)darken {
    //指定HSB，参数是：色调（hue），饱和的（saturation），亮度（brightness）
    CGFloat hue = 0, saturation = 0, brightness = 0, alpha = 0;
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    return [UIColor colorWithHue:hue
                      saturation:saturation * (1 + darken)
                      brightness:brightness * (1 - darken)
                           alpha:alpha];
}

#pragma mark - private methods
- (NSArray *)componentArray {
    // 红色分量, 绿色分量, 蓝色分量, alpha分量
    CGFloat red, green, blue, alpha;
    const CGFloat *components = CGColorGetComponents([self CGColor]);
    if (CGColorGetNumberOfComponents([self CGColor]) < 4) {
        red = components[0];
        green = components[0];
        blue = components[0];
        alpha = components[1];
    }
    else {
        red = components[0];
        green = components[1];
        blue = components[2];
        alpha = components[3];
    }
    return @[@(red), @(green), @(blue), @(alpha)];
}

@end
