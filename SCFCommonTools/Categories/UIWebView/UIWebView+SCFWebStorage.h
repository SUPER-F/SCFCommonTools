//
//  UIWebView+SCFWebStorage.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/3.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIWebView (SCFWebStorage)

#pragma mark - Local Storage

- (void)scf_setLocalStorageString:(NSString *)string forKey:(NSString *)key;

- (NSString *)scf_localStorageStringForKey:(NSString *)key;

- (void)scf_removeLocalStorageStringForKey:(NSString *)key;

- (void)scf_clearLocalStorage;

#pragma mark - Session Storage

- (void)scf_setSessionStorageString:(NSString *)string forKey:(NSString *)key;

- (NSString *)scf_sessionStorageStringForKey:(NSString *)key;

- (void)scf_removeSessionStorageStringForKey:(NSString *)key;

- (void)scf_clearSessionStorage;

@end
