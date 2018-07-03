//
//  UIWebView+SCFStyle.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/3.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIWebView+SCFStyle.h"

@implementation UIWebView (SCFStyle)

/**
 *  @brief  是否显示阴影
 *
 *  @param hidden 是否显示阴影
 */
- (void)scf_shadowViewHidden:(BOOL)hidden {
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)aView setShowsHorizontalScrollIndicator:NO];
            for (UIView *shadowView in aView.subviews) {
                if ([shadowView isKindOfClass:[UIImageView class]]) {
                    shadowView.hidden = hidden;  //上下滚动出边界时的黑色的图片 也就是拖拽后的上下阴影
                }
            }
        }
    }
}
/**
 *  @brief  是否显示水平滑动指示器
 *
 *  @param hidden 是否显示水平滑动指示器
 */
- (void)scf_showsHorizontalScrollIndicator:(BOOL)hidden {
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)aView setShowsHorizontalScrollIndicator:hidden];
        }
    }
}
/**
 *  @brief  是否显示垂直滑动指示器
 *
 *  @param hidden 是否显示垂直滑动指示器
 */
- (void)scf_showsVerticalScrollIndicator:(BOOL)hidden {
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)aView setShowsVerticalScrollIndicator:hidden];
        }
    }
}
/**
 *  @brief  网页透明
 */
-(void)scf_makeTransparent {
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
}
/**
 *  @brief  网页透明移除阴影
 */
-(void)scf_makeTransparentAndRemoveShadow {
    [self scf_makeTransparent];
    [self scf_shadowViewHidden:YES];
}

@end
