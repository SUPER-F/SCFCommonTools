//
//  NSString+SCFHash.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/4.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "NSString+SCFHash.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (SCFHash)

- (NSString *)scf_sha1String {
    const char *string = self.UTF8String;
    CC_LONG length = (CC_LONG)strlen(string);
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(string, length, bytes);
    return [self p_scf_stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)scf_sha256String {
    const char *string = self.UTF8String;
    CC_LONG length = (CC_LONG)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, length, bytes);
    return [self p_scf_stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)scf_sha512String {
    const char *string = self.UTF8String;
    CC_LONG length = (CC_LONG)strlen(string);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(string, length, bytes);
    return [self p_scf_stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)scf_hmacSHA1StringWithKey:(NSString *)key {
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self p_scf_stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

- (NSString *)scf_hmacSHA256StringWithKey:(NSString *)key {
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self p_scf_stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

- (NSString *)scf_hmacSHA512StringWithKey:(NSString *)key {
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA512_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA512, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self p_scf_stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

#pragma mark - private methods
- (NSString *)p_scf_stringFromBytes:(unsigned char *)bytes length:(NSUInteger)length {
    NSMutableString *mutableString = [NSMutableString string];
    for (NSInteger i = 0; i < length; i++) {
        [mutableString appendFormat:@"%02x", bytes[i]];
    }
    return mutableString.copy;
}

@end
