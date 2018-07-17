//
//  UITextField+SCFShake.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/28.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UITextField+SCFShake.h"

@implementation UITextField (SCFShake)

- (void)shake {
    [self shakeWithTimes:10 width:5.0f];
}

- (void)shakeWithTimes:(NSInteger)times width:(CGFloat)width {
    [self shakeWithTimes:times width:width completion:nil];
}

- (void)shakeWithTimes:(NSInteger)times width:(CGFloat)width completion:(void (^)(void))handler {
    [self shakeWithTimes:times width:width duration:0.03 completion:handler];
}

- (void)shakeWithTimes:(NSInteger)times width:(CGFloat)width duration:(NSTimeInterval)interval {
    [self shakeWithTimes:times width:width duration:interval completion:nil];
}

- (void)shakeWithTimes:(NSInteger)times width:(CGFloat)width duration:(NSTimeInterval)interval completion:(void (^)(void))handler {
    [self shakeWithTimes:times width:width duration:interval direction:SCFShakedDirectionHorizontal completion:handler];
}

- (void)shakeWithTimes:(NSInteger)times width:(CGFloat)width duration:(NSTimeInterval)interval direction:(SCFShakedDirection)direction {
    [self shakeWithTimes:times width:width duration:interval direction:direction completion:nil];
}

- (void)shakeWithTimes:(NSInteger)times width:(CGFloat)width duration:(NSTimeInterval)interval direction:(SCFShakedDirection)direction completion:(void (^)(void))handler {
    [self p_shakeWithTimes:times andCurrentTimes:0 width:width andWidthRate:1 duration:interval direction:direction completion:handler];
}

#pragma mark - privated methods
- (void)p_shakeWithTimes:(NSInteger)times andCurrentTimes:(NSInteger)currentTimes width:(CGFloat)width andWidthRate:(NSInteger)widthRate duration:(NSTimeInterval)interval direction:(SCFShakedDirection)direction completion:(void (^)(void))handler {
    
    [UIView animateWithDuration:interval animations:^{
        // CGAffineTransformMakeTranslation(),这是一个实现相对位移的函数,只要我们记住相对的是“屏幕的左上角(以左上角为相对移动的(0,0)点)”
        self.transform = (direction == SCFShakedDirectionHorizontal) ? CGAffineTransformMakeTranslation(width * widthRate, 0) : CGAffineTransformMakeTranslation(0, width * widthRate);
    } completion:^(BOOL finished) {
        if (currentTimes >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (handler) {
                    handler();
                }
            }];
            return;
        }
        [self p_shakeWithTimes:times
                   andCurrentTimes:currentTimes + 1
                             width:width
                      andWidthRate:widthRate * -1
                          duration:interval
                         direction:direction
                        completion:handler];
    }];
}

@end
