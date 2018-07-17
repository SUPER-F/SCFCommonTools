//
//  UIImage+SCFMerge.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/22.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIImage+SCFMerge.h"

@implementation UIImage (SCFMerge)

+ (UIImage *)imageMergeImage:(UIImage *)firstImage withImage:(UIImage *)secondImage {
    CGImageRef firstImageRef = firstImage.CGImage;
    CGFloat firstWidth = CGImageGetWidth(firstImageRef);
    CGFloat firstHeight = CGImageGetHeight(firstImageRef);
    
    CGImageRef secondImageRef = secondImage.CGImage;
    CGFloat secondWidth = CGImageGetWidth(secondImageRef);
    CGFloat secondHeight = CGImageGetHeight(secondImageRef);
    
    CGSize mergeSize = CGSizeMake(MAX(firstWidth, secondWidth), MAX(firstHeight, secondHeight));
    
    UIGraphicsBeginImageContext(mergeSize);
    [firstImage drawInRect:CGRectMake(0.0f, 0.0f, firstWidth, firstHeight)];
    [secondImage drawInRect:CGRectMake(0.0f, 0.0f, secondWidth, secondHeight)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
