//
//  UIImageView+SCFBetterFace.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/26.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIImageView+SCFBetterFace.h"
#import <objc/runtime.h>

#define BETTER_LAYER_NAME @"BETTER_LAYER_NAME"
#define GOLDEN_RATIO (0.618)

#ifdef SCF_DEBUG
#define SCFLog(format...) NSLog(format)
#else
#define SCFLog(format...)
#endif

static CIDetector *scf_detector;

static NSString *const scf_needBetterFaceKey = @"scf_needBetterFaceKey";
static NSString *const scf_fastSpeedKey = @"scf_fastSpeedKey";
static NSString *const scf_detectorKey = @"scf_detectorKey";

@implementation UIImageView (SCFBetterFace)

#pragma mark - public methods
void scf_hack_uiimageview_bf(void) {
    Method oriSetImgMethod = class_getInstanceMethod([UIImageView class], @selector(setImage:));
    Method newSetImgMethod = class_getInstanceMethod([UIImageView class], @selector(scf_setBetterFaceImage:));
    method_exchangeImplementations(newSetImgMethod, oriSetImgMethod);
}

- (void)scf_setBetterFaceImage:(UIImage *)image {
    
}

#pragma mark - private methods
- (void)scf_faceDetect:(UIImage *)aImage {
    dispatch_queue_t queue = dispatch_queue_create("com.scf.betterface.queue", NULL);
    dispatch_async(queue, ^{
        CIImage *ciImage = aImage.CIImage;
        if (ciImage == nil) {
            ciImage = [CIImage imageWithCGImage:aImage.CGImage];
        }
        if (scf_detector == nil) {
            NSDictionary *pots = [NSDictionary dictionaryWithObject:[self scf_fast] ? CIDetectorAccuracyLow : CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
            scf_detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil
                                              options:pots];
        }
        
        NSArray *features = [scf_detector featuresInImage:ciImage];
        if (features.count == 0) {
            SCFLog(@"no faces");
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self scf_imageLayer] removeFromSuperlayer];
            });
        }
        else {
            SCFLog(@"succeed %ld faces", features.count);
            [self scf_markAfterFaceDetect:features size:CGSizeMake(CGImageGetWidth(aImage.CGImage), CGImageGetHeight(aImage.CGImage))];
        }
    });
}

- (CALayer *)scf_imageLayer {
    for (CALayer *layer in [self.layer sublayers]) {
        if ([layer.name isEqualToString:BETTER_LAYER_NAME]) {
            return layer;
        }
    }
    
    CALayer *layer = [CALayer layer];
    [layer setName:BETTER_LAYER_NAME];
    layer.actions = @{@"contents" : [NSNull null],
                      @"bounds" : [NSNull null],
                      @"position" : [NSNull null],
                      };
    [self.layer addSublayer:layer];
    
    return layer;
}

- (void)scf_markAfterFaceDetect:(NSArray *)features size:(CGSize)size {
    CGRect fixedRect = CGRectMake(MAXFLOAT, MAXFLOAT, 0.0f, 0.0f);
    CGFloat rightBorder = 0.0f, bottomBorder = 0.0f;
    for (CIFaceFeature *feature in features) {
        CGRect oneRect = feature.bounds;
        oneRect.origin.y = size.height - oneRect.origin.y - oneRect.size.height;
        
        fixedRect.origin.x = MIN(oneRect.origin.x, fixedRect.origin.x);
        fixedRect.origin.y = MIN(oneRect.origin.y, fixedRect.origin.y);
        
        rightBorder = MAX(oneRect.origin.x + oneRect.size.width, rightBorder);
        bottomBorder = MAX(oneRect.origin.y + oneRect.size.height, bottomBorder);
    }
    
    fixedRect.size.width = rightBorder - fixedRect.origin.x;
    fixedRect.size.height = bottomBorder - fixedRect.origin.y;
    
    CGPoint fixedCenter = CGPointMake(fixedRect.origin.x + fixedRect.size.width / 2.0, fixedRect.origin.y + fixedRect.size.height / 2.0);
    CGPoint offset = CGPointZero;
    CGSize finalSize = size;
    if (size.width / size.height > self.bounds.size.width / self.bounds.size.height) {
        // move horizonal
        finalSize.height = self.bounds.size.height;
        finalSize.width = size.width / size.height * finalSize.height;
        fixedCenter.x = finalSize.width / size.width * fixedCenter.x;
        fixedCenter.y = finalSize.width / size.width * fixedCenter.y;
        
        offset.x = fixedCenter.x - self.bounds.size.width * 0.5;
        if (offset.x < 0) {
            offset.x = 0;
        }
        else if (offset.x + self.bounds.size.width > finalSize.width) {
            offset.x = finalSize.width - self.bounds.size.width;
        }
        offset.x = -offset.x;
    }
    else {
        // move vertical
        finalSize.width = self.bounds.size.width;
        finalSize.height = size.height / size.width * finalSize.width;
        fixedCenter.x = finalSize.width / size.width * fixedCenter.x;
        fixedCenter.y = finalSize.width / size.width * fixedCenter.y;
        
        offset.y = fixedCenter.y - self.bounds.size.height * (1 - GOLDEN_RATIO);
        if (offset.y < 0) {
            offset.y = 0;
        }
        else if (offset.y + self.bounds.size.height > finalSize.height) {
            offset.y = finalSize.height - self.bounds.size.height;
        }
        offset.y = -offset.y;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CALayer *layer = [self scf_imageLayer];
        layer.frame = CGRectMake(offset.x, offset.y, finalSize.width, finalSize.height);
        layer.contents = (id)self.image.CGImage;
    });
}

#pragma mark - setters / getters
#pragma mark scf_needsBetterFace
- (void)setScf_needsBetterFace:(BOOL)scf_needsBetterFace {
    objc_setAssociatedObject(self,
                             &scf_needBetterFaceKey,
                             [NSNumber numberWithBool:scf_needsBetterFace],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)scf_needsBetterFace {
    NSNumber *nbfNumber = objc_getAssociatedObject(self, &scf_needBetterFaceKey);
    return [nbfNumber boolValue];
}

#pragma mark scf_fast
- (void)setScf_fast:(BOOL)scf_fast {
    objc_setAssociatedObject(self,
                             &scf_fastSpeedKey,
                             [NSNumber numberWithBool:scf_fast],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)scf_fast {
    NSNumber *fastNumber = objc_getAssociatedObject(self, &scf_fastSpeedKey);
    return [fastNumber boolValue];
}

#pragma mark scf_detector
- (void)setScf_detector:(CIDetector *)scf_detector {
    objc_setAssociatedObject(self,
                             &scf_detectorKey,
                             scf_detector,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CIDetector *)scf_Detector {
    return objc_getAssociatedObject(self, &scf_detectorKey);
}


@end
