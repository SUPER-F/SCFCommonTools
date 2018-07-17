//
//  UIScrollView+SCFPages.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/28.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIScrollView+SCFPages.h"

@implementation UIScrollView (SCFPages)

- (NSInteger)pages {
    NSInteger pages = self.contentSize.width / self.frame.size.width;
    return pages;
}

- (NSInteger)currentPage {
    NSInteger pages = [self pages];
    CGFloat scrollPercent = [self scrollPercent];
    NSInteger currentPage = (NSInteger)roundf((pages - 1) * scrollPercent);
    return currentPage;
}

- (CGFloat)scrollPercent {
    CGFloat width = self.contentSize.width - self.frame.size.width;
    CGFloat scrollPercent = self.contentOffset.x / width;
    return scrollPercent;
}

- (CGFloat)pagesX {
    CGFloat pageWidth = self.frame.size.width;
    CGFloat contentWidth = self.contentSize.width;
    return contentWidth / pageWidth;
}

- (CGFloat)pagesY {
    CGFloat pageHeight = self.frame.size.height;
    CGFloat contentHeight = self.contentSize.height;
    return contentHeight / pageHeight;
}

- (CGFloat)currentPageX {
    CGFloat pageWidth = self.frame.size.width;
    CGFloat offsetX = self.contentOffset.x;
    return offsetX / pageWidth;
}

- (CGFloat)currentPageY {
    CGFloat pageHeight = self.frame.size.height;
    CGFloat offsetY = self.contentOffset.y;
    return offsetY / pageHeight;
}

- (void)setPageX:(CGFloat)pageX {
    [self setPageX:pageX animated:NO];
}

- (void)setPageY:(CGFloat)pageY {
    [self setPageY:pageY animated:NO];
}

- (void)setPageX:(CGFloat)pageX animated:(BOOL)animated {
    CGFloat pageWidth = self.frame.size.width;
    CGFloat offsetY = self.contentOffset.y;
    CGFloat offsetX = pageX * pageWidth;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self setContentOffset:offset animated:animated];
}

- (void)setPageY:(CGFloat)pageY animated:(BOOL)animated {
    CGFloat pageHeight = self.frame.size.height;
    CGFloat offsetY = pageY * pageHeight;
    CGFloat offsetX = self.contentOffset.x;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self setContentOffset:offset animated:animated];
}

@end
