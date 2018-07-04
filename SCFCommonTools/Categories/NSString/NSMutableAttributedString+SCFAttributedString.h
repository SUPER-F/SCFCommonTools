//
//  NSMutableAttributedString+SCFAttributedString.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/3.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableDictionary (SCFDictionary)

/*
 *【利用链式编程去实现富文本属性的赋值】
 * @param headerUrl    字体 & 颜色
 */
- (NSMutableDictionary *(^)(CGFloat))Font;
- (NSMutableDictionary *(^)(UIColor *))Color;

@end

@interface NSMutableAttributedString (SCFAttributedString)

/*
 *【快速创建属性字符串】
 * @param string  字符串
 * @param block   返回attributes
 */
+ (NSMutableAttributedString *)scf_makeAttributeString:(NSString *)string Attribute:(void(^)(NSMutableDictionary * attributes))block;

/*
 *【拼接属性字符串】
 * @param string  字符串
 * @param block   返回attributes
 */
- (NSMutableAttributedString *)scf_makeAttributeStringAdd:(NSString *)string Attribute:(void(^)(NSMutableDictionary * attributes))block;

//--------------------------- 【示例】 ------------------------------//
//

/*
 - (void)attributedString
 {
 //【常用方式】
 NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"我是帅锅的帅锅的人"];
 [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:NSMakeRange(2, 2)];
 [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, 2)];
 //    testLabel.attributedText = AttributedStr;
 
 //【封装工具类】
 NSMutableAttributedString * testAS = [NSMutableAttributedString makeAttributeString:@"直接创建" Attribute:^(NSMutableDictionary *attributes) {
 attributes.Font(24).Color([UIColor yellowColor]);
 }];
 [testAS makeAttributeStringAdd:@"拼接新的文字" Attribute:^(NSMutableDictionary *attributes) {
 attributes.Font(12).Color([UIColor redColor]);
 }];
 testLabel.attributedText = testAS;
 }
 */

@end
