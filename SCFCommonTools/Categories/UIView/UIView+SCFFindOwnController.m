//
//  UIView+SCFFindOwnController.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/2.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIView+SCFFindOwnController.h"

@implementation UIView (SCFFindOwnController)

- (UIViewController *)scf_findOwnController {
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
