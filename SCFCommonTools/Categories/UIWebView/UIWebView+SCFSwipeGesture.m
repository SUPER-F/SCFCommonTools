//
//  UIWebView+SCFSwipeGesture.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/2.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIWebView+SCFSwipeGesture.h"

@interface UIWebView () <UIGestureRecognizerDelegate>

@end

@implementation UIWebView (SCFSwipeGesture)

- (void)addSwipeGesture {
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(p_swipeRight:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [swipeRight setNumberOfTouchesRequired:2];
    [swipeRight setDelegate:self];
    [self addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(p_swipeLeft:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionRight];
    [swipeLeft setNumberOfTouchesRequired:2];
    [swipeLeft setDelegate:self];
    [self addGestureRecognizer:swipeLeft];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan setMaximumNumberOfTouches:2];
    [pan setMinimumNumberOfTouches:2];
    [self addGestureRecognizer:pan];
    
    [pan requireGestureRecognizerToFail:swipeRight];
    [pan requireGestureRecognizerToFail:swipeLeft];
}

- (void)p_swipeRight:(UISwipeGestureRecognizer *)recognizer {
    if ([recognizer numberOfTouches] == 2 && [self canGoBack]) {
        [self goBack];
    }
}

- (void)p_swipeLeft:(UISwipeGestureRecognizer *)recognizer {
    if ([recognizer numberOfTouches] == 2 && [self canGoForward]) {
        [self goForward];
    }
}

@end
