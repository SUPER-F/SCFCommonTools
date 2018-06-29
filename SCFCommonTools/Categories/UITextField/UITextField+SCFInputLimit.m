//
//  UITextField+SCFInputLimit.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/29.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UITextField+SCFInputLimit.h"
#import <objc/runtime.h>

static const void *SCFTextFieldInputLimitMaxLength = &SCFTextFieldInputLimitMaxLength;

@implementation UITextField (SCFInputLimit)

- (void)setScf_maxLength:(NSInteger)scf_maxLength {
    objc_setAssociatedObject(self,
                             SCFTextFieldInputLimitMaxLength,
                             @(scf_maxLength),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(scf_textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}

- (NSInteger)scf_maxLength {
    NSNumber *number = objc_getAssociatedObject(self, SCFTextFieldInputLimitMaxLength);
    return number.integerValue;
}

- (void)scf_textFieldTextDidChange {
    NSString *toBeString = self.text;
    // 获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    // 如果没有高亮选择的字，则对已输入的文字进行字数统计和限制
    // 在iOS7下，position对象总是不为nil
    if ((!position || !selectedRange)
        && (self.scf_maxLength > 0 && toBeString.length > self.scf_maxLength)) {
        NSRange rangeAtIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.scf_maxLength];
        if (rangeAtIndex.length == 1) {
            self.text = [toBeString substringToIndex:self.scf_maxLength];
        }
        else {
            NSRange rangeForRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.scf_maxLength)];
            NSInteger tmpLength;
            if (rangeForRange.length > self.scf_maxLength) {
                tmpLength = rangeForRange.length - rangeAtIndex.length;
            }
            else {
                tmpLength = rangeForRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}

@end
