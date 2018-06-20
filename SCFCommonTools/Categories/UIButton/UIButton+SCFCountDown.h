//
//  UIButton+SCFCountDown.h
//  SCFCommonTools
//
//  Created by 博颐 on 2018/6/20.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIButton (SCFCountDown)


/**
 按钮倒计时

 @param timeout 倒计时时间
 @param title 按钮标题
 @param waitTitle 倒计时过程中显示的标题
 */
- (void)scf_countDownTime:(NSInteger)timeout title:(NSString *)title waitTitle:(NSString *)waitTitle;

@end
