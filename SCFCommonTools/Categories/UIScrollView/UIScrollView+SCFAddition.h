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

@property (nonatomic) CGFloat scf_contentWidth;
@property (nonatomic) CGFloat scf_contentHeight;
@property (nonatomic) CGFloat scf_contentOffsetX;
@property (nonatomic) CGFloat scf_contentOffsetY;

- (CGPoint)scf_contentOffsetTop;
- (CGPoint)scf_contentOffsetBottom;
- (CGPoint)scf_contentOffsetLeft;
- (CGPoint)scf_contentOffsetRight;

- (SCFScrollViewDirection)scf_scrollViewDirection;

- (BOOL)scf_isScrolledToTop;
- (BOOL)scf_isScrolledToBottom;
- (BOOL)scf_isScrolledToLeft;
- (BOOL)scf_isScrolledToRight;

- (void)scf_scrollToTopAnimated:(BOOL)animated;
- (void)scf_scrollToBottomAnimated:(BOOL)animated;
- (void)scf_scrollToLeftAnimated:(BOOL)animated;
- (void)scf_scrollToRightAnimated:(BOOL)animated;

- (NSUInteger)scf_pageIndexVertical;
- (NSUInteger)scf_pageIndexHorizontal;

- (void)scf_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
- (void)scf_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;

@end
