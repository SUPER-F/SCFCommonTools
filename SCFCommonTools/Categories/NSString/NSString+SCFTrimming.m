//
//  NSString+SCFTrimming.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/5.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "NSString+SCFTrimming.h"

@implementation NSString (SCFTrimming)

- (NSString *)stringByTrimmingHTML {
    return [self stringByReplacingOccurrencesOfString:@"<[^>]+>"
                                           withString:@""
                                              options:NSRegularExpressionSearch
                                                range:NSMakeRange(0, self.length)];
}

- (NSString *)stringByTrimmingHTMLAndScript {
    NSMutableString *mtbString = [self mutableCopy];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"<script[^>]*>[\\w\\W]*</script>"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    NSArray *matches = [regex matchesInString:mtbString
                                      options:NSMatchingReportProgress
                                        range:NSMakeRange(0, mtbString.length)];
    for (NSTextCheckingResult *match in [matches reverseObjectEnumerator]) {
        [mtbString replaceCharactersInRange:match.range withString:@""];
    }
    return [mtbString stringByTrimmingHTML];
}

- (NSString *)stringByTrimmingWhiteSpace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)stringByTrimmingWhiteSpaceAndNewlines {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
