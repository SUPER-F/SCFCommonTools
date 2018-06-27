//
//  UINavigationController+SCFAnimationTransition.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/27.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UINavigationController (SCFAnimationTransition)


/**
 自定义转场动画push页面

 @param viewController push到的viewcontroller
 @param animationTransition 转场动画
 */
- (void)scf_pushViewController:(UIViewController *)viewController withAnimationTransition:(UIViewAnimationTransition)animationTransition;


/**
 自定义转场动画pop页面

 @param animationTransition 转场动画
 @return pop到的viewcontroller
 */
- (UIViewController *)scf_popViewControllerWithAnimationTransition:(UIViewAnimationTransition)animationTransition;

@end
