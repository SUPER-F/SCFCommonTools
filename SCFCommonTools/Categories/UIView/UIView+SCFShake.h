//
//  UIView+SCFShake.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/29.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SCFShakedDirection) {
    SCFShakedDirectionHorizontal,
    SCFShakedDirectionVertical,
};

@interface UIView (SCFShake)

/**
 摇动UITextField
 使用默认值
 */
- (void)shake;


/**
 摇动UITextField
 可设置摇动次数和摇动宽度
 
 @param times 摇动次数
 @param width 摇动宽度
 */
- (void)shakeWithTimes:(NSInteger)times width:(CGFloat)width;


/**
 摇动UITextField
 可设置摇动次数和摇动宽度，摇动结束要执行的block
 
 @param times 摇动次数
 @param width 摇动宽度
 @param handler 摇动结束的block
 */
- (void)shakeWithTimes:(NSInteger)times width:(CGFloat)width completion:(void (^)(void))handler;


/**
 摇动UITextField
 可设置摇动次数、摇动宽度、每次摇动的持续时间
 
 @param times 摇动次数
 @param width 摇动宽度
 @param interval 每次摇动的持续时间
 */
- (void)shakeWithTimes:(NSInteger)times width:(CGFloat)width duration:(NSTimeInterval)interval;


/**
 摇动UITextField
 可设置摇动次数、摇动宽度、每次摇动的持续时间，摇动结束要执行的block
 
 @param times 摇动次数
 @param width 摇动宽度
 @param interval 每次摇动的持续时间
 @param handler 摇动结束的block
 */
- (void)shakeWithTimes:(NSInteger)times width:(CGFloat)width duration:(NSTimeInterval)interval completion:(void (^)(void))handler;


/**
 摇动UITextField
 可设置摇动次数、摇动宽度、每次摇动的持续时间、摇动方向
 
 @param times 摇动次数
 @param width 摇动宽度
 @param interval 每次摇动的持续时间
 @param direction 摇动方向
 */
- (void)shakeWithTimes:(NSInteger)times width:(CGFloat)width duration:(NSTimeInterval)interval direction:(SCFShakedDirection)direction;


/**
 摇动UITextField
 可设置摇动次数、摇动宽度、每次摇动的持续时间、摇动方向，摇动结束要执行的block
 
 @param times 摇动次数
 @param width 摇动宽度
 @param interval 每次摇动的持续时间
 @param direction 摇动方向
 @param handler 摇动结束的block
 */
- (void)shakeWithTimes:(NSInteger)times width:(CGFloat)width duration:(NSTimeInterval)interval direction:(SCFShakedDirection)direction completion:(void (^)(void))handler;

@end
