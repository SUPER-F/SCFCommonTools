//
//  UITextView+SCFPinchZoom.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/29.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UITextView (SCFPinchZoom)

// 最小字体
@property (nonatomic, assign) CGFloat scf_minFontSize;
// 最大字体
@property (nonatomic, assign) CGFloat scf_maxFontSize;
// 是否允许缩放
@property (nonatomic, assign) BOOL scf_zoomEnabled;

@end
