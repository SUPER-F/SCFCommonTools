//
//  UIScreen+SCFFrame.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/27.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIScreen+SCFFrame.h"

@implementation UIScreen (SCFFrame)

#pragma mark - public methods
+ (CGSize)scf_size {
    return [[UIScreen mainScreen] bounds].size;
}

+ (CGFloat)scf_width {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)scf_height {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGSize)scf_sizeOrientation {
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    BOOL isLand = UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
    
    return (systemVersion > 8.0 && isLand) ? scf_exchangeWidthToHeight([UIScreen scf_size]) : [UIScreen scf_size];
}

+ (CGFloat)scf_widthOrientation {
    return [UIScreen scf_sizeOrientation].width;
}

+ (CGFloat)scf_heightOrientation {
    return [UIScreen scf_sizeOrientation].height;
}

+ (CGSize)scf_sizeDPI {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    CGFloat scale = [[UIScreen mainScreen] scale];
    return CGSizeMake(size.width * scale, size.height * scale);
}

#pragma mark - private methods
// 交换高度与宽度
static inline CGSize scf_exchangeWidthToHeight(CGSize size) {
    return CGSizeMake(size.height, size.width);
}

@end
