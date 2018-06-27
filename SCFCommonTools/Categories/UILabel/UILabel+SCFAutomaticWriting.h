//
//  UILabel+SCFAutomaticWriting.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/27.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

//  Created by alexruperez on 10/3/15.
//  Copyright (c) 2015 alexruperez. All rights reserved.
//  https://github.com/alexruperez/UILabel-AutomaticWriting

#import <UIKit/UIKit.h>

//! Project version number for UILabel-AutomaticWriting.
FOUNDATION_EXPORT double UILabelAutomaticWritingVersionNumber;

//! Project version string for UILabel-AutomaticWriting.
FOUNDATION_EXPORT const unsigned char UILabelAutomaticWritingVersionString[];

extern NSTimeInterval const UILabelAWDefaultDuration;

extern unichar const UILabelAWDefaultCharacter;

typedef NS_ENUM(NSInteger, UILabelSCFlinkingMode) {
    UILabelSCFlinkingModeNone,
    UILabelSCFlinkingModeUntilFinish,
    UILabelSCFlinkingModeUntilFinishKeeping,
    UILabelSCFlinkingModeWhenFinish,
    UILabelSCFlinkingModeWhenFinishShowing,
    UILabelSCFlinkingModeAlways
};


@interface UILabel (SCFAutomaticWriting)

@property (strong, nonatomic) NSOperationQueue *scf_automaticWritingOperationQueue;
@property (assign, nonatomic) UIEdgeInsets scf_edgeInsets;

- (void)scf_setTextWithAutomaticWritingAnimation:(NSString *)text;

- (void)scf_setText:(NSString *)text automaticWritingAnimationWithBlinkingMode:(UILabelSCFlinkingMode)blinkingMode;

- (void)scf_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration;

- (void)scf_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelSCFlinkingMode)blinkingMode;

- (void)scf_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelSCFlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter;

- (void)scf_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelSCFlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter completion:(void (^)(void))completion;


@end
