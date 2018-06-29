//
//  UIView+SCFFrame.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/29.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIView+SCFFrame.h"

@implementation UIView (SCFFrame)

- (CGPoint)scf_origin {
    return self.frame.origin;
}

- (void)setScf_origin:(CGPoint)scf_origin {
    CGRect frame = self.frame;
    frame.origin = scf_origin;
    self.frame = frame;
}

- (CGSize)scf_size {
    return self.frame.size;
}

- (void)setScf_size:(CGSize)scf_size {
    CGRect frame = self.frame;
    frame.size = scf_size;
    self.frame = frame;
}

- (CGFloat)scf_centerX {
    return self.center.x;
}

- (void)setScf_centerX:(CGFloat)scf_centerX {
    self.center = CGPointMake(scf_centerX, self.center.y);
}

- (CGFloat)scf_centerY {
    return self.center.y;
}

- (void)setScf_centerY:(CGFloat)scf_centerY {
    self.center = CGPointMake(self.center.x, scf_centerY);
}

- (CGFloat)scf_top {
    return self.frame.origin.y;
}

- (void)setScf_top:(CGFloat)scf_top {
    CGRect frame = self.frame;
    frame.origin.y = scf_top;
    self.frame = frame;
}

- (CGFloat)scf_left {
    return self.frame.origin.x;
}

- (void)setScf_left:(CGFloat)scf_left {
    CGRect frame = self.frame;
    frame.origin.x = scf_left;
    self.frame = frame;
}

- (CGFloat)scf_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setScf_bottom:(CGFloat)scf_bottom {
    CGRect frame = self.frame;
    frame.origin.y = scf_bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)scf_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setScf_right:(CGFloat)scf_right {
    CGRect frame = self.frame;
    frame.origin.x = scf_right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)scf_width {
    return self.frame.size.width;
}

- (void)setScf_width:(CGFloat)scf_width {
    CGRect frame = self.frame;
    frame.size.width = scf_width;
    self.frame = frame;
}

- (CGFloat)scf_height {
    return self.frame.size.height;
}

- (void)setScf_height:(CGFloat)scf_height {
    CGRect frame = self.frame;
    frame.size.height = scf_height;
    self.frame = frame;
}

@end
