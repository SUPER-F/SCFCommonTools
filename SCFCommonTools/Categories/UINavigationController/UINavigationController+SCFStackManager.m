//
//  UINavigationController+SCFStackManager.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/27.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UINavigationController+SCFStackManager.h"

@implementation UINavigationController (SCFStackManager)

- (UIViewController *)findViewControllerWithClassName:(NSString *)className {
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(className)]) {
            return viewController;
        }
    }
    
    return nil;
}

- (UIViewController *)rootViewController {
    if (self.viewControllers && self.viewControllers.count > 0) {
        return [self.viewControllers firstObject];
    }
    
    return nil;
}

- (BOOL)isOnlyContainRootViewController {
    if (self.viewControllers && self.viewControllers.count == 1) {
        return YES;
    }
    return NO;
}

- (NSArray *)popToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated {
    return [self popToViewController:[self findViewControllerWithClassName:className] animated:animated];
}

- (NSArray *)popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated {
    NSInteger viewControllersCount = self.viewControllers.count;
    if (viewControllersCount > level) {
        NSInteger inx = viewControllersCount - level - 1;
        UIViewController *viewController = self.viewControllers[inx];
        return [self popToViewController:viewController animated:animated];
    }
    else {
        return [self popToRootViewControllerAnimated:animated];
    }
}

@end
