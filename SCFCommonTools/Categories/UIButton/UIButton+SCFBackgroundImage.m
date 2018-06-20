//
//  UIButton+SCFBackgroundImage.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/20.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIButton+SCFBackgroundImage.h"

@implementation UIButton (SCFBackgroundImage)

- (void)scf_setBackgroundImageWithColor:(UIColor *)bgColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton scf_backgroundImageWithColor:bgColor] forState:state];
}

+ (UIImage *)scf_backgroundImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
