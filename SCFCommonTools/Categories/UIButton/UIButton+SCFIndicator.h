//
//  UIButton+SCFIndicator.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/20.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIButton (SCFIndicator)

// 使用活动指示器代替按钮的文本
// 显示活动指示器，隐藏按钮文本
- (void)showIndicator;

// 隐藏活动指示器，显示按钮文本
- (void)hideIndicator;

@end
