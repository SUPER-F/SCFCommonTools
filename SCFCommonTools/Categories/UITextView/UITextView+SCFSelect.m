//
//  UITextView+SCFSelect.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/29.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UITextView+SCFSelect.h"

@implementation UITextView (SCFSelect)

- (NSRange)scf_selectedRange {
    UITextPosition *beginning = self.beginningOfDocument;
    
    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *positionStart = selectedRange.start;
    UITextPosition *positionEnd = selectedRange.end;
    
    NSInteger location = [self offsetFromPosition:beginning toPosition:positionStart];
    NSInteger length = [self offsetFromPosition:positionStart toPosition:positionEnd];
    
    return NSMakeRange(location, length);
}

- (void)scf_selectAllText {
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}

- (void)scf_setSelectedTextRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *positionStart = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *positionEnd = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    
    UITextRange *selectedRange = [self textRangeFromPosition:positionStart toPosition:positionEnd];
    
    [self setSelectedTextRange:selectedRange];
}

- (NSInteger)scf_getInputLengthWithText:(NSString *)text {
    NSInteger textLength = 0;
    // 获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    if (selectedRange) {
        NSString *newText = [self textInRange:selectedRange];
        textLength = (newText.length + 1) / 2 + [self offsetFromPosition:self.beginningOfDocument toPosition:selectedRange.start] + text.length;
    }
    else {
        textLength = self.text.length + text.length;
    }
    return textLength;
}

@end
