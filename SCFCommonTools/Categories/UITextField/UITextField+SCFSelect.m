//
//  UITextField+SCFSelect.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/28.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UITextField+SCFSelect.h"

@implementation UITextField (SCFSelect)

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

@end
