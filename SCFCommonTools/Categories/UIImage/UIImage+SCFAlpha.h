//
//  UIImage+SCFAlpha.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/21.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIImage (SCFAlpha)

// 是否有 alpha 通道
- (BOOL)imageHasAlpha;

// 如没有 alpha 通道，增加 alpha 通道
- (UIImage *)imageAddAlpha;


/**
 为image增加透明边框

 @param borderWidth 边框宽度
 @return 增加透明边框后的image
 */
- (UIImage *)imageAddTransparentBorderWithWidth:(NSUInteger)borderWidth;


/**
 裁切含透明图片为最小尺寸

 @return 裁切后的image
 */
- (UIImage *)imageCutTransparentBorderToBetterSize;

@end
