//
//  UINavigationController+SCFAnimationTransition.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/27.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UINavigationController+SCFAnimationTransition.h"

@implementation UINavigationController (SCFAnimationTransition)

- (void)scf_pushViewController:(UIViewController *)viewController withAnimationTransition:(UIViewAnimationTransition)animationTransition {
    [UIView beginAnimations:nil context:NULL];
    [self pushViewController:viewController animated:NO];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:animationTransition forView:self.view cache:YES];
    [UIView commitAnimations];
}

- (UIViewController *)scf_popViewControllerWithAnimationTransition:(UIViewAnimationTransition)animationTransition {
    [UIView beginAnimations:nil context:NULL];
    UIViewController *controller = [self popViewControllerAnimated:NO];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:animationTransition forView:self.view cache:YES];
    [UIView commitAnimations];
    return controller;
}

@end
