//
//  NSString+SCFHash.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/4.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <Foundation/Foundation.h>

@interface NSString (SCFHash)

- (NSString *)scf_sha1String;

- (NSString *)scf_sha256String;

- (NSString *)scf_sha512String;

- (NSString *)scf_hmacSHA1StringWithKey:(NSString *)key;

- (NSString *)scf_hmacSHA256StringWithKey:(NSString *)key;

- (NSString *)scf_hmacSHA512StringWithKey:(NSString *)key;

@end
