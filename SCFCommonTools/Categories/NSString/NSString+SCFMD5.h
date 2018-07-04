//
//  NSString+SCFMD5.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/4.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <Foundation/Foundation.h>

@interface NSString (SCFMD5)

+ (NSString *)scf_md5StringWithOriginalString:(NSString *)originalStr;

- (NSString *)scf_md5String;

@end
