//
//  NSString+SCFMD5.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/4.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "NSString+SCFMD5.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (SCFMD5)

+ (NSString *)md5StringWithOriginalString:(NSString *)originalStr {
    const char *string = originalStr.UTF8String;
    CC_LONG length = (CC_LONG)strlen(string);
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    CC_MD5_Update(&md5, string, length);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(bytes, &md5);
    
    return [NSString p_stringFromBytes:bytes length:length];
}

- (NSString *)md5String {
    const char *string = self.UTF8String;
    CC_LONG length = (CC_LONG)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [NSString p_stringFromBytes:bytes length:length];
}

#pragma mark - private methods
+ (NSString *)p_stringFromBytes:(unsigned char *)bytes length:(NSUInteger)length {
    NSMutableString *mutableString = [NSMutableString string];
    for (NSInteger i = 0; i < length; i++) {
        [mutableString appendFormat:@"%02x", bytes[i]];
    }
    return mutableString.copy;
}

@end
