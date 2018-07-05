//
//  NSString+SCFPinYin.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/4.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "NSString+SCFPinYin.h"

@implementation NSString (SCFPinYin)

- (NSString*)pinyinWithPhoneticSymbol {
    NSMutableString *pinyin = [NSMutableString stringWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformMandarinLatin, NO);
    return pinyin;
}

- (NSString*)pinyin {
    NSMutableString *pinyin = [NSMutableString stringWithString:[self pinyinWithPhoneticSymbol]];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformStripCombiningMarks, NO);
    return pinyin;
}

- (NSArray*)pinyinArray {
    NSArray *array = [[self pinyin] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return array;
}

- (NSString*)pinyinWithoutBlank {
    NSMutableString *string = [NSMutableString stringWithString:@""];
    for (NSString *str in [self pinyinArray]) {
        [string appendString:str];
    }
    return string;
}

- (NSArray*)pinyinInitialsArray {
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in [self pinyinArray]) {
        if ([str length] > 0) {
            [array addObject:[str substringToIndex:1]];
        }
    }
    return array;
}

- (NSString*)pinyinInitialsString {
    NSMutableString *pinyin = [NSMutableString stringWithString:@""];
    for (NSString *str in [self pinyinArray]) {
        if ([str length] > 0) {
            [pinyin appendString:[str substringToIndex:1]];
        }
    }
    return pinyin;
}

@end
