//
//  NSString+SCFPages.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/5.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "NSString+SCFPages.h"

@implementation NSString (SCFPages)

- (NSArray *)scf_getPagesFromString:(NSString *)string withFont:(UIFont *)font inRect:(CGRect)rect {
    //返回一个数组，包含每一页的字符串开始点和长度(NSRange)
    NSMutableArray *ranges = [NSMutableArray array];
    
    //断行类型，显示字体的行高
    CGFloat lineHeight = [@"Sample样本" boundingRectWithSize:CGSizeZero
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName : font}
                                                   context:nil].size.height;
    NSInteger maxLine = floor(rect.size.height / lineHeight);
    NSInteger totalLines = 0;
    NSString *lastParaLeft = nil;
    NSRange range = NSMakeRange(0, 0);
    //把字符串按段落分开，提高解析效率
    NSArray *paragraphs = [string componentsSeparatedByString:@"\n"];
    
    for (NSInteger p = 0; p < paragraphs.count; p++) {
        NSString *para;
        if (lastParaLeft != nil) {
            //上一页完成后剩下的内容继续计算
            para = lastParaLeft;
            lastParaLeft = nil;
        }
        else {
            para = [paragraphs objectAtIndex:p];
            if (p < paragraphs.count - 1) {
                //刚才分段去掉了一个换行,现在还给它
                para = [para stringByAppendingString:@"\n"];
            }
        }
        
        CGSize paraSize = [para boundingRectWithSize:rect.size
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName : font}
                                             context:nil].size;
        NSInteger paraLines = floor(paraSize.height / lineHeight);
        if (totalLines + paraLines < maxLine) {
            totalLines += paraLines;
            range.length += para.length;
            if (p == paragraphs.count - 1) {
                //到了文章的结尾，这一页也算
                [ranges addObject:[NSValue valueWithRange:range]];
            }
        }
        else if (totalLines + paraLines == maxLine) {
            //很幸运, 刚好一段结束,本页也结束, 有这个判断会提高一定的效率
            range.length += para.length;
            [ranges addObject:[NSValue valueWithRange:range]];
            range.location += range.length;
            range.length = 0;
            totalLines = 0;
        }
        else {
            //重头戏, 页结束时候本段文字还有剩余
            NSInteger lineLeft = maxLine - totalLines;
            CGSize tmpSize;
            NSInteger i;
            for (i = 1; i < para.length; i++) {
                //逐字判断是否达到了本页最大容量
                NSString *tmp = [para substringToIndex:i];
                tmpSize = [tmp boundingRectWithSize:rect.size
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName : font}
                                            context:nil].size;
                NSInteger nowLine = floor(tmpSize.height / lineHeight);
                if (lineLeft < nowLine) {
                    //超出容量,跳出, 字符要回退一个, 应为当前字符已经超出范围了
                    lastParaLeft = [para substringFromIndex:i - 1];
                    break;
                }
            }
            range.length += i - 1;
            [ranges addObject:[NSValue valueWithRange:range]];
            range.location += range.length;
            range.length = 0;
            totalLines = 0;
            p--;
        }
    }
    
    return [NSArray arrayWithArray:ranges];
}

@end
