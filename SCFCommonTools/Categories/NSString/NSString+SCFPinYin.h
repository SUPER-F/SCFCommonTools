//
//  NSString+SCFPinYin.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/4.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <Foundation/Foundation.h>

@interface NSString (SCFPinYin)

// 带音标的拼音
- (NSString*)pinyinWithPhoneticSymbol;

// 拼音
- (NSString*)pinyin;

// 拼音数组
- (NSArray*)pinyinArray;

// 没有空格的拼音
- (NSString*)pinyinWithoutBlank;

// 拼音首字母数组
- (NSArray*)pinyinInitialsArray;

// 拼音首字母组成的字符串
- (NSString*)pinyinInitialsString;

@end
