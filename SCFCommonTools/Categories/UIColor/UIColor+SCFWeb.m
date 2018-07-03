//
//  UIColor+SCFWeb.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/3.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIColor+SCFWeb.h"

@implementation UIColor (SCFWeb)

- (NSString *)scf_canvasColorString {
    CGFloat *arrRGBA = [self scf_getRGBA];
    CGFloat r = arrRGBA[0] * 255;
    CGFloat g = arrRGBA[1] * 255;
    CGFloat b = arrRGBA[2] * 255;
    CGFloat a = arrRGBA[3];
    return [NSString stringWithFormat:@"rgba(%f,%f,%f,%f)", r, g, b, a];
}

- (NSString *)scf_webColorString {
    CGFloat *arrRGBA = [self scf_getRGBA];
    int r = arrRGBA[0] * 255;
    int g = arrRGBA[1] * 255;
    int b = arrRGBA[2] * 255;
    return [NSString stringWithFormat:@"#%02X%02X%02X", r, g, b];
}

#pragma mark - private methods
- (CGFloat *)scf_getRGBA {
    UIColor *color = self;
    CGColorRef colorRef = color.CGColor;
    size_t numComponents = CGColorGetNumberOfComponents(colorRef);
    if (numComponents == 4) {
        static CGFloat *components = Nil;
        components = (CGFloat *)CGColorGetComponents(colorRef);
        return (CGFloat *)components;
    }
    else {  //否则，默认返回黑色
        static CGFloat componts[4] = {0};
        CGFloat f = 0;
        // 非RGB空间的系统颜色单独处理
        if ([color isEqual:[UIColor whiteColor]]) {
            f = 1.0f;
        }
        else if ([color isEqual:[UIColor lightGrayColor]]) {
            f = 0.8f;
        }
        else if ([color isEqual:[UIColor grayColor]]) {
            f = 0.5f;
        }
        componts[0] = f;
        componts[1] = f;
        componts[2] = f;
        componts[3] = 1.0f;
        return (CGFloat *)componts;
    }
}

@end
