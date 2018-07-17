//
//  UIView+SCFVisuals.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/29.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIView (SCFVisuals)


/**
 设置圆角，设置任意角的圆角

 @param corners 想设置为圆角的角
 @param radius 圆角半径
 */
- (void)viewRoundedCorners:(UIRectCorner)corners
                        radius:(CGFloat)radius;


/**
 设置阴影

 @param color 阴影颜色
 @param offset 阴影大小
 @param opacity 透明度
 @param radius 圆角半径
 */
- (void)viewShadowWithColor:(UIColor *)color
                         offset:(CGSize)offset
                        opacity:(CGFloat)opacity
                         radius:(CGFloat)radius;


/**
 使用褪色效果从父view移除

 @param duration 动画时间
 */
- (void)removeFromSuperviewWithFadeDuration:(NSTimeInterval)duration;


/**
 使用动画效果添加子view

 @param subview 子view
 @param transition 添加动画
 @param duration 动画时间
 */
- (void)addSubview:(UIView *)subview
        withTransition:(UIViewAnimationTransition)transition
              duration:(NSTimeInterval)duration;


/**
 使用动画效果从父view移除

 @param transition 移除动画
 @param duration 动画时间
 */
- (void)removeFromSuperviewWithTransition:(UIViewAnimationTransition)transition
                                     duration:(NSTimeInterval)duration;


/**
 旋转view

 @param angle 旋转角度
 @param duration 旋转时间
 @param autoReverse 是否自动反向
 @param repeatCount 重复次数
 @param timingFunction 定时功能
 */
- (void)viewRotateByAngle:(CGFloat)angle
                     duration:(NSTimeInterval)duration
                  autoReverse:(BOOL)autoReverse
                  repeatCount:(CGFloat)repeatCount
                timingFuction:(CAMediaTimingFunction *)timingFunction;


/**
 移动view

 @param newPoint 新位置
 @param duration 移动时间
 @param autoReverse 是否自动反向
 @param repeatCount 重复次数
 @param timingFunction 定时功能
 */
- (void)viewMoveToPoint:(CGPoint)newPoint
                   duration:(NSTimeInterval)duration
                autoReverse:(BOOL)autoReverse
                repeatCount:(CGFloat)repeatCount
             timingFunction:(CAMediaTimingFunction *)timingFunction;

@end
