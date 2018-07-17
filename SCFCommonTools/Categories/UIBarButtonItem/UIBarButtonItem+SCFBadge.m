//
//  UIBarButtonItem+SCFBadge.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/19.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIBarButtonItem+SCFBadge.h"
#import <objc/runtime.h>

NSString const *UIBarButtonItem_badgeKey = @"UIBarButtonItem_badgeKey";

NSString const *UIBarButtonItem_badgeBGColorKey = @"UIBarButtonItem_badgeBGColorKey";
NSString const *UIBarButtonItem_badgeTextColorKey = @"UIBarButtonItem_badgeTextColorKey";
NSString const *UIBarButtonItem_badgeFontKey = @"UIBarButtonItem_badgeFontKey";
NSString const *UIBarButtonItem_badgePaddingKey = @"UIBarButtonItem_badgePaddingKey";
NSString const *UIBarButtonItem_badgeMinSizeKey = @"UIBarButtonItem_badgeMinSizeKey";
NSString const *UIBarButtonItem_badgeOriginXKey = @"UIBarButtonItem_badgeOriginXKey";
NSString const *UIBarButtonItem_badgeOriginYKey = @"UIBarButtonItem_badgeOriginYKey";
NSString const *UIBarButtonItem_shouldHideBadgeAtZeroKey = @"UIBarButtonItem_shouldHideBadgeAtZeroKey";
NSString const *UIBarButtonItem_shouldAnimateBadgeKey = @"UIBarButtonItem_shouldAnimateBadgeKey";
NSString const *UIBarButtonItem_badgeValueKey = @"UIBarButtonItem_badgeValueKey";

@implementation UIBarButtonItem (SCFBadge)

@dynamic badgeValue, badgeBGColor, badgeTextColor, badgeFont;
@dynamic badgePadding, badgeMinSize, badgeOriginX, badgeOriginY;
@dynamic shouldAnimateBadge, shouldHideBadgeAtZero;
@dynamic badge;

- (void)badgeInit {
    UIView *superview = nil;
    CGFloat defaultOriginX = 0;
    if (self.customView) {
        superview = self.customView;
        defaultOriginX = superview.frame.size.width - self.badge.frame.size.width / 2.0;
        // Avoids badge to be clipped when animating its scale
        superview.clipsToBounds = NO;
    }
    else if ([self respondsToSelector:@selector(view)] && [(id)self view]) {
        superview = [(id)self view];
        defaultOriginX = superview.frame.size.width - self.badge.frame.size.width;
    }
    [superview addSubview:self.badge];
    
    // Default design initialization
    self.badgeBGColor = [UIColor redColor];
    self.badgeTextColor = [UIColor whiteColor];
    self.badgeFont = [UIFont systemFontOfSize:12.0];
    self.badgePadding = 6.0;
    self.badgeMinSize = 8.0;
    self.badgeOriginX = defaultOriginX;
    self.badgeOriginY = -4.0;
    self.shouldHideBadgeAtZero = YES;
    self.shouldAnimateBadge = YES;
}

#pragma mark - Utility methods
#pragma mark  当属性值改变后，刷新 badge
- (void)refreshBadge {
    // 赋值新属性值
    self.badge.textColor = self.badgeTextColor;
    self.badge.backgroundColor = self.badgeBGColor;
    self.badge.font = self.badgeFont;
    
    if (!self.badgeValue
        || [self.badgeValue isEqualToString:@""]
        || ([self.badgeValue isEqualToString:@"0"] && self.shouldHideBadgeAtZero)) {
        self.badge.hidden = YES;
    }
    else {
        self.badge.hidden = NO;
        [self updateBadgeValueAnimated:YES];
    }
}

#pragma mark 处理 badge 值改变
- (void)updateBadgeValueAnimated:(BOOL)animated {
    // 如果 badge 值改变，并且允许动画
    if (animated
        && self.shouldAnimateBadge
        && ![self.badge.text isEqualToString:self.badgeValue]) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1.0]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4f :1.3f :1.0f :1.0f]];
        [self.badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    
    // 重新赋值
    self.badge.text = self.badgeValue;
    
    // 是否需要 badge size 动画
    if (animated
        && self.shouldAnimateBadge) {
        [UIView animateWithDuration:0.2 animations:^{
            [self updateBadgeFrame];
        }];
    }
    else {
        [self updateBadgeFrame];
    }
}

- (void)updateBadgeFrame {
    CGSize lbExpectedSize = [self badgeExpectedSize];
    
    // 如果实际最小高度小于设定的最小高度，则使用预定最小高度
    CGFloat minHeight = (lbExpectedSize.height < self.badgeMinSize) ? self.badgeMinSize : lbExpectedSize.height;
    // 根据最小高度确定最小宽度
    CGFloat minWidth = (lbExpectedSize.width < minHeight) ? minHeight : lbExpectedSize.width;
    CGFloat padding = self.badgePadding;
    
    // 设置 badge 的frame
    self.badge.layer.masksToBounds = YES;
    self.badge.frame = CGRectMake(self.badgeOriginX, self.badgeOriginY, minWidth + padding, minHeight + padding);
    self.badge.layer.cornerRadius = (minHeight + padding) / 2.0;
}

