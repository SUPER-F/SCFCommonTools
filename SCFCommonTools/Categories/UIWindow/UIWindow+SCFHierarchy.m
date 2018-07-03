//
//  UIWindow+SCFHierarchy.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/3.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIWindow+SCFHierarchy.h"

@implementation UIWindow (SCFHierarchy)

- (UIViewController*)scf_theTopMostController {
    UIViewController *topController = [self rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController]) {
        topController = [topController presentedViewController];
    }
    
    //  Returning topMost ViewController
    return topController;
}

- (UIViewController*)scf_theCurrentViewController {
    UIViewController *currentViewController = [self scf_theTopMostController];
    
    while (currentViewController) {
        if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            currentViewController = [(UITabBarController*)currentViewController selectedViewController];
        }
        else if ([currentViewController isKindOfClass:[UINavigationController class]]
                 && [(UINavigationController*)currentViewController topViewController]) {
            currentViewController = [(UINavigationController*)currentViewController topViewController];
        }
        else
            break;
    }
    
    return currentViewController;
}

@end
