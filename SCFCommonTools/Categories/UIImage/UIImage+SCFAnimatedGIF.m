//
//  UIImage+SCFAnimatedGIF.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/21.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIImage+SCFAnimatedGIF.h"
#import <ImageIO/ImageIO.h>

#if __has_feature(objc_arc)
#define toCF (__bridge CFTypeRef)
#define fromCF (__bridge id)
#else
#define toCF (CFTypeRef)
#define fromCF (id)
#endif

@implementation UIImage (SCFAnimatedGIF)

static int scf_delayCentisecondsForImageAtIndex(CGImageSourceRef const source, size_t const i) {
    int delayCentiseconds = 1;
    
    CFDictionaryRef const properties = CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
    if (properties) {
        CFDictionaryRef const gifProperties = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
        if (gifProperties) {
            CFNumberRef const number = CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFDelayTime);
            // 将 seconds 转换为 centiseconds
            delayCentiseconds = (int)lrint([fromCF number doubleValue] * 100);
        }
    }
    CFRelease(properties);
    
    return delayCentiseconds;
}

static void scf_createImagesAndDelays(CGImageSourceRef source, size_t count, CGImageRef imagesOut[count], int delayCentisecoundsOut[count]) {
    for (size_t i = 0; i < count; ++i) {
        imagesOut[i] = CGImageSourceCreateImageAtIndex(source, i, NULL);
        delayCentisecoundsOut[i] = scf_delayCentisecondsForImageAtIndex(source, i);
    }
}

static int scf_sum(size_t const count, int const *const values) {
    int theSum = 0;
    for (size_t i = 0; i < count; ++i) {
        theSum += values[i];
    }
    return theSum;
}

static int scf_pairGCD(int a, int b) {
    if (a < b) {
        return scf_pairGCD(b, a);
    }
    while (true) {
        int const r = a % b;
        if (r == 0) {
            return b;
        }
        a = b;
        b = r;
    }
}

static int scf_vectorGCD(size_t const count, int const *const values) {
    int gcd = values[0];
    for (size_t i = 1; i < count; ++i) {
        // 注意，在我处理向量的前几个元素之后，“gcd”可能比任何剩余的元素都要小。通过将较小的值作为第二个参数传递给“pairGCD”，我避免让它交换参数。
        gcd = scf_pairGCD(values[i], gcd);
    }
    return gcd;
}

static NSArray *scf_frameArray(size_t const count, CGImageRef const images[count], int const delayCentiseconds[count], int const totalDurationCentiseconds) {
    int const gcd = scf_vectorGCD(count, delayCentiseconds);
    size_t const frameCount = totalDurationCentiseconds / gcd;
    UIImage *frames[frameCount];
    for (size_t i = 0, f = 0; i < count; ++i) {
        UIImage *const frame = [UIImage imageWithCGImage:images[i]];
        for (size_t j = delayCentiseconds[i] / gcd; j > 0; --j) {
            frames[f++] = frame;
        }
    }
    return [NSArray arrayWithObjects:frames count:frameCount];
}

static void scf_releaseImages(size_t const count, CGImageRef const images[count]) {
    for (size_t i = 0; i < count; ++i) {
        CGImageRelease(images[i]);
    }
}

static UIImage *scf_animatedImageWithAnimatedGIFImageSource(CGImageSourceRef const source) {
    size_t const count = CGImageSourceGetCount(source);
    CGImageRef images[count];
    int delayCentiseconds[count];
    scf_createImagesAndDelays(source, count, images, delayCentiseconds);
    int const totalDurationCentiseconds = scf_sum(count, delayCentiseconds);
    NSArray *const frames = scf_frameArray(count, images, delayCentiseconds, totalDurationCentiseconds);
    UIImage *const animation = [UIImage animatedImageWithImages:frames duration:(NSTimeInterval)totalDurationCentiseconds / 100.0];
    scf_releaseImages(count, images);
    return animation;
}

static UIImage *scf_animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceRef source) {
    if (source) {
        UIImage *const image = scf_animatedImageWithAnimatedGIFImageSource(source);
        CFRelease(source);
        return image;
    }
    else {
        return nil;
    }
}

+ (UIImage *)scf_animatedImageWithAnimatedGIFData:(NSData *)theData {
    return scf_animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithData(toCF theData, NULL));
}

+ (UIImage *)scf_animatedImageWithAnimatedGIFURL:(NSURL *)theURL {
    return scf_animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithURL(toCF theURL, NULL));
}

#pragma mark - 另外一种实现方式
+ (UIImage *)scf_animatedImageWithGIFData:(NSData *)data {
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(sourceRef);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(sourceRef, i, NULL);
            duration += [self scf_frameDurationAtIndex:i source:sourceRef];
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(sourceRef);
    
    return animatedImage;
}

+ (UIImage *)scf_animatedImageWithGIFNamed:(NSString *)name {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (scale == 2.0f) {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        if (data) {
            return [UIImage scf_animatedImageWithGIFData:data];
        }
    }
    
    if (scale == 3.0f) {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@3x"] ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        if (data) {
            return [UIImage scf_animatedImageWithGIFData:data];
        }
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data) {
        return [UIImage scf_animatedImageWithGIFData:data];
    }
    
    return [UIImage imageNamed:name];
}

- (UIImage *)scf_animatedImageByScalingAndCroppingToSize:(CGSize)size {
    if (CGSizeEqualToSize(self.size, size) || CGSizeEqualToSize(size, CGSizeZero)) {
        return self;
    }
    
    CGSize scaledSize = size;
    CGPoint thumbnailPoint = CGPointZero;
    
    CGFloat widthFactor = size.width / self.size.width;
    CGFloat heightFactor = size.height / self.size.height;
    CGFloat scaleFactor = (widthFactor > heightFactor) ? widthFactor : heightFactor;
    
    scaledSize.width = self.size.width * scaleFactor;
    scaledSize.height = self.size.height * scaleFactor;
    
    if (widthFactor > heightFactor) {
        thumbnailPoint.y = (size.height - scaledSize.height) * 0.5f;
    }
    else if (widthFactor < heightFactor) {
        thumbnailPoint.x = (size.width - scaledSize.width) * 0.5f;
    }
    
    NSMutableArray *scaledImages = [NSMutableArray array];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    for (UIImage *image in self.images) {
        [image drawInRect:CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledSize.width, scaledSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        [scaledImages addObject:newImage];
    }
    UIGraphicsEndImageContext();
    
    return [UIImage animatedImageWithImages:scaledImages duration:self.duration];
}

#pragma mark - private methods
+ (float)scf_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, NULL);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // 当动画时间小于等于 10ms，则设置默认动画时间为 100ms
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    
    return frameDuration;
}


@end
