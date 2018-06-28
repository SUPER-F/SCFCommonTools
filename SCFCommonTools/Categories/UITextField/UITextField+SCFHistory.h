//
//  UITextField+SCFHistory.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/28.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UITextField (SCFHistory)

// textfield 的 identify
@property (nonatomic, copy) NSString *scf_identify;

// 加载历史输入数据
- (NSArray *)scf_loadHistory;

// 保存当前输入的内容
- (void)scf_synchronize;

// 显示历史输入记录
- (void)scf_showHistory;

// 隐藏历史输入记录
- (void)scf_hideHistory;

// 清除历史输入记录
- (void)scf_clearHistory;

@end
