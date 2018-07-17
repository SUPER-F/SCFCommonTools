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

static NSString * const kLocalStorageName = @"localStorage";
static NSString * const kSessionStorageName = @"sessionStorage";

@implementation UIWebView (SCFWebStorage)

#pragma mark - Local Storage

- (void)setLocalStorageString:(NSString *)string forKey:(NSString *)key {
    [self p_setString:string forKey:key storage:kLocalStorageName];
}

- (NSString *)localStorageStringForKey:(NSString *)key {
    return [self p_stringForKey:key storage:kLocalStorageName];
}

- (void)removeLocalStorageStringForKey:(NSString *)key {
    [self p_removeStringForKey:key storage:kLocalStorageName];
}

- (void)clearLocalStorage {
    [self p_clearWithStorage:kLocalStorageName];
}

#pragma mark - Session Storage

- (void)setSessionStorageString:(NSString *)string forKey:(NSString *)key {
    [self p_setString:string forKey:key storage:kSessionStorageName];
}

- (NSString *)sessionStorageStringForKey:(NSString *)key {
    return [self p_stringForKey:key storage:kSessionStorageName];
}

- (void)removeSessionStorageStringForKey:(NSString *)key {
    [self p_removeStringForKey:key storage:kSessionStorageName];
}

- (void)clearSessionStorage {
    [self p_clearWithStorage:kSessionStorageName];
}

#pragma mark - Helpers

- (void)p_setString:(NSString *)string forKey:(NSString *)key storage:(NSString *)storage {
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.setItem('%@', '%@');", storage, key, string]];
}

- (NSString *)p_stringForKey:(NSString *)key storage:(NSString *)storage {
    return [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.getItem('%@');", storage, key]];
}

- (void)p_removeStringForKey:(NSString *)key storage:(NSString *)storage {
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.removeItem('%@');", storage, key]];
}

- (void)p_clearWithStorage:(NSString *)storage {
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.clear();", storage]];
}

@end
