//
//  NSDictionary+SCFURLParameters.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/5.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SCFURLParameters)


/**
 将url参数转换成NSDictionary

 @param urlString 待有参数的URL
 @return 参数字典
 */
+ (NSDictionary *)dictionaryWithURLString:(NSString *)urlString;


/**
 将NSDictionary转换成url 参数字符串

 @return URL参数字符串
 */
- (NSString *)urlParametersString;

@end
