//
//  UIColor+SCFRandom.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/21.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIColor+SCFRandom.h"

@implementation UIColor (SCFRandom)

+ (UIColor *)scf_colorRandom {
    NSInteger redRandom = arc4random() % 255;
    NSInteger greenRandom = arc4random() % 255;
    NSInteger blueRandom = arc4random() % 255;
    UIColor *colorRandom = [UIColor colorWithRed:redRandom / 255.0f
                                           green:greenRandom / 255.0f
                                            blue:blueRandom / 255.0f
                                           alpha:1.0f];
    return colorRandom;
}

@end
