//
//  UIImage+SCFMerge.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/22.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIImage (SCFMerge)


/**
 合并两个图片

 @param firstImage 第一个图片
 @param secondImage 第二个图片
 @return 合并后的图片
 */
+ (UIImage *)imageMergeImage:(UIImage *)firstImage withImage:(UIImage *)secondImage;

@end
