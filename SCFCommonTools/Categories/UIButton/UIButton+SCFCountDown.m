//
//  UIButton+SCFCountDown.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/20.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIButton+SCFCountDown.h"

@implementation UIButton (SCFCountDown)

- (void)scf_countDownTime:(NSInteger)timeout title:(NSString *)title waitTitle:(NSString *)waitTitle {
    __block NSInteger time = timeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if (time <= 0) {
            //倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //根据自己需求，设置按钮显示内容
                [self setTitle:title forState:UIControlStateNormal];
                //打开按钮可点击属性
                self.userInteractionEnabled = YES;
            });
        }
        else {
            int seconds = time % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //根据自己需求，设置按钮显示内容
                [self setTitle:[NSString stringWithFormat:@"%@%@", strTime, waitTitle] forState:UIControlStateNormal];
                //关闭按钮可点击属性
                self.userInteractionEnabled = NO;
            });
            //倒计时时间自减
            time--;
        }
    });
    dispatch_resume(timer);
}

@end
