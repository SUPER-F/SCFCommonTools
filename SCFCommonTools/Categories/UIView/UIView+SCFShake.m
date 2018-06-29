//
//  UIView+SCFShake.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/29.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIView+SCFShake.h"

@implementation UIView (SCFShake)

- (void)scf_shake {
    [self scf_shakeWithTimes:10 width:5.0f];
}

- (void)scf_shakeWithTimes:(NSInteger)times width:(CGFloat)width {
    [self scf_shakeWithTimes:times width:width completion:nil];
}

- (void)scf_shakeWithTimes:(NSInteger)times width:(CGFloat)width completion:(void (^)(void))handler {
    [self scf_shakeWithTimes:times width:width duration:0.03 completion:handler];
}

- (void)scf_shakeWithTimes:(NSInteger)times width:(CGFloat)width duration:(NSTimeInterval)interval {
    [self scf_shakeWithTimes:times width:width duration:interval completion:nil];
}

- (void)scf_shakeWithTimes:(NSInteger)times width:(CGFloat)width duration:(NSTimeInterval)interval completion:(void (^)(void))handler {
    [self scf_shakeWithTimes:times width:width duration:interval direction:SCFShakedDirectionHorizontal completion:handler];
}

- (void)scf_shakeWithTimes:(NSInteger)times width:(CGFloat)width duration:(NSTimeInterval)interval direction:(SCFShakedDirection)direction {
    [self scf_shakeWithTimes:times width:width duration:interval direction:direction completion:nil];
}

- (void)scf_shakeWithTimes:(NSInteger)times width:(CGFloat)width duration:(NSTimeInterval)interval direction:(SCFShakedDirection)direction completion:(void (^)(void))handler {
    [self p_scf_shakeWithTimes:times andCurrentTimes:0 width:width andWidthRate:1 duration:interval direction:direction completion:handler];
}

#pragma mark - privated methods
- (void)p_scf_shakeWithTimes:(NSInteger)times andCurrentTimes:(NSInteger)currentTimes width:(CGFloat)width andWidthRate:(NSInteger)widthRate duration:(NSTimeInterval)interval direction:(SCFShakedDirection)direction completion:(void (^)(void))handler {
    
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
        [self p_scf_shakeWithTimes:times
                   andCurrentTimes:currentTimes + 1
                             width:width
                      andWidthRate:widthRate * -1
                          duration:interval
                         direction:direction
                        completion:handler];
    }];
}

@end
