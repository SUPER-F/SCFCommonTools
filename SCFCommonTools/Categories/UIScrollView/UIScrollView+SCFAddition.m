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

NSString *const scf_contentWidthKey = @"scf_contentWidthKey";
NSString *const scf_contentHeightKey = @"scf_contentHeightKey";
NSString *const scf_contentOffsetXKey = @"scf_contentOffsetXKey";
NSString *const scf_contentOffsetYKey = @"scf_contentOffsetYKey";

@implementation UIScrollView (SCFAddition)

#pragma mark - contentOffset
- (CGPoint)scf_contentOffsetTop {
    return CGPointMake(0.0f, -self.contentInset.top);
}

- (CGPoint)scf_contentOffsetBottom {
    return CGPointMake(0.0f, self.contentSize.height + self.contentInset.bottom - self.bounds.size.height);
}

- (CGPoint)scf_contentOffsetLeft {
    return CGPointMake(-self.contentInset.left, 0.0f);
}

- (CGPoint)scf_contentOffsetRight {
    return CGPointMake(self.contentSize.width + self.contentInset.right - self.bounds.size.width, 0.0f);
}

#pragma mark - scrollViewDirection
- (SCFScrollViewDirection)scf_scrollViewDirection {
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
- (BOOL)scf_isScrolledToTop {
    return self.contentOffset.y <= [self scf_contentOffsetTop].y;
}

- (BOOL)scf_isScrolledToBottom {
    return self.contentOffset.y >= [self scf_contentOffsetBottom].y;
}

- (BOOL)scf_isScrolledToLeft {
    return self.contentOffset.x <= [self scf_contentOffsetLeft].x;
}

- (BOOL)scf_isScrolledToRight {
    return self.contentOffset.x >= [self scf_contentOffsetRight].x;
}

#pragma mark - scrollTo
- (void)scf_scrollToTopAnimated:(BOOL)animated {
    [self setContentOffset:[self scf_contentOffsetTop] animated:animated];
}

- (void)scf_scrollToBottomAnimated:(BOOL)animated {
    [self setContentOffset:[self scf_contentOffsetBottom] animated:animated];
}

- (void)scf_scrollToLeftAnimated:(BOOL)animated {
    [self setContentOffset:[self scf_contentOffsetLeft] animated:animated];
}

- (void)scf_scrollToRightAnimated:(BOOL)animated {
    [self setContentOffset:[self scf_contentOffsetRight] animated:animated];
}

#pragma mark - pageIndex
- (NSUInteger)scf_pageIndexVertical {
    return (self.contentOffset.y + (self.frame.size.height * 0.5f)) / self.frame.size.height;
}

- (NSUInteger)scf_pageIndexHorizontal {
    return (self.contentOffset.x + (self.frame.size.width * 0.5f)) / self.frame.size.width;
}

#pragma mark - scrollToPageIndex
- (void)scf_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated {
    [self setContentOffset:CGPointMake(0.0f, self.frame.size.height * pageIndex) animated:animated];
}

- (void)scf_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated {
    [self setContentOffset:CGPointMake(self.frame.size.width * pageIndex, 0.0f) animated:animated];
}

#pragma mark - setters / getters
#pragma mark scf_contentWidth
- (void)setScf_contentWidth:(CGFloat)scf_contentWidth {
    NSNumber *number = [NSNumber numberWithFloat:scf_contentWidth];
    objc_setAssociatedObject(self,
                             &scf_contentWidthKey,
                             number,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)scf_contentWidth {
    NSNumber *number = objc_getAssociatedObject(self, &scf_contentWidthKey);
    return number.floatValue;
}

#pragma mark scf_contentHeight
- (void)setScf_contentHeight:(CGFloat)scf_contentHeight {
    NSNumber *number = [NSNumber numberWithFloat:scf_contentHeight];
    objc_setAssociatedObject(self,
                             &scf_contentHeightKey,
                             number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)scf_contentHeight {
    NSNumber *number = objc_getAssociatedObject(self, &scf_contentHeightKey);
    return number.floatValue;
}

#pragma mark scf_contentOffsetX
- (void)setScf_contentOffsetX:(CGFloat)scf_contentOffsetX {
    NSNumber *number = [NSNumber numberWithFloat:scf_contentOffsetX];
    objc_setAssociatedObject(self,
                             &scf_contentOffsetXKey,
                             number,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)scf_contentOffsetX {
    NSNumber *number = objc_getAssociatedObject(self, &scf_contentOffsetXKey);
    return number.floatValue;
}

#pragma mark scf_contentOffsetY
- (void)setScf_contentOffsetY:(CGFloat)scf_contentOffsetY {
    NSNumber *number = [NSNumber numberWithFloat:scf_contentOffsetY];
    objc_setAssociatedObject(self, &scf_contentOffsetYKey,
                             number,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)scf_contentOffsetY {
    NSNumber *number = objc_getAssociatedObject(self, &scf_contentOffsetYKey);
    return number.floatValue;
}

@end
