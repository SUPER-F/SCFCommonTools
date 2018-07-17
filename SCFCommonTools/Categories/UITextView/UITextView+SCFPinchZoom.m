//
//  UITextView+SCFPinchZoom.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/29.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UITextView+SCFPinchZoom.h"
#import <objc/runtime.h>

static const void *SCFTextViewTextMinFontSizeKey = &SCFTextViewTextMinFontSizeKey;
static const void *SCFTextViewTextMaxFontSizeKey = &SCFTextViewTextMaxFontSizeKey;
static const void *SCFTextViewTextZoomEnabledKey = &SCFTextViewTextZoomEnabledKey;

@implementation UITextView (SCFPinchZoom)

#pragma mark - setters / getters
#pragma mark minFontSize
- (void)setMinFontSize:(CGFloat)minFontSize {
    NSNumber *number = [NSNumber numberWithFloat:minFontSize];
    objc_setAssociatedObject(self,
                             SCFTextViewTextMinFontSizeKey,
                             number,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)minFontSize {
    NSNumber *number = objc_getAssociatedObject(self, SCFTextViewTextMinFontSizeKey);
    return number.floatValue;
}

#pragma mark maxFontSize
- (void)setMaxFontSize:(CGFloat)maxFontSize {
    NSNumber *number = [NSNumber numberWithFloat:maxFontSize];
    objc_setAssociatedObject(self,
                             SCFTextViewTextMaxFontSizeKey,
                             number,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)maxFontSize {
    NSNumber *number = objc_getAssociatedObject(self, SCFTextViewTextMaxFontSizeKey);
    return number.floatValue;
}

#pragma mark zoomEnabled
- (void)setZoomEnabled:(BOOL)zoomEnabled {
    NSNumber *number = [NSNumber numberWithBool:zoomEnabled];
    objc_setAssociatedObject(self,
                             SCFTextViewTextZoomEnabledKey,
                             number,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (zoomEnabled) {
        for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
            if ([recognizer isKindOfClass:[UIPinchGestureRecognizer class]]) {
                return;
            }
        }
        
        self.minFontSize = self.minFontSize ? self.minFontSize : 8.0f;
        self.maxFontSize = self.maxFontSize ? self.maxFontSize : 42.0f;
        
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(p_pinchGesture:)];
        [self addGestureRecognizer:pinchRecognizer];
    }
}

- (BOOL)zoomEnabled {
    NSNumber *number = objc_getAssociatedObject(self, SCFTextViewTextZoomEnabledKey);
    return number.boolValue;
}

- (void)p_pinchGesture:(UIPinchGestureRecognizer *)recognizer {
    if (!self.zoomEnabled) {
        return;
    }
    
    CGFloat fontSize = (recognizer.velocity > 0.0f ? 1.0f : -1.0f) + self.font.pointSize;
    fontSize = MAX(MIN(fontSize, self.maxFontSize), self.minFontSize);
    
    self.font = [UIFont fontWithName:self.font.fontName size:fontSize];
}

@end
