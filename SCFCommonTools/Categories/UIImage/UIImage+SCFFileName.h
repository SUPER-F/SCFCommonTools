//
//  UIImage+SCFFileName.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/22.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIImage (SCFFileName)


/**
 根据 main bundle 中的文件名读取图片

 @param name 图片名
 @return 无缓存的图片
 */
+ (UIImage *)scf_imageWithMainBundleFileName:(NSString *)name;


/**
 根据指定 bundle 中的文件名读取图片

 @param name 图片名
 @param bundle 指定 bundle
 @return 无缓存的图片
 */
+ (UIImage *)scf_imageWithFileName:(NSString *)name inBundle:(NSBundle *)bundle;

@end
