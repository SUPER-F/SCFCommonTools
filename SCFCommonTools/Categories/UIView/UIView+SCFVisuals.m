//
//  UIView+SCFVisuals.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/29.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIView+SCFVisuals.h"

// 角度转弧度
#define scf_radiansFromDegrees(degrees) (M_PI * degrees / 180.0f)

@implementation UIView (SCFVisuals)

- (void)scf_viewRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    CGRect rect = self.bounds;
    
    // 创建贝塞尔路径
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    // 创建图层
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    // 设置新图层
    self.layer.mask = maskLayer;
}

- (void)scf_viewShadowWithColor:(UIColor *)color
                         offset:(CGSize)offset
                        opacity:(CGFloat)opacity
                         radius:(CGFloat)radius {
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
}

- (void)scf_removeFromSuperviewWithFadeDuration:(NSTimeInterval)duration {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
    self.alpha = 0.0f;
    [UIView commitAnimations];
}

- (void)scf_addSubview:(UIView *)subview
        withTransition:(UIViewAnimationTransition)transition
              duration:(NSTimeInterval)duration {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:transition forView:subview cache:YES];
    [self addSubview:subview];
    [UIView commitAnimations];
}

- (void)scf_removeFromSuperviewWithTransition:(UIViewAnimationTransition)transition
                                     duration:(NSTimeInterval)duration {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:transition forView:self cache:YES];
    [self removeFromSuperview];
    [UIView commitAnimations];
}

- (void)scf_viewRotateByAngle:(CGFloat)angle
                     duration:(NSTimeInterval)duration
                  autoReverse:(BOOL)autoReverse
                  repeatCount:(CGFloat)repeatCount
                timingFuction:(CAMediaTimingFunction *)timingFunction {
    
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.toValue = [NSNumber numberWithFloat:scf_radiansFromDegrees(angle)];
    rotation.duration = duration;
    rotation.repeatCount = repeatCount;
    rotation.autoreverses = autoReverse;
    rotation.removedOnCompletion = NO;
    rotation.fillMode = kCAFillModeBoth;
    rotation.timingFunction = timingFunction ? timingFunction : [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.layer addAnimation:rotation forKey:@"rotationAnimation"];
}

- (void)scf_viewMoveToPoint:(CGPoint)newPoint
                   duration:(NSTimeInterval)duration
                autoReverse:(BOOL)autoReverse
                repeatCount:(CGFloat)repeatCount
             timingFunction:(CAMediaTimingFunction *)timingFunction {
    
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
    move.toValue = [NSValue valueWithCGPoint:newPoint];
    move.duration = duration;
    move.removedOnCompletion = NO;
    move.repeatCount = repeatCount;
    move.autoreverses = autoReverse;
    move.fillMode = kCAFillModeBoth;
    move.timingFunction = timingFunction ? timingFunction : [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.layer addAnimation:move forKey:@"positionAnimation"];
}

@end
