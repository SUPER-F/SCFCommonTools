//
//  UIBarButtonItem+SCFFactory.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/9.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIBarButtonItem+SCFFactory.h"

//导航栏标题颜色
#define ITEM_TITLE_COLOR [UIColor blackColor]
//导航栏标题字体大小
#define ITEM_TITLE_FONT [UIFont systemFontOfSize:16.0f]
//item最小宽度
#define ITEM_MIN_WIDTH 40.0f
//item最大宽度
#define ITEM_MAX_WIDTH 80.0f
//item高度
#define ITEM_HEIGHT 40.0f
//图片宽度
#define ITEM_IMG_WIDTH 22.0f
//图片高度
#define ITEM_IMG_HEIGHT 22.0f
//图片和文字间距
#define IMG_SPACING_TEXT 6.0f

@implementation UIBarButtonItem (SCFFactory)

+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              image:(UIImage *)image
                          isLeftBar:(BOOL)isLeftBar {
    return [self itemWithTarget:target
                         action:action
                          title:nil
                           font:nil
                     titleColor:nil
               highlightedColor:nil
                     nomalImage:image
               higelightedImage:nil
                  isImageAtLeft:isLeftBar
                      isLeftBar:isLeftBar];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              image:(UIImage *)image
                   highlightedImage:(UIImage *)highlightedImg
                          isLeftBar:(BOOL)isLeftBar {
    return [self itemWithTarget:target
                         action:action
                          title:nil
                           font:nil
                     titleColor:nil
               highlightedColor:nil
                     nomalImage:image
               higelightedImage:highlightedImg
                  isImageAtLeft:isLeftBar
                      isLeftBar:isLeftBar];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              title:(NSString *)title
                          isLeftBar:(BOOL)isLeftBar {
    return [self itemWithTarget:target
                         action:action
                          title:title
                           font:ITEM_TITLE_FONT
                     titleColor:ITEM_TITLE_COLOR
               highlightedColor:nil
                     nomalImage:nil
               higelightedImage:nil
                  isImageAtLeft:isLeftBar
                      isLeftBar:isLeftBar];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              title:(NSString *)title
                               font:(UIFont *)font
                         titleColor:(UIColor *)titleColor
                   highlightedColor:(UIColor *)highlightedColor
                          isLeftBar:(BOOL)isLeftBar {
    return [self itemWithTarget:target
                         action:action
                          title:title
                           font:font
                     titleColor:titleColor
               highlightedColor:highlightedColor
                     nomalImage:nil
               higelightedImage:nil
                  isImageAtLeft:isLeftBar
                      isLeftBar:isLeftBar];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              image:(UIImage *)image
                              title:(NSString*)title
                      isImageAtLeft:(BOOL)isImgAtLeft
                          isLeftBar:(BOOL)isLeftBar {
    return [self itemWithTarget:target
                         action:action
                          title:title
                           font:ITEM_TITLE_FONT
                     titleColor:ITEM_TITLE_COLOR
               highlightedColor:nil
                     nomalImage:image
               higelightedImage:nil
                  isImageAtLeft:isImgAtLeft
                      isLeftBar:isLeftBar];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              title:(NSString *)title
                               font:(UIFont *)font
                         titleColor:(UIColor *)titleColor
                   highlightedColor:(UIColor *)highlightedColor
                         nomalImage:(UIImage *)nomalImage
                   higelightedImage:(UIImage *)higelightedImage
                      isImageAtLeft:(BOOL)isImgAtLeft
                          isLeftBar:(BOOL)isLeftBar {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 默认title的size
    CGSize textSize = CGSizeZero;
    // 默认item的size
    CGSize itemSize = CGSizeZero;
    
    if(nomalImage){
        [button setImage:[self imageScaledToFitSize:nomalImage size:CGSizeMake(ITEM_IMG_WIDTH, ITEM_IMG_HEIGHT)] forState:UIControlStateNormal];
    }
    if (higelightedImage) {
        [button setImage:[self imageScaledToFitSize:higelightedImage size:CGSizeMake(ITEM_IMG_WIDTH, ITEM_IMG_HEIGHT)] forState:UIControlStateHighlighted];
    }
    
    if (title && title.length > 0) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:titleColor ? titleColor : ITEM_TITLE_COLOR forState:UIControlStateNormal];
        [button setTitleColor:highlightedColor ? highlightedColor : ITEM_TITLE_COLOR forState:UIControlStateHighlighted];
        button.titleLabel.font = font ? font : ITEM_TITLE_FONT;
        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        //计算title的size
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByTruncatingTail;
        NSDictionary *attributes = @{NSFontAttributeName : button.titleLabel.font,
                                     NSParagraphStyleAttributeName : paragraph,
                                     };
        textSize = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, ITEM_HEIGHT)
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                    attributes:attributes
                                       context:nil].size;
    }
    
    if ((title && title.length > 0) && (!nomalImage && !higelightedImage)) { //有title，没有图片
        if (textSize.width < ITEM_MIN_WIDTH) {
            textSize = CGSizeMake(ITEM_MIN_WIDTH, ITEM_HEIGHT);
        }
        itemSize = textSize;
    }
    else if ((!title || title.length <= 0) && (nomalImage || higelightedImage)) { //没有title，有图片
        itemSize = CGSizeMake(ITEM_MIN_WIDTH, ITEM_HEIGHT);
    }
    else if ((title && title.length > 0) && (nomalImage || higelightedImage)) { //有title，有图片
        CGFloat itemWidth = ITEM_IMG_WIDTH + textSize.width + IMG_SPACING_TEXT;
        itemSize = CGSizeMake(itemWidth, ITEM_HEIGHT);
        
        if (isImgAtLeft) {  //图片在左侧
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -IMG_SPACING_TEXT / 2.0, 0, IMG_SPACING_TEXT / 2.0);
            button.titleEdgeInsets = UIEdgeInsetsMake(0, IMG_SPACING_TEXT / 2.0, 0, -IMG_SPACING_TEXT / 2.0);
        }
        else {  //图片在右侧
            button.imageEdgeInsets = UIEdgeInsetsMake(0, textSize.width + IMG_SPACING_TEXT / 2.0, 0, -(textSize.width + IMG_SPACING_TEXT / 2.0));
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -(ITEM_IMG_WIDTH + IMG_SPACING_TEXT / 2.0), 0, ITEM_IMG_WIDTH + IMG_SPACING_TEXT / 2.0);
        }
    }
    
    button.bounds = CGRectMake(0, 0, itemSize.width, itemSize.height);
    button.contentHorizontalAlignment = isLeftBar ? UIControlContentHorizontalAlignmentLeft : UIControlContentHorizontalAlignmentRight;
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width {
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = width;
    return fixedSpace;
}

#pragma mark - private methods
+ (UIImage *)imageScaledToSize:(UIImage*)img size:(CGSize)size {
    // avoid redundant drawing
    if (CGSizeEqualToSize(img.size, size)) {
        return img;
    }
    
    // begin drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    // draw
    [img drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    
    // capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // end drawing context
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageScaledToFitSize:(UIImage *)img size:(CGSize)size {
    if (CGSizeEqualToSize(img.size, size)) {
        return img;
    }
    // calculate rect
    CGFloat aspect = img.size.width / img.size.height;
    if (size.width / aspect <= size.height) {
        return [self imageScaledToSize:img size:CGSizeMake(size.width, size.width / aspect)];
    }
    else {
        return [self imageScaledToSize:img size:CGSizeMake(size.height * aspect, size.height)];
    }
}

@end
