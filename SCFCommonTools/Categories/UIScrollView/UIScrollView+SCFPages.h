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

- (NSInteger)scf_pages;
- (NSInteger)scf_currentPage;

- (CGFloat)scf_scrollPercent;

- (CGFloat)scf_pagesX;
- (CGFloat)scf_pagesY;
- (CGFloat)scf_currentPageX;
- (CGFloat)scf_currentPageY;

- (void)scf_setPageX:(CGFloat)pageX;
- (void)scf_setPageY:(CGFloat)pageY;
- (void)scf_setPageX:(CGFloat)pageX animated:(BOOL)animated;
- (void)scf_setPageY:(CGFloat)pageY animated:(BOOL)animated;

@end
