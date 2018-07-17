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
+ (CGSize)size {
    return [[UIScreen mainScreen] bounds].size;
}

+ (CGFloat)width {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)height {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGSize)sizeOrientation {
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    BOOL isLand = UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
    
    return (systemVersion > 8.0 && isLand) ? exchangeWidthToHeight([UIScreen size]) : [UIScreen size];
}

+ (CGFloat)widthOrientation {
    return [UIScreen sizeOrientation].width;
}

+ (CGFloat)heightOrientation {
    return [UIScreen sizeOrientation].height;
}

+ (CGSize)sizeDPI {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    CGFloat scale = [[UIScreen mainScreen] scale];
    return CGSizeMake(size.width * scale, size.height * scale);
}

#pragma mark - private methods
// 交换高度与宽度
static inline CGSize exchangeWidthToHeight(CGSize size) {
    return CGSizeMake(size.height, size.width);
}

@end
