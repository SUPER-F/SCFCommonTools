//
//  UIBarButtonItem+SCFFactory.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/9.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SCFFactory)

/**
 根据图片生成UIBarButtonItem
 
 @param target target对象
 @param action 响应方法
 @param image image
 @param isLeftBar 是否是左侧Bar
 @return 生成的UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              image:(UIImage *)image
                          isLeftBar:(BOOL)isLeftBar;


/**
 根据图片生成UIBarButtonItem

 @param target target对象
 @param action 响应方法
 @param image image
 @param highlightedImg highlightedImg
 @param isLeftBar 是否是左侧Bar
 @return 生成的UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              image:(UIImage *)image
                   highlightedImage:(UIImage *)highlightedImg
                          isLeftBar:(BOOL)isLeftBar;


/**
 根据标题生成UIBarButtonItem

 @param target target对象
 @param action 响应方法
 @param title 标题
 @param isLeftBar 是否是左侧Bar
 @return 生成的UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              title:(NSString *)title
                          isLeftBar:(BOOL)isLeftBar;


/**
 根据标题生成UIBarButtonItem

 @param target target对象
 @param action 响应方法
 @param title 标题
 @param font 字体大小
 @param titleColor 标题颜色
 @param highlightedColor 标题高亮颜色
 @param isLeftBar 是否是左侧Bar
 @return 生成的UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              title:(NSString *)title
                               font:(UIFont *)font
                         titleColor:(UIColor *)titleColor
                   highlightedColor:(UIColor *)highlightedColor
                          isLeftBar:(BOOL)isLeftBar;


/**
 根据标题和图片生成UIBarButtonItem

 @param target target对象
 @param action 响应方法
 @param image 图片
 @param title 标题
 @param isImgAtLeft YES:图片在标题的左侧，NO:图片在标题右侧（只在同时有图片和文字的时候起作用）
 @param isLeftBar 是否是左侧Bar
 @return 生成的UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              image:(UIImage *)image
                              title:(NSString*)title
                      isImageAtLeft:(BOOL)isImgAtLeft
                          isLeftBar:(BOOL)isLeftBar;


/**
 根据文字和图片生成UIBarButtonItem

 @param target target对象
 @param action 响应方法
 @param title 标题
 @param font 字体大小
 @param titleColor 字体颜色
 @param highlightedColor 高亮颜色
 @param nomalImage 图片
 @param higelightedImage 高亮图片
 @param isImgAtLeft YES:图片在标题的左侧，NO:图片在标题右侧（只在同时有图片和文字的时候起作用）
 @param isLeftBar 是否是左侧Bar
 @return 生成的UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              title:(NSString *)title
                               font:(UIFont *)font
                         titleColor:(UIColor *)titleColor
                   highlightedColor:(UIColor *)highlightedColor
                         nomalImage:(UIImage *)nomalImage
                   higelightedImage:(UIImage *)higelightedImage
                      isImageAtLeft:(BOOL)isImgAtLeft
                          isLeftBar:(BOOL)isLeftBar;


/**
 用作修正位置的UIBarButtonItem
 
 @param width 修正宽度
 @return 修正位置的UIBarButtonItem
 */
+ (UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width;

@end
