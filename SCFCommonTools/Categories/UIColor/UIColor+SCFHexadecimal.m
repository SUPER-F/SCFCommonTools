//
//  UIColor+SCFHexadecimal.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/20.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIColor+SCFHexadecimal.h"

@implementation UIColor (SCFHexadecimal)

+ (UIColor *)colorWithHex:(UInt32)hex {
    return [UIColor colorWithHex:hex alpha:1.0];
}

+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((hex >> 16) & 0xFF) / 255.0
                           green:((hex >> 8) & 0xFF) / 255.0
                            blue:(hex & 0xFF) / 255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    CGFloat alpha, red, green, blue;
    
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    switch ([colorString length]) {
        case 3:  // #RGB
            alpha = 1.0f;
            red = [UIColor colorCompoentFromHexString:colorString start:0 length:1];
            green = [UIColor colorCompoentFromHexString:colorString start:1 length:1];
            blue = [UIColor colorCompoentFromHexString:colorString start:2 length:1];
            break;
            
        case 4:  // #ARGB
            alpha = [UIColor colorCompoentFromHexString:colorString start:0 length:1];
            red = [UIColor colorCompoentFromHexString:colorString start:1 length:1];
            green = [UIColor colorCompoentFromHexString:colorString start:2 length:1];
            blue = [UIColor colorCompoentFromHexString:colorString start:3 length:1];
            break;
            
        case 6:  // #RRGGBB
            alpha = 1.0f;
            red = [UIColor colorCompoentFromHexString:colorString start:0 length:2];
            green = [UIColor colorCompoentFromHexString:colorString start:2 length:2];
            blue = [UIColor colorCompoentFromHexString:colorString start:4 length:2];
            break;
            
        case 8:  // #AARRGGBB
            alpha = [UIColor colorCompoentFromHexString:colorString start:0 length:2];
            red = [UIColor colorCompoentFromHexString:colorString start:2 length:2];
            green = [UIColor colorCompoentFromHexString:colorString start:4 length:2];
            blue = [UIColor colorCompoentFromHexString:colorString start:6 length:2];
            break;
            
        default:
            return nil;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (NSString *)hexString {
    UIColor *color = self;
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    return [NSString stringWithFormat:@"#%02X%02X%02X",
            (int)((CGColorGetComponents(color.CGColor))[0] * 255.0),
            (int)((CGColorGetComponents(color.CGColor))[1] * 255.0),
            (int)((CGColorGetComponents(color.CGColor))[2] * 255.0)];
}

#pragma mark private methods
+ (CGFloat)colorCompoentFromHexString:(NSString *)hexString start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [hexString substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
    
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    
    return hexComponent / 255.0;
}

@end
