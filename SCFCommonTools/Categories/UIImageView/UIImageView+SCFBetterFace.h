//
//  UIImageView+SCFBetterFace.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/26.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//
// https://github.com/croath/UIImageView-BetterFace
//  a UIImageView category to let the picture-cutting with faces showing better

#import <UIKit/UIKit.h>

@interface UIImageView (SCFBetterFace)

@property (nonatomic) BOOL scf_needsBetterFace;
@property (nonatomic) BOOL scf_fast;

void scf_hack_uiimageview_bf(void);

- (void)scf_setBetterFaceImage:(UIImage *)image;

@end
