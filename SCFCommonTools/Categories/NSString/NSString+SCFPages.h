//
//  NSString+SCFPages.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/5.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SCFPages)


/**
 根据字符串进行分页

 @param string 需要分页的字符串
 @param font 你想要显示的字体大小，这个要保持统一
 @param rect 你想要在多大的窗口显示
 @return 返回一个数组，数组的元素是NSRange，根据NSRange来进行截取字符串
 */
- (NSArray *)getPagesFromString:(NSString *)string withFont:(UIFont *)font inRect:(CGRect)rect;

@end