- (CGSize)badgeExpectedSize {
    // 当 badge 值增大后，需要增大 badge 的 size
    // 计算 badge 的 size 以适应新值
    // 创建新的中间 label 去适应大小，而不是改变原 label 的size
    UILabel *lbFrame = [self duplicateLabel:self.badge];
    [lbFrame sizeToFit];
    
    CGSize lbExpectedSize = lbFrame.frame.size;
    return lbExpectedSize;
}

- (UILabel *)duplicateLabel:(UILabel *)lbToCopy {
    UILabel *lbDuplicate = [[UILabel alloc] initWithFrame:lbToCopy.frame];
    lbDuplicate.text = lbToCopy.text;
    lbDuplicate.font = lbToCopy.font;
    
    return lbDuplicate;
}

#pragma mark 移除 badge
- (void)removeBadge {
    // 动画移除
    [UIView animateWithDuration:0.2 animations:^{
        self.badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.badge removeFromSuperview];
        self.badge = nil;
    }];
}

#pragma mark - getters / setters
#pragma mark badge
- (UILabel *)badge {
    UILabel *lb = objc_getAssociatedObject(self, &UIBarButtonItem_badgeKey);
    if (!lb) {
        lb = [[UILabel alloc] initWithFrame:CGRectMake(self.badgeOriginX, self.badgeOriginY, 20, 20)];
        [self setbadge:lb];
        [self badgeInit];
        [self.customView addSubview:lb];
        lb.textAlignment = NSTextAlignmentCenter;
    }
    return lb;
}

- (void)setbadge:(UILabel *)badge {
    objc_setAssociatedObject(self, &UIBarButtonItem_badgeKey, badge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark badgeValue
- (NSString *)badgeValue {
    return objc_getAssociatedObject(self, &UIBarButtonItem_badgeValueKey);
}

- (void)setbadgeValue:(NSString *)badgeValue {
    objc_setAssociatedObject(self, &UIBarButtonItem_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 处理改变value
    [self updateBadgeValueAnimated:YES];
    [self refreshBadge];
}

#pragma mark badgeBGColor
- (UIColor *)badgeBGColor {
    return objc_getAssociatedObject(self, &UIBarButtonItem_badgeBGColorKey);
}

- (void)setbadgeBGColor:(UIColor *)badgeBGColor {
    objc_setAssociatedObject(self, &UIBarButtonItem_badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

#pragma mark badgeTextColor
- (UIColor *)badgeTextColor {
    return objc_getAssociatedObject(self, &UIBarButtonItem_badgeTextColorKey);
}

- (void)setbadgeTextColor:(UIColor *)badgeTextColor {
    objc_setAssociatedObject(self, &UIBarButtonItem_badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

#pragma mark badgeFont
-  (UIFont *)badgeFont {
    return objc_getAssociatedObject(self, &UIBarButtonItem_badgeFontKey);
}

- (void)setbadgeFont:(UIFont *)badgeFont {
    objc_setAssociatedObject(self, &UIBarButtonItem_badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

#pragma mark badgePadding
- (CGFloat)badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &UIBarButtonItem_badgePaddingKey);
    return number.floatValue;
}

- (void)setbadgePadding:(CGFloat)badgePadding {
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &UIBarButtonItem_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

#pragma mark badgeMinSize
- (CGFloat)badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &UIBarButtonItem_badgeMinSizeKey);
    return number.floatValue;
}

- (void)setbadgeMinSize:(CGFloat)badgeMinSize {
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &UIBarButtonItem_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

#pragma mark badgeOriginX
- (CGFloat)badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &UIBarButtonItem_badgeOriginXKey);
    return number.floatValue;
}

- (void)setbadgeOriginX:(CGFloat)badgeOriginX {
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &UIBarButtonItem_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

#pragma mark badgeOriginY
- (CGFloat)badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &UIBarButtonItem_badgeOriginYKey);
    return number.floatValue;
}

- (void)setbadgeOriginY:(CGFloat)badgeOriginY {
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &UIBarButtonItem_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

#pragma mark shouleHideBadgeAtZero
- (BOOL)shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &UIBarButtonItem_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}

- (void)setshouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero {
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &UIBarButtonItem_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

#pragma mark shouldAnimateBadge
- (BOOL)shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &UIBarButtonItem_shouldAnimateBadgeKey);
    return number.boolValue;
}

- (void)setshouldAnimateBadge:(BOOL)shouldAnimateBadge {
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &UIBarButtonItem_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}


@end
