//
//  UILabel+SCFAutoSize.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/26.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UILabel+SCFAutoSize.h"

@implementation UILabel (SCFAutoSize)

- (UILabel *)labelAutoSizeHorizontal {
    return [self labelAutoSizeHorizontalWithMinWidth:0.0f];
}

- (UILabel *)labelAutoSizeVertical {
    return [self labelAutoSizeVerticalWithMinHeight:0.0f];
}

- (UILabel *)labelAutoSizeHorizontalWithMinWidth:(CGFloat)minWidth {
    CGRect newFrame = self.frame;
    CGSize constrainedSize = CGSizeMake(CGFLOAT_MAX, newFrame.size.height);
    NSString *text = self.text;
    UIFont *font = self.font;
    CGSize size = CGSizeZero;
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName : font,
                                     NSParagraphStyleAttributeName : paragraphStyle.copy,
                                     };
        size = [text boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }
    else {
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED <= 60000)
        size = [text sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:NSLineBreakByWordWrapping];
#endif
    }
    
    newFrame.size.width = ceilf(size.width);
    if (minWidth > 0) {
        newFrame.size.width = newFrame.size.width < minWidth ? minWidth : newFrame.size.width;
    }
    self.frame = newFrame;
    
    return self;
}

- (UILabel *)labelAutoSizeVerticalWithMinHeight:(CGFloat)minHeight {
    CGRect newFrame = self.frame;
    CGSize constrainedSize = CGSizeMake(newFrame.size.width, CGFLOAT_MAX);
    NSString *text = self.text;
    UIFont *font = self.font;
    CGSize size = CGSizeZero;
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font,
                                     NSParagraphStyleAttributeName:paragraphStyle.copy,
                                     };
        size = [text boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }
    else{
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED <= 60000)
        size = [text sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:NSLineBreakByWordWrapping];
#endif
    }
    newFrame.size.height = ceilf(size.height);
    if(minHeight > 0){
        newFrame.size.height = newFrame.size.height < minHeight ? minHeight : newFrame.size.height;
    }
    self.frame = newFrame;
    
    return self;
}

@end
