//
//  UITextView+SCFSelect.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/29.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UITextView (SCFSelect)

// 当前选中的字符范围
- (NSRange)scf_selectedRange;

// 选中所有文字
- (void)scf_selectAllText;

// 设置指定范围的文字被选中
- (void)scf_setSelectedTextRange:(NSRange)range;

// 用于计算textview输入情况下的字符数，解决实现 UITextView+SCFInputLimit 限制字符数时，计算不准的问题
- (NSInteger)scf_getInputLengthWithText:(NSString *)text;

@end
