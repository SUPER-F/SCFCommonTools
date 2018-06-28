//
//  UITextField+SCFSelect.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/28.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UITextField (SCFSelect)

// 当前选中的字符范围
- (NSRange)scf_selectedRange;

// 选中所有文字
- (void)scf_selectAllText;

// 设置指定范围的文字被选中
- (void)scf_setSelectedTextRange:(NSRange)range;

@end
