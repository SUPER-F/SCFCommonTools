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

static const void *scf_placeHolderTextViewKey = &scf_placeHolderTextViewKey;

@implementation UITextView (SCFPlaceHolder)

- (void)setScf_placeHolderTextView:(UITextView *)scf_placeHolderTextView {
    objc_setAssociatedObject(self,
                             scf_placeHolderTextViewKey,
                             scf_placeHolderTextView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITextView *)scf_placeHolderTextView {
    return objc_getAssociatedObject(self, scf_placeHolderTextViewKey);
}

- (void)scf_addPlaceHolder:(NSString *)placeHolder {
    if (![self scf_placeHolderTextView]) {
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        
        [self setScf_placeHolderTextView:textView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_scf_textViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_scf_textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    }
    
    self.scf_placeHolderTextView.text = placeHolder;
}

#pragma mark - UITextViewDelegate notification
- (void)p_scf_textViewDidBeginEditing:(NSNotification *)notification {
    self.scf_placeHolderTextView.hidden = YES;
}

- (void)p_scf_textViewDidEndEditing:(NSNotification *)notification {
    if (!self.text || [self.text isEqualToString:@""]) {
        self.scf_placeHolderTextView.hidden = NO;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
