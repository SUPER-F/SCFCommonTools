//
//  UIBarButtonItem+SCFBadge.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/19.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SCFBadge)

@property (nonatomic, strong) UILabel *badge;

// Badge value to be display
@property (nonatomic, copy) NSString *badgeValue;
// Badge background color
@property (nonatomic) UIColor *badgeBGColor;
// Badge text color
@property (nonatomic) UIColor *badgeTextColor;
// Badge font
@property (nonatomic) UIFont *badgeFont;
// Padding value for the badge
@property (nonatomic) CGFloat badgePadding;
// Minimum size badge to small
@property (nonatomic) CGFloat badgeMinSize;
// Values for offsetting the badge over the BarButtonItem you picked
@property (nonatomic) CGFloat badgeOriginX;
@property (nonatomic) CGFloat badgeOriginY;
// In case of numbers, remove the badge when reaching zero
@property (nonatomic) BOOL shouldHideBadgeAtZero;
// Badge has a bounce animation when value changes
@property (nonatomic) BOOL shouldAnimateBadge;

@end
