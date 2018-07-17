//
//  NSString+SCFBase64.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/4.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <Foundation/Foundation.h>

@interface NSString (SCFBase64)

+ (NSString *)base64EncodedStringFromString:(NSString *)fromString;

+ (NSString *)stringFromBase64EncodedString:(NSString *)base64String;

@end
