//
//  NSData+SCFEncrypt.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/6.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//
//  原代码：https://github.com/shaojiankui/scfCategories
//  加密解密工具 http://tool.chacuo.net/cryptdes
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (SCFEncrypt)

/**
 *  利用AES加密数据
 *
 *  @param key  key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
 *  @param iv  iv description 偏移量
 *
 *  @return data
 */
- (NSData *)scf_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  @brief  利用AES解密据
 *
 *  @param key key 长度一般为16 （AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
 *  @param iv  iv
 *
 *  @return 解密后数据
 */
- (NSData *)scf_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  利用DES加密数据
 *
 *  @param key key 长度一般为8
 *  @param iv  iv description  偏移量
 *
 *  @return data
 */
- (NSData *)scf_encryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  @brief   利用DES解密数据
 *
 *  @param key key 长度一般为8
 *  @param iv  iv
 *
 *  @return 解密后数据
 */
- (NSData *)scf_decryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  利用3DES加密数据
 *
 *  @param key key 长度一般为24
 *  @param iv  iv description  偏移量
 *
 *  @return data
 */
- (NSData *)scf_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  @brief   利用3DES解密数据
 *
 *  @param key key 长度一般为24
 *  @param iv  iv
 *
 *  @return 解密后数据
 */
- (NSData *)scf_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;


- (NSData *)scf_CCCryptData:(NSData *)data
                 algorithm:(CCAlgorithm)algorithm
                 operation:(CCOperation)operation
                       key:(NSString *)key
                        iv:(NSData *)iv;

/**
 *  @brief  NSData 转成UTF8 字符串
 *
 *  @return 转成UTF8 字符串
 */
- (NSString *)scf_UTF8String;

@end
