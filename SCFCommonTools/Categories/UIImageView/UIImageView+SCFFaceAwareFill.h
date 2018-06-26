//
//  UIImageView+SCFFaceAwareFill.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/26.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//
//  https://github.com/Julioacarrettoni/UIImageView_FaceAwareFill
// This category applies Aspect Fill content mode to an image and if faces are detected it centers them instead of centering the image just by its geometrical center.


#import <UIKit/UIKit.h>

@interface UIImageView (SCFFaceAwareFill)

//要求图像执行"Aspect Fill"“相位填充”，但将图像以被检测的人脸为中心
//不是图像的简单中心
- (void)scf_faceAwareFill;

@end
