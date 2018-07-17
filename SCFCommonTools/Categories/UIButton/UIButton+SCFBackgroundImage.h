//
//  UIButton+SCFBackgroundImage.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/20.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIButton (SCFBackgroundImage)


/**
 根据按钮状态，使用颜色设置按钮背景图片

 @param bgColor 背景颜色
 @param state 按钮状态
 */
- (void)setBackgroundImageWithColor:(UIColor *)bgColor forState:(UIControlState)state;

@end
