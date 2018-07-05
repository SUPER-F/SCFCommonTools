//
//  NSString+SCFValue.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/5.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SCFValue)


/**
 获取字典指定key的NSDictionary对象

 @param aKey key
 @return value值如果为nil或者null，则返回nil
 */
- (NSDictionary *)scf_dictionaryObjectForKey:(NSString *)aKey;


/**
 获取字典指定key的NSArray对象

 @param aKey key
 @return value值如果为nil或者null，则返回nil
 */
- (NSArray *)scf_arrayObjectForKey:(NSString *)aKey;


/**
 获取字典指定key的NSArray对象，数组元素全部为字符串

 @param aKey key
 @return value值如果为nil或者null或者元素不全为字符串，则返回nil
 */
- (NSArray *)scf_arrayStringForKey:(NSString *)aKey;

/**
 获取字典指定key的字符串

 @param aKey key
 @return 如果akey找不到，返回@"" (防止出现nil，使程序崩溃)
 */
- (NSString *)scf_stringForKey:(NSString *)aKey;


/**
 获取字典指定key的字符串

 @param aKey key
 @param defaultValue 为空时的默认值
 @return value值
 */
- (NSString *)scf_stringForKey:(NSString *)aKey defaultValue:(NSString *)defaultValue;


/**
 获取字典指定key的数值字符

 @param aKey key
 @return value值如果为nil或者null会返回0字符串
 */
- (NSString *)scf_numberStringForKey:(NSString *)aKey;


/**
 获取字典指定key的字符串,把&nbsp;替换为空格

 @param aKey key
 @return 替换后的value值
 */
- (NSString *)scf_stringByReplaceNBSPForKey:(NSString *)aKey;

@end
