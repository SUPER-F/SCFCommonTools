//
//  NSString+SCFRegex.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/4.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <Foundation/Foundation.h>

@interface NSString (SCFRegex)

/**
 *  手机号码的有效性:分电信、联通、移动和小灵通
 */
- (BOOL)isMobileNumberClassification;

/**
 *  手机号有效性
 */
- (BOOL)isMobileNumber;

/**
 *  邮箱的有效性
 */
- (BOOL)isEmailAddress;

/**
 *  简单的身份证有效性
 *
 */
- (BOOL)simpleVerifyIdentityCardNum;

/**
 *  精确的身份证号码有效性检测
 *
 *  @param value 身份证号
 */
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;

/**
 *  车牌号的有效性
 */
- (BOOL)isCarNumber;

/**
 *  银行卡的有效性
 */
- (BOOL)bankCardluhmCheck;

/**
 *  IP地址有效性
 */
- (BOOL)isIPAddress;

/**
 *  Mac地址有效性
 */
- (BOOL)isMacAddress;

/**
 *  网址有效性
 */
- (BOOL)isValidUrl;

/**
 *  纯汉字
 */
- (BOOL)isValidChinese;

/**
 *  邮政编码
 */
- (BOOL)isValidPostalcode;

/**
 *  工商税号
 */
- (BOOL)isValidTaxNo;

@end
