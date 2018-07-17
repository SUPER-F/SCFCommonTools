//
//  NSData+SCFEncrypt.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/6.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "NSData+SCFEncrypt.h"

@implementation NSData (SCFEncrypt)

static void FixKeyLengths(CCAlgorithm algorithm, NSMutableData * keyData, NSMutableData * ivData) {
    NSUInteger keyLength = [keyData length];
    switch ( algorithm ) {
        case kCCAlgorithmAES128: {
            if (keyLength <= 16) {
                [keyData setLength:16];
            }
            else if (keyLength > 16 && keyLength <= 24) {
                [keyData setLength:24];
            }
            else {
                [keyData setLength:32];
            }
            
            break;
        }
            
        case kCCAlgorithmDES: {
            [keyData setLength:8];
            break;
        }
            
        case kCCAlgorithm3DES: {
            [keyData setLength:24];
            break;
        }
            
        case kCCAlgorithmCAST: {
            if (keyLength < 5) {
                [keyData setLength:5];
            }
            else if ( keyLength > 16) {
                [keyData setLength:16];
            }
            
            break;
        }
            
        case kCCAlgorithmRC4: {
            if ( keyLength > 512)
                [keyData setLength:512];
            break;
        }
            
        default:
            break;
    }
    
    [ivData setLength:[keyData length]];
}

/**
 *  利用AES加密数据
 *
 *  @param key key
 *  @param iv  iv description
 *
 *  @return data
 */
- (NSData*)encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    return [self CCCryptData:self algorithm:kCCAlgorithmAES128 operation:kCCEncrypt key:key iv:iv];
}

/**
 *  @brief  利用AES解密据
 *
 *  @param key key
 *  @param iv  iv
 *
 *  @return 解密后数据
 */
- (NSData*)decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    return [self CCCryptData:self algorithm:kCCAlgorithmAES128 operation:kCCDecrypt key:key iv:iv];
}

/**
 *  利用3DES加密数据
 *
 *  @param key key
 *  @param iv  iv description
 *
 *  @return data
 */
- (NSData*)encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    return [self CCCryptData:self algorithm:kCCAlgorithm3DES operation:kCCEncrypt key:key iv:iv];
}

/**
 *  @brief   利用3DES解密数据
 *
 *  @param key key
 *  @param iv  iv
 *
 *  @return 解密后数据
 */
- (NSData*)decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    return [self CCCryptData:self algorithm:kCCAlgorithm3DES operation:kCCDecrypt key:key iv:iv];
}

/**
 *  利用DES加密数据
 *
 *  @param key key
 *  @param iv  iv description
 *
 *  @return data
 */
- (NSData *)encryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv{
    return [self CCCryptData:self algorithm:kCCAlgorithmDES operation:kCCEncrypt key:key iv:iv];
}

/**
 *  @brief   利用DES解密数据
 *
 *  @param key key
 *  @param iv  iv
 *
 *  @return 解密后数据
 */
- (NSData *)decryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv{
    return [self CCCryptData:self algorithm:kCCAlgorithmDES operation:kCCDecrypt key:key iv:iv];
}

- (NSData *)CCCryptData:(NSData *)data
                 algorithm:(CCAlgorithm)algorithm
                 operation:(CCOperation)operation
                       key:(NSString *)key
                        iv:(NSData *)iv {
    NSMutableData *keyData = [[key dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    NSMutableData *ivData = [iv mutableCopy];
    
    size_t dataMoved;
    
    int size = 0;
    if (algorithm == kCCAlgorithmAES128
        || algorithm == kCCAlgorithmAES) {
        size = kCCBlockSizeAES128;
    }
    else if (algorithm == kCCAlgorithmDES) {
        size = kCCBlockSizeDES;
    }
    else if (algorithm == kCCAlgorithm3DES) {
        size = kCCBlockSize3DES;
    }
    else if (algorithm == kCCAlgorithmCAST) {
        size = kCCBlockSizeCAST;
    }
    
    NSMutableData *decryptedData = [NSMutableData dataWithLength:data.length + size];
    
    int option = kCCOptionPKCS7Padding | kCCOptionECBMode;
    if (iv) {
        option = kCCOptionPKCS7Padding;
    }
    FixKeyLengths(algorithm, keyData, ivData);
    CCCryptorStatus result = CCCrypt(operation,                    // kCCEncrypt or kCCDecrypt
                                     algorithm,
                                     option,                        // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     iv.bytes,
                                     data.bytes,
                                     data.length,
                                     decryptedData.mutableBytes,    // encrypted data out
                                     decryptedData.length,
                                     &dataMoved);                   // total data moved
    
    if (result == kCCSuccess) {
        decryptedData.length = dataMoved;
        return decryptedData;
    }
    return nil;
}

/**
 *  @brief  NSData 转成UTF8 字符串
 *
 *  @return 转成UTF8 字符串
 */
-(NSString *)UTF8String{
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

@end
