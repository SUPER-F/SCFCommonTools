//
//  NSString+SCFString.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/4.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "NSString+SCFString.h"

@implementation NSString (SCFString)

+ (BOOL)isEmpty:(NSString *)string {
    if((NSNull*)string == [NSNull null]) {
        return YES;
    }
    
    NSString *newstr;
    if(string){
        newstr = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    if(!newstr || [newstr isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isString:(NSString *)s1 equalToString:(NSString *)s2 {
    if ([NSString isEmpty:s1] && [NSString isEmpty:s2]){
        return YES;
    }
    else if([s1 isEqualToString:s2]){
        return YES;
    }
    return NO;
}

+ (BOOL)isContainsEmojiFromString:(NSString *)string {
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

+ (NSUInteger)stringLenght:(NSString *)strtemp {
    NSUInteger strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (NSUInteger i = 0; i < [strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

+ (NSString *)stringReverseWithString:(NSString *)strtemp {
    NSMutableString *reverseString = [NSMutableString string];
    NSInteger charLength = strtemp.length;
    while (charLength > 0) {
        charLength--;
        NSRange subStrRange = NSMakeRange(charLength, 1);
        [reverseString appendString:[strtemp substringWithRange:subStrRange]];
    }
    return reverseString.copy;
}

@end
