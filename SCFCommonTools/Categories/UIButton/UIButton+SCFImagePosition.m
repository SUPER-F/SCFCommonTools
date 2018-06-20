//
//  UIButton+SCFImagePosition.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/20.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIButton+SCFImagePosition.h"

@implementation UIButton (SCFImagePosition)

- (void)scf_setImagePosition:(SCFImagePositions)position spacing:(CGFloat)spacing {
    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGFloat labelWidth = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width;
    CGFloat labelHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font].height;
#pragma clang diagnostic pop
    
    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2.0 - imageWidth / 2.0;  //image中心移动的X距离
    CGFloat imageOffsetY = imageHeight / 2.0 + spacing / 2.0;  //image中心移动的Y距离
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2.0) - (imageWidth + labelWidth) / 2.0;  //label中心移动的X距离
    CGFloat labelOffsetY = labelHeight / 2.0 + spacing / 2.0;  //label中心移动的Y距离
    
    switch (position) {
        case SCFImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing / 2.0, 0, spacing / 2.0);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing / 2.0, 0, -spacing / 2.0);
            break;
            
        case SCFImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing / 2.0, 0, -(labelWidth + spacing / 2.0));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing / 2.0), 0, imageWidth + spacing / 2.0);
            break;
            
        case SCFImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            break;
            
        case SCFImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            break;
            
        default:
            break;
    }
}

@end
