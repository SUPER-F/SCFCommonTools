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
- (NSString *)stringByTrimmingHTML;

// 清除HTML标签和JS脚本
- (NSString *)stringByTrimmingHTMLAndScript;

// 清除空格
- (NSString *)stringByTrimmingWhiteSpace;

// 清除空格和空行
- (NSString *)stringByTrimmingWhiteSpaceAndNewlines;

@end
