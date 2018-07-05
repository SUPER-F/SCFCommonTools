//
//  NSString+SCFSize.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/5.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "NSString+SCFSize.h"

@implementation NSString (SCFSize)

- (CGFloat)scf_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width {
    CGSize textSize = [self scf_sizeWithFont:font constrainedToWidth:width];
    return textSize.height;
}

- (CGFloat)scf_widthWithFont:(UIFont *)font constrainedToWidth:(CGFloat)height {
    CGSize textSize = [self scf_sizeWithFont:font constrainedToHeight:height];
    return textSize.width;
}

- (CGSize)scf_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width {
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName : textFont,
                                 NSParagraphStyleAttributeName : paragraph,
                                 };
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                               attributes:attributes
                                  context:nil].size;
    
    return textSize;
}

- (CGSize)scf_sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height {
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName : textFont,
                                 NSParagraphStyleAttributeName : paragraph,
                                 };
    textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                               attributes:attributes
                                  context:nil].size;
    
    return textSize;
}

@end
