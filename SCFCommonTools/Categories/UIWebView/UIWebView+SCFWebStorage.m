//
//  UIWebView+SCFWebStorage.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/3.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIWebView+SCFWebStorage.h"

static NSString * const scf_kLocalStorageName = @"localStorage";
static NSString * const scf_kSessionStorageName = @"sessionStorage";

@implementation UIWebView (SCFWebStorage)

#pragma mark - Local Storage

- (void)scf_setLocalStorageString:(NSString *)string forKey:(NSString *)key {
    [self p_scf_setString:string forKey:key storage:scf_kLocalStorageName];
}

- (NSString *)scf_localStorageStringForKey:(NSString *)key {
    return [self p_scf_stringForKey:key storage:scf_kLocalStorageName];
}

- (void)scf_removeLocalStorageStringForKey:(NSString *)key {
    [self p_scf_removeStringForKey:key storage:scf_kLocalStorageName];
}

- (void)scf_clearLocalStorage {
    [self p_scf_clearWithStorage:scf_kLocalStorageName];
}

#pragma mark - Session Storage

- (void)scf_setSessionStorageString:(NSString *)string forKey:(NSString *)key {
    [self p_scf_setString:string forKey:key storage:scf_kSessionStorageName];
}

- (NSString *)scf_sessionStorageStringForKey:(NSString *)key {
    return [self p_scf_stringForKey:key storage:scf_kSessionStorageName];
}

- (void)scf_removeSessionStorageStringForKey:(NSString *)key {
    [self p_scf_removeStringForKey:key storage:scf_kSessionStorageName];
}

- (void)scf_clearSessionStorage {
    [self p_scf_clearWithStorage:scf_kSessionStorageName];
}

#pragma mark - Helpers

- (void)p_scf_setString:(NSString *)string forKey:(NSString *)key storage:(NSString *)storage {
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.setItem('%@', '%@');", storage, key, string]];
}

- (NSString *)p_scf_stringForKey:(NSString *)key storage:(NSString *)storage {
    return [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.getItem('%@');", storage, key]];
}

- (void)p_scf_removeStringForKey:(NSString *)key storage:(NSString *)storage {
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.removeItem('%@');", storage, key]];
}

- (void)p_scf_clearWithStorage:(NSString *)storage {
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.clear();", storage]];
}

@end
