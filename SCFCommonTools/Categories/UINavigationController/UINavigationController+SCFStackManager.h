//
//  UINavigationController+SCFStackManager.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/27.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UINavigationController (SCFStackManager)


/**
 寻找某个viewcontroller对象

 @param className viewcontroller名称
 @return viewcontroller对象
 */
- (UIViewController *)scf_findViewControllerWithClassName:(NSString *)className;


/**
 naigation中的根viewcontroller

 @return 根viewcontroller
 */
- (UIViewController *)scf_rootViewController;


/**
 判断是否只有一个RootViewController

 @return 判断结果
 */
- (BOOL)scf_isOnlyContainRootViewController;


/**
 返回指定的viewcontroller

 @param className 指定viewcontroller名称
 @param animated 是否动画
 @return pop之后的viewcontrollers
 */
- (NSArray *)scf_popToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated;


/**
 返回 n 层

 @param level n层
 @param animated 是否动画
 @return pop之后的viewcontrollers
 */
- (NSArray *)scf_popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated;

@end
