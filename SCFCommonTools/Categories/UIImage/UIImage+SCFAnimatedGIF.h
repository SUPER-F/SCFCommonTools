//
//  UIImage+SCFAnimatedGIF.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/21.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIImage (SCFAnimatedGIF)

/*
 使用GIF data 或者 GIF url 创建 animated image
 使用源图像GIF的images，创建一个动画' UIImage '。
 
 GIF为每一帧存储一个单独的持续时间，单位为centiseconds(百分之一秒)。然而，一个“UIImage”只有一个“持续时间”属性，它是一个浮点数。
 
 为了处理这种不匹配，我将每个源图像(从GIF)添加到“animation”中，次数不同，以匹配GIF中帧持续时间之间的比率。
 
 例如，假设GIF包含三个框架。第0帧有持续时间3。第一帧的时间是9。框架2有持续时间15。我将每个持续时间除以所有持续时间的最大公分母，也就是3，然后把每一帧的次数相加。因此，“animation”将包含第0 /3 = 1次，然后第1 /3 = 3次，然后第2 /3 = 5次。我设置的动画。持续时间(3+9+15)/100 = 0.27秒。
 */
+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)theData;

+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)theURL;

#pragma mark - 另外一种实现方式
+ (UIImage *)animatedImageWithGIFData:(NSData *)data;

+ (UIImage *)animatedImageWithGIFNamed:(NSString *)name;

- (UIImage *)animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
