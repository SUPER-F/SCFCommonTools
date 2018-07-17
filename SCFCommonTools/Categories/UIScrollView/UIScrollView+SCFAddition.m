//
//  UIScrollView+SCFAddition.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/27.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIScrollView+SCFAddition.h"
#import <objc/runtime.h>

NSString *const contentWidthKey = @"contentWidthKey";
NSString *const contentHeightKey = @"contentHeightKey";
NSString *const contentOffsetXKey = @"contentOffsetXKey";
NSString *const contentOffsetYKey = @"contentOffsetYKey";

@implementation UIScrollView (SCFAddition)

#pragma mark - contentOffset
- (CGPoint)contentOffsetTop {
    return CGPointMake(0.0f, -self.contentInset.top);
}

- (CGPoint)contentOffsetBottom {
    return CGPointMake(0.0f, self.contentSize.height + self.contentInset.bottom - self.bounds.size.height);
}

- (CGPoint)contentOffsetLeft {
    return CGPointMake(-self.contentInset.left, 0.0f);
}

- (CGPoint)contentOffsetRight {
    return CGPointMake(self.contentSize.width + self.contentInset.right - self.bounds.size.width, 0.0f);
}

#pragma mark - scrollViewDirection
- (SCFScrollViewDirection)scrollViewDirection {
    CGPoint translation = [self.panGestureRecognizer translationInView:self];
    SCFScrollViewDirection direction;
    if (translation.y < 0.0f) {
        direction = SCFScrollViewDirectionUp;
    }
    else if (translation.y > 0.0f) {
        direction = SCFScrollViewDirectionDown;
    }
    else if (translation.x < 0.0f) {
        direction = SCFScrollViewDirectionLeft;
    }
    else if (translation.x > 0.0f) {
        direction = SCFScrollViewDirectionRight;
    }
    else {
        direction = SCFScrollViewDirectionWTF;
    }
    return direction;
}

#pragma mark - isScrolled
- (BOOL)isScrolledToTop {
    return self.contentOffset.y <= [self contentOffsetTop].y;
}

- (BOOL)isScrolledToBottom {
    return self.contentOffset.y >= [self contentOffsetBottom].y;
}

- (BOOL)isScrolledToLeft {
    return self.contentOffset.x <= [self contentOffsetLeft].x;
}

- (BOOL)isScrolledToRight {
    return self.contentOffset.x >= [self contentOffsetRight].x;
}

#pragma mark - scrollTo
- (void)scrollToTopAnimated:(BOOL)animated {
    [self setContentOffset:[self contentOffsetTop] animated:animated];
}

- (void)scrollToBottomAnimated:(BOOL)animated {
    [self setContentOffset:[self contentOffsetBottom] animated:animated];
}

- (void)scrollToLeftAnimated:(BOOL)animated {
    [self setContentOffset:[self contentOffsetLeft] animated:animated];
}

- (void)scrollToRightAnimated:(BOOL)animated {
    [self setContentOffset:[self contentOffsetRight] animated:animated];
}

#pragma mark - pageIndex
- (NSUInteger)pageIndexVertical {
    return (self.contentOffset.y + (self.frame.size.height * 0.5f)) / self.frame.size.height;
}

- (NSUInteger)pageIndexHorizontal {
    return (self.contentOffset.x + (self.frame.size.width * 0.5f)) / self.frame.size.width;
}

#pragma mark - scrollToPageIndex
- (void)scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated {
    [self setContentOffset:CGPointMake(0.0f, self.frame.size.height * pageIndex) animated:animated];
}

- (void)scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated {
    [self setContentOffset:CGPointMake(self.frame.size.width * pageIndex, 0.0f) animated:animated];
}

#pragma mark - setters / getters
#pragma mark contentWidth
- (void)setContentWidth:(CGFloat)contentWidth {
    NSNumber *number = [NSNumber numberWithFloat:contentWidth];
    objc_setAssociatedObject(self,
                             &contentWidthKey,
                             number,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)contentWidth {
    NSNumber *number = objc_getAssociatedObject(self, &contentWidthKey);
    return number.floatValue;
}

#pragma mark contentHeight
- (void)setContentHeight:(CGFloat)contentHeight {
    NSNumber *number = [NSNumber numberWithFloat:contentHeight];
    objc_setAssociatedObject(self,
                             &contentHeightKey,
                             number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)contentHeight {
    NSNumber *number = objc_getAssociatedObject(self, &contentHeightKey);
    return number.floatValue;
}

#pragma mark contentOffsetX
- (void)setContentOffsetX:(CGFloat)contentOffsetX {
    NSNumber *number = [NSNumber numberWithFloat:contentOffsetX];
    objc_setAssociatedObject(self,
                             &contentOffsetXKey,
                             number,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)contentOffsetX {
    NSNumber *number = objc_getAssociatedObject(self, &contentOffsetXKey);
    return number.floatValue;
}

#pragma mark contentOffsetY
- (void)setContentOffsetY:(CGFloat)contentOffsetY {
    NSNumber *number = [NSNumber numberWithFloat:contentOffsetY];
    objc_setAssociatedObject(self, &contentOffsetYKey,
                             number,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)contentOffsetY {
    NSNumber *number = objc_getAssociatedObject(self, &contentOffsetYKey);
    return number.floatValue;
}

@end
