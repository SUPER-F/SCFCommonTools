//
//  UIImageView+SCFFaceAwareFill.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/26.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIImageView+SCFFaceAwareFill.h"
#import <CoreImage/CoreImage.h>
#import <QuartzCore/QuartzCore.h>

static CIDetector *_scf_faceDetector;

@implementation UIImageView (SCFFaceAwareFill)

+ (void)initialize {
    _scf_faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyLow}];
}

// based on this: http://maniacdev.com/2011/11/tutorial-easy-face-detection-with-core-image-in-ios-5/
- (void)scf_faceAwareFill {
    if (self.image == nil) {
        return;
    }
    
    CGRect facesRect = [self scf_rectWithFaces];
    if (facesRect.size.height + facesRect.size.width == 0) {
        return;
    }
    
    self.contentMode = UIViewContentModeLeft;
    [self scf_scaleImageFocusingOnRect:facesRect];
}

#pragma mark - private methods
- (CGRect)scf_rectWithFaces {
    // get a CIImage
    CIImage *ciImage = self.image.CIImage;
    
    // 如果没有就创建一个
    if (!ciImage) {
        ciImage = [CIImage imageWithCGImage:self.image.CGImage];
    }
    
    // 使用静态的 CIDetector
    CIDetector *detector = _scf_faceDetector;
    
    // 创建一个包含检测器中所有检测到的face的数组
    NSArray *features = [detector featuresInImage:ciImage];
    
    //我们将遍历每一个检测到的face,CIFaceFeature给我们提供了
    //整个脸的宽度，以及每只眼睛的坐标
    //如果检测到口腔
    CGRect totalFaceRects = CGRectMake(self.image.size.width / 2.0, self.image.size.height / 2.0, 0.0f, 0.0f);
    
    if (features.count > 0) {
        // 获取第一个face的rect
        totalFaceRects = ((CIFaceFeature *)[features firstObject]).bounds;
        
        // 现在我们找到了包含所有face的最小CGRect
        for (CIFaceFeature *feature in features) {
            totalFaceRects = CGRectUnion(totalFaceRects, feature.bounds);
        }
    }
    
    // 返回一个CGRect来控制图像的中心或者所有的face
    return totalFaceRects;
}

- (void)scf_scaleImageFocusingOnRect:(CGRect)facesRect {
    CGFloat multi1 = self.frame.size.width / self.image.size.width;
    CGFloat multi2 = self.frame.size.height / self.image.size.height;
    CGFloat multi = MAX(multi1, multi2);
    
    // 我们需要“翻转”Y坐标，使它与iOS坐标系匹配
    facesRect.origin.y = self.image.size.height - facesRect.origin.y - facesRect.size.height;
    
    facesRect = CGRectMake(facesRect.origin.x * multi, facesRect.origin.y * multi, facesRect.size.width * multi, facesRect.size.height * multi);
    
    CGRect imageRect = CGRectZero;
    imageRect.size.width = self.image.size.width * multi;
    imageRect.size.height = self.image.size.height * multi;
    imageRect.origin.x = MIN(0.0, MAX(-facesRect.origin.x + self.frame.size.width / 2.0 - facesRect.size.width / 2.0, -imageRect.size.width + self.frame.size.width));
    imageRect.origin.y = MIN(0.0, MAX(-facesRect.origin.y + self.frame.size.height / 2.0 - facesRect.size.height / 2.0, -imageRect.size.height + self.frame.size.height));
    
    imageRect = CGRectIntegral(imageRect);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, YES, 2.0);
    [self.image drawInRect:imageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.image = newImage;
    
    // This is to show the red rectangle over the faces
#ifdef DEBUGGING_FACE_AWARE_FILL
    NSInteger theRedRectangleTag = -3312;
    UIView *facesRectLine = [self viewWithTag:theRedRectangleTag];
    if (!facesRectLine) {
        facesRectLine = [[UIView alloc] initWithFrame:facesRect];
        facesRectLine.tag = theRedRectangleTag;
    }
    else {
        facesRectLine.frame = facesRect;
    }
    
    facesRectLine.backgroundColor = [UIColor clearColor];
    facesRectLine.layer.borderColor = [UIColor redColor].CGColor;
    facesRectLine.layer.borderWidth = 4.0;
    
    CGRect frame = facesRectLine.frame;
    frame.origin.x = imageRect.origin.x + frame.origin.x;
    frame.origin.y = imageRect.origin.y + frame.origin.y;
    facesRectLine.frame = frame;
    
    [self addSubview:facesRectLine];
#endif
}

@end
