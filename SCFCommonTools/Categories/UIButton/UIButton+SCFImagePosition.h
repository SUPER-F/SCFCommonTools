//
//  UIButton+SCFImagePosition.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/20.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SCFImagePositions) {
    SCFImagePositionLeft = 0,   //图片在左，文字在右，默认
    SCFImagePositionRight,      //图片在右，文字在左
    SCFImagePositionTop,        //图片在上，文字在下
    SCFImagePositionBottom,     //图片在下，文字在上
};

@interface UIButton (SCFImagePosition)


/**
 按钮图片和文字排列位置
 利用UIButton的titleEdgeInsets和imageEdgeInsets来实现
 注意：这个方法需要在同时设置图片和文字后才可以使用，并且button的大小要大于 图片大小 + 文字大小 + spacing

 @param position 图片文字排列位置
 @param spacing 图片和文字的间隔
 */
- (void)scf_setImagePosition:(SCFImagePositions)position spacing:(CGFloat)spacing;

@end
