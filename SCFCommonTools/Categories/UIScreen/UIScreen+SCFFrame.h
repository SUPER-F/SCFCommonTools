//
//  UIScreen+SCFFrame.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/27.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIScreen (SCFFrame)

// 固定正向方向时的size
+ (CGSize)scf_size;
+ (CGFloat)scf_width;
+ (CGFloat)scf_height;

// 根据屏幕方向变换时的size
+ (CGSize)scf_sizeOrientation;
+ (CGFloat)scf_widthOrientation;
+ (CGFloat)scf_heightOrientation;

// 像素size
+ (CGSize)scf_sizeDPI;

@end
