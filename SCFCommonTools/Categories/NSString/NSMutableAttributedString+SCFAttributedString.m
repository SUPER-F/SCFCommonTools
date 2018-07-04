//
//  NSMutableAttributedString+SCFAttributedString.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/3.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "NSMutableAttributedString+SCFAttributedString.h"

@implementation NSMutableDictionary (Dictionary)

/*
 *【利用链式编程去实现富文本属性的赋值】
 * @param headerUrl    字体 & 颜色
 */
- (NSMutableDictionary *(^)(CGFloat))Font {
    return ^id(CGFloat font) {
        [self setValue:[UIFont systemFontOfSize:font] forKey:NSFontAttributeName];
        return self;
    };
}

- (NSMutableDictionary *(^)(UIColor *))Color {
    return ^id(UIColor * color) {
        [self setValue:color forKey:NSForegroundColorAttributeName];
        return self;
    };
}

@end


@implementation NSMutableAttributedString (SCFAttributedString)

/*
 *【快速创建属性字符串】
 * @param string  字符串
 * @param block   返回attributes
 */
+ (NSMutableAttributedString *)scf_makeAttributeString:(NSString *)string Attribute:(void(^)(NSMutableDictionary * attributes))block {
    NSMutableDictionary * attributes = [NSMutableDictionary dictionary];
    block(attributes);
    NSMutableAttributedString * as = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes];
    return as;
}


/*
 *【拼接属性字符串】
 * @param string  字符串
 * @param block   返回attributes
 */
- (NSMutableAttributedString *)scf_makeAttributeStringAdd:(NSString *)string Attribute:(void(^)(NSMutableDictionary * attributes))block {
    NSMutableDictionary * attributes = [NSMutableDictionary dictionary];
    block(attributes);
    NSMutableAttributedString * as = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes];
    [self appendAttributedString:as];
    return self;
}


@end
