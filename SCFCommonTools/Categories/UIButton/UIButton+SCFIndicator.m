//
//  UIButton+SCFIndicator.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/20.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIButton+SCFIndicator.h"
#import <objc/runtime.h>

static NSString *const buttonTextKey = @"buttonTextKey";
static NSString *const indicatorViewKey = @"indicatorViewKey";

@implementation UIButton (SCFIndicator)

- (void)showIndicator {
    //创建活动指示器
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    [indicator startAnimating];
    
    // 获取当前按钮显示内容
    NSString *currentButtonText = self.titleLabel.text;
    
    // 用runtime关联属性值
    objc_setAssociatedObject(self, &buttonTextKey, currentButtonText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &indicatorViewKey, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 置空按钮显示内容
    [self setTitle:@"" forState:UIControlStateNormal];
    // 禁止按钮点击
    self.enabled = NO;
    [self addSubview:indicator];
}

- (void)hideIndicator {
    NSString *currentButtonText = (NSString *)objc_getAssociatedObject(self, &buttonTextKey);
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)objc_getAssociatedObject(self, &indicatorViewKey);
    
    // 移除活动指示器
    [indicator removeFromSuperview];
    // 重置按钮显示内容
    [self setTitle:currentButtonText forState:UIControlStateNormal];
    // 开启按钮点击
    self.enabled = YES;
}

@end
