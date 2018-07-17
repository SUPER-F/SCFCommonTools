//
//  UITextView+SCFInputLimit.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/29.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UITextView+SCFInputLimit.h"
#import <objc/runtime.h>

static const void *SCFTextViewInputLimitMaxLength = &SCFTextViewInputLimitMaxLength;

@implementation UITextView (SCFInputLimit)

- (void)setMaxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self,
                             SCFTextViewInputLimitMaxLength,
                             @(maxLength),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:self];
}

- (NSInteger)maxLength {
    NSNumber *number = objc_getAssociatedObject(self, SCFTextViewInputLimitMaxLength);
    return number.integerValue;
}

- (void)textViewTextDidChange:(NSNotification *)notification {
    NSString *toBeString = self.text;
    // 获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    // 如果没有高亮选择的字，则对已输入的文字进行字数统计和限制
    // 在iOS7下，position对象总是不为nil
    if ((!position || !selectedRange)
        && (self.maxLength > 0 && toBeString.length > self.maxLength)) {
        NSRange rangeAtIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.maxLength];
        if (rangeAtIndex.length == 1) {
            self.text = [toBeString substringToIndex:self.maxLength];
        }
        else {
            NSRange rangeForRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.maxLength)];
            NSInteger tmpLength;
            if (rangeForRange.length > self.maxLength) {
                tmpLength = rangeForRange.length - rangeAtIndex.length;
            }
            else {
                tmpLength = rangeForRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
