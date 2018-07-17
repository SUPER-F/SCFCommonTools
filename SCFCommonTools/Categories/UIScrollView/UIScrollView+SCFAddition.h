//
//  UIScrollView+SCFAddition.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/27.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SCFScrollViewDirection) {
    SCFScrollViewDirectionUp,
    SCFScrollViewDirectionDown,
    SCFScrollViewDirectionLeft,
    SCFScrollViewDirectionRight,
    SCFScrollViewDirectionWTF,
};

@interface UIScrollView (SCFAddition)

@property (nonatomic) CGFloat contentWidth;
@property (nonatomic) CGFloat contentHeight;
@property (nonatomic) CGFloat contentOffsetX;
@property (nonatomic) CGFloat contentOffsetY;

- (CGPoint)contentOffsetTop;
- (CGPoint)contentOffsetBottom;
- (CGPoint)contentOffsetLeft;
- (CGPoint)contentOffsetRight;

- (SCFScrollViewDirection)scrollViewDirection;

- (BOOL)isScrolledToTop;
- (BOOL)isScrolledToBottom;
- (BOOL)isScrolledToLeft;
- (BOOL)isScrolledToRight;

- (void)scrollToTopAnimated:(BOOL)animated;
- (void)scrollToBottomAnimated:(BOOL)animated;
- (void)scrollToLeftAnimated:(BOOL)animated;
- (void)scrollToRightAnimated:(BOOL)animated;

- (NSUInteger)pageIndexVertical;
- (NSUInteger)pageIndexHorizontal;

- (void)scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
- (void)scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;

@end
