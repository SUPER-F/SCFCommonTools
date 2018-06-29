//
//  UIView+SCFFrame.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/29.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIView (SCFFrame)

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint scf_origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize scf_size;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat scf_centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat scf_centerY;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat scf_top;

/**
 * Shortcut for frame.origin.x
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat scf_left;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat scf_bottom;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat scf_right;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat scf_width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat scf_height;

@end
