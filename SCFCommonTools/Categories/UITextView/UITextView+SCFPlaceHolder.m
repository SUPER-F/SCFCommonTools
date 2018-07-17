//
//  UITextView+SCFPlaceHolder.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/29.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UITextView+SCFPlaceHolder.h"
#import <objc/runtime.h>

static const void *placeHolderTextViewKey = &placeHolderTextViewKey;

@implementation UITextView (SCFPlaceHolder)

- (void)setPlaceHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self,
                             placeHolderTextViewKey,
                             placeHolderTextView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITextView *)placeHolderTextView {
    return objc_getAssociatedObject(self, placeHolderTextViewKey);
}

- (void)addPlaceHolder:(NSString *)placeHolder {
    if (![self placeHolderTextView]) {
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        
        [self setPlaceHolderTextView:textView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_textViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    }
    
    self.placeHolderTextView.text = placeHolder;
}

#pragma mark - UITextViewDelegate notification
- (void)p_textViewDidBeginEditing:(NSNotification *)notification {
    self.placeHolderTextView.hidden = YES;
}

- (void)p_textViewDidEndEditing:(NSNotification *)notification {
    if (!self.text || [self.text isEqualToString:@""]) {
        self.placeHolderTextView.hidden = NO;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
