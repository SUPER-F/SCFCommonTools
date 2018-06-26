//
//  UIImageView+SCFAddition.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/25.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIImageView+SCFAddition.h"

@implementation UIImageView (SCFAddition)

+ (UIImageView *)scf_imageViewWithImageNamed:(NSString *)imageName {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
}

+ (UIImageView *)scf_imageViewWithFrame:(CGRect)frame {
    return [[UIImageView alloc] initWithFrame:frame];
}

+ (UIImageView *)scf_imageViewStretchableImageNamed:(NSString *)imageName frame:(CGRect)frame {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
    return imageView;
}

+ (UIImageView *)scf_imageViewWithImageArray:(NSArray *)imageArray duration:(NSTimeInterval)duration {
    if (!imageArray || imageArray.count <= 0) {
        return nil;
    }
    
    UIImageView *imageView = [UIImageView scf_imageViewWithImageNamed:[imageArray firstObject]];
    NSMutableArray *images = [NSMutableArray array];
    for (NSInteger i = 0; i < imageArray.count; i++) {
        UIImage *image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [images addObject:image];
    }
    [imageView setImage:[images firstObject]];
    [imageView setAnimationImages:images];
    [imageView setAnimationDuration:duration];
    [imageView setAnimationRepeatCount:0];
    
    return imageView;
}

- (void)scf_setStretchableImageWithName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    self.image = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
}

#pragma mark - 画水印
- (void)scf_setImage:(UIImage *)image withWaterMarkImage:(UIImage *)markImage inRect:(CGRect)rect {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
        UIGraphicsBeginImageContextWithOptions(self.image.size, NO, 0.0); // 0.0 for scale means "scale for device's main screen".
    }
    // 原图
    [image drawInRect:self.bounds];
    // 水印图
    [markImage drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.image = newImage;
}

- (void)scf_setImage:(UIImage *)image withWaterMarkString:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
        UIGraphicsBeginImageContextWithOptions(self.image.size, NO, 0.0); // 0.0 for scale means "scale for device's main screen".
    }
    // 原图
    [image drawInRect:self.bounds];
    // 文字颜色
    [color set];
    // 水印文字
    if ([markString respondsToSelector:@selector(drawInRect:withAttributes:)]) { // iOS7及以上
        [markString drawInRect:rect withAttributes:@{NSFontAttributeName : font}];
    }
    else {  // iOS7以下
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [markString drawInRect:rect withFont:font];
#pragma clang diagnostic pop
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.image = newImage;
}

- (void)scf_setImage:(UIImage *)image withWaterMarkString:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
        UIGraphicsBeginImageContextWithOptions(self.image.size, NO, 0.0); // 0.0 for scale means "scale for device's main screen".
    }
    // 原图
    [image drawInRect:self.bounds];
    // 文字颜色
    [color set];
    // 水印文字
    if ([markString respondsToSelector:@selector(drawAtPoint:withAttributes:)]) { // iOS7及以上
        [markString drawAtPoint:point withAttributes:@{NSFontAttributeName : font}];
    }
    else {  // iOS7以下
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [markString drawAtPoint:point withFont:font];
#pragma clang diagnostic pop
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.image = newImage;
}

@end
