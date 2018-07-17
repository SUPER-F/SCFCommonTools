//
//  NSData+SCFBase64.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/6.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <Foundation/Foundation.h>

@interface NSData (SCFHash)

- (NSData *)md5Data;

- (NSData *)sha1Data;

- (NSData *)sha256Data;

- (NSData *)sha512Data;


/**
 根据秘钥key 进行md5编码

 @param key 秘钥
 @return md5 Data
 */
- (NSData *)hmacMD5DataWithKey:(NSData *)key;

/**
 根据秘钥key 进行sha1编码
 
 @param key 秘钥
 @return sha1 Data
 */
- (NSData *)hmacSHA1DataWithKey:(NSData *)key;

/**
 根据秘钥key 进行sha256编码
 
 @param key 秘钥
 @return sha256 Data
 */
- (NSData *)hmacSHA256DataWithKey:(NSData *)key;

/**
 根据秘钥key 进行sha512编码
 
 @param key 秘钥
 @return sha512 Data
 */
- (NSData *)hmacSHA512DataWithKey:(NSData *)key;

@end
