//
//  UIButton+SCFBadge.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/20.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIButton+SCFBadge.h"
#import <objc/runtime.h>

NSString const *scf_UIButton_badgeKey = @"scf_UIButton_badgeKey";

NSString const *scf_UIButton_badgeBGColorKey = @"scf_UIButton_badgeBGColorKey";
NSString const *scf_UIButton_badgeTextColorKey = @"scf_UIButton_badgeTextColorKey";
NSString const *scf_UIButton_badgeFontKey = @"scf_UIButton_badgeFontKey";
NSString const *scf_UIButton_badgePaddingKey = @"scf_UIButton_badgePaddingKey";
NSString const *scf_UIButton_badgeMinSizeKey = @"scf_UIButton_badgeMinSizeKey";
NSString const *scf_UIButton_badgeOriginXKey = @"scf_UIButton_badgeOriginXKey";
NSString const *scf_UIButton_badgeOriginYKey = @"scf_UIButton_badgeOriginYKey";
NSString const *scf_UIButton_shouldHideBadgeAtZeroKey = @"scf_UIButton_shouldHideBadgeAtZeroKey";
NSString const *scf_UIButton_shouldAnimateBadgeKey = @"scf_UIButton_shouldAnimateBadgeKey";
NSString const *scf_UIButton_badgeValueKey = @"scf_UIButton_badgeValueKey";

@implementation UIButton (SCFBadge)

@dynamic scf_badgeValue, scf_badgeBGColor, scf_badgeTextColor, scf_badgeFont;
@dynamic scf_badgePadding, scf_badgeMinSize, scf_badgeOriginX, scf_badgeOriginY;
@dynamic scf_shouldAnimateBadge, scf_shouldHideBadgeAtZero;
@dynamic scf_badge;

- (void)scf_badgeInit {
    // Default design initialization
    self.scf_badgeBGColor = [UIColor redColor];
    self.scf_badgeTextColor = [UIColor whiteColor];
    self.scf_badgeFont = [UIFont systemFontOfSize:12.0];
    self.scf_badgePadding = 6.0;
    self.scf_badgeMinSize = 8.0;
    self.scf_badgeOriginX = self.frame.size.width - self.scf_badge.frame.size.width / 2.0;
    self.scf_badgeOriginY = -4.0;
    self.scf_shouldHideBadgeAtZero = YES;
    self.scf_shouldAnimateBadge = YES;
    
    self.clipsToBounds = NO;
}

#pragma mark - Utility methods
#pragma mark  当属性值改变后，刷新 badge
- (void)scf_refreshBadge {
    // 赋值新属性值
    self.scf_badge.textColor = self.scf_badgeTextColor;
    self.scf_badge.backgroundColor = self.scf_badgeBGColor;
    self.scf_badge.font = self.scf_badgeFont;
    
    if (!self.scf_badgeValue
        || [self.scf_badgeValue isEqualToString:@""]
        || ([self.scf_badgeValue isEqualToString:@"0"] && self.scf_shouldHideBadgeAtZero)) {
        self.scf_badge.hidden = YES;
    }
    else {
        self.scf_badge.hidden = NO;
        [self scf_updateBadgeValueAnimated:YES];
    }
}

#pragma mark 处理 badge 值改变
- (void)scf_updateBadgeValueAnimated:(BOOL)animated {
    // 如果 badge 值改变，并且允许动画
    if (animated
        && self.scf_shouldAnimateBadge
        && ![self.scf_badge.text isEqualToString:self.scf_badgeValue]) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1.0]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4f :1.3f :1.0f :1.0f]];
        [self.scf_badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    
    // 重新赋值
    self.scf_badge.text = self.scf_badgeValue;
    
    // 是否需要 badge size 动画
    if (animated
        && self.scf_shouldAnimateBadge) {
        [UIView animateWithDuration:0.2 animations:^{
            [self scf_updateBadgeFrame];
        }];
    }
    else {
        [self scf_updateBadgeFrame];
    }
}

- (void)scf_updateBadgeFrame {
    CGSize lbExpectedSize = [self scf_badgeExpectedSize];
    
    // 如果实际最小高度小于设定的最小高度，则使用预定最小高度
    CGFloat minHeight = (lbExpectedSize.height < self.scf_badgeMinSize) ? self.scf_badgeMinSize : lbExpectedSize.height;
    // 根据最小高度确定最小宽度
    CGFloat minWidth = (lbExpectedSize.width < minHeight) ? minHeight : lbExpectedSize.width;
    CGFloat padding = self.scf_badgePadding;
    
    // 设置 badge 的frame
    self.scf_badge.layer.masksToBounds = YES;
    self.scf_badge.frame = CGRectMake(self.scf_badgeOriginX, self.scf_badgeOriginY, minWidth + padding, minHeight + padding);
    self.scf_badge.layer.cornerRadius = (minHeight + padding) / 2.0;
}

- (CGSize)scf_badgeExpectedSize {
    // 当 badge 值增大后，需要增大 badge 的 size
    // 计算 badge 的 size 以适应新值
    // 创建新的中间 label 去适应大小，而不是改变原 label 的size
    UILabel *lbFrame = [self scf_duplicateLabel:self.scf_badge];
    [lbFrame sizeToFit];
    
    CGSize lbExpectedSize = lbFrame.frame.size;
    return lbExpectedSize;
}

- (UILabel *)scf_duplicateLabel:(UILabel *)lbToCopy {
    UILabel *lbDuplicate = [[UILabel alloc] initWithFrame:lbToCopy.frame];
    lbDuplicate.text = lbToCopy.text;
    lbDuplicate.font = lbToCopy.font;
    
    return lbDuplicate;
}

