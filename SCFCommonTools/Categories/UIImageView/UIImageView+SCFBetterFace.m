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

#ifdef DEBUG
#define SCFLog(format...) NSLog(format)
#else
#define SCFLog(format...)
#endif

static CIDetector *detector;

static NSString *const needBetterFaceKey = @"needBetterFaceKey";
static NSString *const fastSpeedKey = @"fastSpeedKey";
static NSString *const detectorKey = @"detectorKey";

@implementation UIImageView (SCFBetterFace)

#pragma mark - public methods
void hack_uiimageview_bf(void) {
    Method oriSetImgMethod = class_getInstanceMethod([UIImageView class], @selector(setImage:));
    Method newSetImgMethod = class_getInstanceMethod([UIImageView class], @selector(setBetterFaceImage:));
    method_exchangeImplementations(newSetImgMethod, oriSetImgMethod);
}

- (void)setBetterFaceImage:(UIImage *)image {
    
}

#pragma mark - private methods
- (void)faceDetect:(UIImage *)aImage {
    dispatch_queue_t queue = dispatch_queue_create("com.scf.betterface.queue", NULL);
    dispatch_async(queue, ^{
        CIImage *ciImage = aImage.CIImage;
        if (ciImage == nil) {
            ciImage = [CIImage imageWithCGImage:aImage.CGImage];
        }
        if (detector == nil) {
            NSDictionary *pots = [NSDictionary dictionaryWithObject:[self fast] ? CIDetectorAccuracyLow : CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
            detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil
                                              options:pots];
        }
        
        NSArray *features = [detector featuresInImage:ciImage];
        if (features.count == 0) {
            SCFLog(@"no faces");
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self imageLayer] removeFromSuperlayer];
            });
        }
        else {
            SCFLog(@"succeed %ld faces", features.count);
            [self markAfterFaceDetect:features size:CGSizeMake(CGImageGetWidth(aImage.CGImage), CGImageGetHeight(aImage.CGImage))];
        }
    });
}

- (CALayer *)imageLayer {
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

- (void)markAfterFaceDetect:(NSArray *)features size:(CGSize)size {
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
        CALayer *layer = [self imageLayer];
        layer.frame = CGRectMake(offset.x, offset.y, finalSize.width, finalSize.height);
        layer.contents = (id)self.image.CGImage;
    });
}

#pragma mark - setters / getters
#pragma mark needsBetterFace
- (void)setNeedsBetterFace:(BOOL)needsBetterFace {
    objc_setAssociatedObject(self,
                             &needBetterFaceKey,
                             [NSNumber numberWithBool:needsBetterFace],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)needsBetterFace {
    NSNumber *nbfNumber = objc_getAssociatedObject(self, &needBetterFaceKey);
    return [nbfNumber boolValue];
}

#pragma mark fast
- (void)setFast:(BOOL)fast {
    objc_setAssociatedObject(self,
                             &fastSpeedKey,
                             [NSNumber numberWithBool:fast],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)fast {
    NSNumber *fastNumber = objc_getAssociatedObject(self, &fastSpeedKey);
    return [fastNumber boolValue];
}

#pragma mark detector
- (void)setdetector:(CIDetector *)detector {
    objc_setAssociatedObject(self,
                             &detectorKey,
                             detector,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CIDetector *)Detector {
    return objc_getAssociatedObject(self, &detectorKey);
}


@end
