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
#pragma mark scf_minFontSize
- (void)setScf_minFontSize:(CGFloat)scf_minFontSize {
    NSNumber *number = [NSNumber numberWithFloat:scf_minFontSize];
    objc_setAssociatedObject(self,
                             SCFTextViewTextMinFontSizeKey,
                             number,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)scf_minFontSize {
    NSNumber *number = objc_getAssociatedObject(self, SCFTextViewTextMinFontSizeKey);
    return number.floatValue;
}

#pragma mark scf_maxFontSize
- (void)setScf_maxFontSize:(CGFloat)scf_maxFontSize {
    NSNumber *number = [NSNumber numberWithFloat:scf_maxFontSize];
    objc_setAssociatedObject(self,
                             SCFTextViewTextMaxFontSizeKey,
                             number,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)scf_maxFontSize {
    NSNumber *number = objc_getAssociatedObject(self, SCFTextViewTextMaxFontSizeKey);
    return number.floatValue;
}

#pragma mark scf_zoomEnabled
- (void)setScf_zoomEnabled:(BOOL)scf_zoomEnabled {
    NSNumber *number = [NSNumber numberWithBool:scf_zoomEnabled];
    objc_setAssociatedObject(self,
                             SCFTextViewTextZoomEnabledKey,
                             number,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (scf_zoomEnabled) {
        for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
            if ([recognizer isKindOfClass:[UIPinchGestureRecognizer class]]) {
                return;
            }
        }
        
        self.scf_minFontSize = self.scf_minFontSize ? self.scf_minFontSize : 8.0f;
        self.scf_maxFontSize = self.scf_maxFontSize ? self.scf_maxFontSize : 42.0f;
        
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(p_scf_pinchGesture:)];
        [self addGestureRecognizer:pinchRecognizer];
    }
}

- (BOOL)scf_zoomEnabled {
    NSNumber *number = objc_getAssociatedObject(self, SCFTextViewTextZoomEnabledKey);
    return number.boolValue;
}

- (void)p_scf_pinchGesture:(UIPinchGestureRecognizer *)recognizer {
    if (!self.scf_zoomEnabled) {
        return;
    }
    
    CGFloat fontSize = (recognizer.velocity > 0.0f ? 1.0f : -1.0f) + self.font.pointSize;
    fontSize = MAX(MIN(fontSize, self.scf_maxFontSize), self.scf_minFontSize);
    
    self.font = [UIFont fontWithName:self.font.fontName size:fontSize];
}

@end
