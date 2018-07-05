//
//  NSString+SCFString.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/4.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <Foundation/Foundation.h>

@interface NSString (SCFString)

//是否是空
+ (BOOL)isEmpty:(NSString*)string;

//判断两个字符串是否相等
+ (BOOL)isString:(NSString*)s1 equalToString:(NSString*)s2;

//字符串是否包含emoji表情
+ (BOOL)isContainsEmojiFromString:(NSString *)string;

/**
 *  中文和中文符号算2个，英文和英文符号算1个，空格算1个
 *
 *  @param strtemp 字符串
 *
 *  @return 长度
 */
+ (NSUInteger)stringLenght:(NSString*)strtemp;

//字符串倒序
+ (NSString *)stringReverseWithString:(NSString *)strtemp;

@end
