//
//  NSString+SCFSize.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/5.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SCFSize)


/**
 获取字符串的高度

 @param font 字体大小
 @param width 限制宽度
 @return 字符串高度
 */
- (CGFloat)scf_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;


/**
 获取字符串的宽度

 @param font 字体大小
 @param height 限制高度
 @return 字符串宽度
 */
- (CGFloat)scf_widthWithFont:(UIFont *)font constrainedToWidth:(CGFloat)height;


/**
 字符串的size

 @param font 字体大小
 @param width 限制宽度
 @return 字符串size
 */
- (CGSize)scf_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;


/**
 字符串的size

 @param font 字体大小
 @param height 限制高度
 @return 字符串size
 */
- (CGSize)scf_sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

@end
