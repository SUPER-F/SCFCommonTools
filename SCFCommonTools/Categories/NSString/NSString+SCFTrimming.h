//
//  NSString+SCFTrimming.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/5.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <Foundation/Foundation.h>

@interface NSString (SCFTrimming)

// 清除HTML标签
- (NSString *)scf_stringByTrimmingHTML;

// 清除HTML标签和JS脚本
- (NSString *)scf_stringByTrimmingHTMLAndScript;

// 清除空格
- (NSString *)scf_stringByTrimmingWhiteSpace;

// 清除空格和空行
- (NSString *)scf_stringByTrimmingWhiteSpaceAndNewlines;

@end
