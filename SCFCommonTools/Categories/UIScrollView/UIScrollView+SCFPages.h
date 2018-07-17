//
//  UIScrollView+SCFPages.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/28.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIScrollView (SCFPages)

- (NSInteger)pages;
- (NSInteger)currentPage;

- (CGFloat)scrollPercent;

- (CGFloat)pagesX;
- (CGFloat)pagesY;
- (CGFloat)currentPageX;
- (CGFloat)currentPageY;

- (void)setPageX:(CGFloat)pageX;
- (void)setPageY:(CGFloat)pageY;
- (void)setPageX:(CGFloat)pageX animated:(BOOL)animated;
- (void)setPageY:(CGFloat)pageY animated:(BOOL)animated;

@end