#pragma mark 移除 badge
- (void)scf_removeBadge {
    // 动画移除
    [UIView animateWithDuration:0.2 animations:^{
        self.scf_badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.scf_badge removeFromSuperview];
        self.scf_badge = nil;
    }];
}

#pragma mark - getters / setters
#pragma mark scf_badge
- (UILabel *)scf_badge {
    UILabel *lb = objc_getAssociatedObject(self, &scf_UIButton_badgeKey);
    if (!lb) {
        lb = [[UILabel alloc] initWithFrame:CGRectMake(self.scf_badgeOriginX, self.scf_badgeOriginY, 20, 20)];
        [self setScf_badge:lb];
        [self scf_badgeInit];
        [self addSubview:lb];
        lb.textAlignment = NSTextAlignmentCenter;
    }
    return lb;
}

- (void)setScf_badge:(UILabel *)scf_badge {
    objc_setAssociatedObject(self, &scf_UIButton_badgeKey, scf_badge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark scf_badgeValue
- (NSString *)scf_badgeValue {
    return objc_getAssociatedObject(self, &scf_UIButton_badgeValueKey);
}

- (void)setScf_badgeValue:(NSString *)scf_badgeValue {
    objc_setAssociatedObject(self, &scf_UIButton_badgeValueKey, scf_badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 处理改变value
    [self scf_updateBadgeValueAnimated:YES];
    [self scf_refreshBadge];
}

#pragma mark scf_badgeBGColor
- (UIColor *)scf_badgeBGColor {
    return objc_getAssociatedObject(self, &scf_UIButton_badgeBGColorKey);
}

- (void)setScf_badgeBGColor:(UIColor *)scf_badgeBGColor {
    objc_setAssociatedObject(self, &scf_UIButton_badgeBGColorKey, scf_badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.scf_badge) {
        [self scf_refreshBadge];
    }
}

#pragma mark scf_badgeTextColor
- (UIColor *)scf_badgeTextColor {
    return objc_getAssociatedObject(self, &scf_UIButton_badgeTextColorKey);
}

- (void)setScf_badgeTextColor:(UIColor *)scf_badgeTextColor {
    objc_setAssociatedObject(self, &scf_UIButton_badgeTextColorKey, scf_badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.scf_badge) {
        [self scf_refreshBadge];
    }
}

#pragma mark scf_badgeFont
-  (UIFont *)scf_badgeFont {
    return objc_getAssociatedObject(self, &scf_UIButton_badgeFontKey);
}

- (void)setScf_badgeFont:(UIFont *)scf_badgeFont {
    objc_setAssociatedObject(self, &scf_UIButton_badgeFontKey, scf_badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.scf_badge) {
        [self scf_refreshBadge];
    }
}

#pragma mark scf_badgePadding
- (CGFloat)scf_badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &scf_UIButton_badgePaddingKey);
    return number.floatValue;
}

- (void)setScf_badgePadding:(CGFloat)scf_badgePadding {
    NSNumber *number = [NSNumber numberWithDouble:scf_badgePadding];
    objc_setAssociatedObject(self, &scf_UIButton_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.scf_badge) {
        [self scf_updateBadgeFrame];
    }
}

#pragma mark scf_badgeMinSize
- (CGFloat)scf_badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &scf_UIButton_badgeMinSizeKey);
    return number.floatValue;
}

- (void)setScf_badgeMinSize:(CGFloat)scf_badgeMinSize {
    NSNumber *number = [NSNumber numberWithDouble:scf_badgeMinSize];
    objc_setAssociatedObject(self, &scf_UIButton_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.scf_badge) {
        [self scf_updateBadgeFrame];
    }
}

#pragma mark scf_badgeOriginX
- (CGFloat)scf_badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &scf_UIButton_badgeOriginXKey);
    return number.floatValue;
}

- (void)setScf_badgeOriginX:(CGFloat)scf_badgeOriginX {
    NSNumber *number = [NSNumber numberWithDouble:scf_badgeOriginX];
    objc_setAssociatedObject(self, &scf_UIButton_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.scf_badge) {
        [self scf_updateBadgeFrame];
    }
}

#pragma mark scf_badgeOriginY
- (CGFloat)scf_badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &scf_UIButton_badgeOriginYKey);
    return number.floatValue;
}

- (void)setScf_badgeOriginY:(CGFloat)scf_badgeOriginY {
    NSNumber *number = [NSNumber numberWithDouble:scf_badgeOriginY];
    objc_setAssociatedObject(self, &scf_UIButton_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.scf_badge) {
        [self scf_updateBadgeFrame];
    }
}

#pragma mark scf_shouleHideBadgeAtZero
- (BOOL)scf_shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &scf_UIButton_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}

- (void)setScf_shouldHideBadgeAtZero:(BOOL)scf_shouldHideBadgeAtZero {
    NSNumber *number = [NSNumber numberWithBool:scf_shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &scf_UIButton_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.scf_badge) {
        [self scf_refreshBadge];
    }
}

#pragma mark scf_shouldAnimateBadge
- (BOOL)scf_shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &scf_UIButton_shouldAnimateBadgeKey);
    return number.boolValue;
}

- (void)setScf_shouldAnimateBadge:(BOOL)scf_shouldAnimateBadge {
    NSNumber *number = [NSNumber numberWithBool:scf_shouldAnimateBadge];
    objc_setAssociatedObject(self, &scf_UIButton_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.scf_badge) {
        [self scf_refreshBadge];
    }
}

@end
