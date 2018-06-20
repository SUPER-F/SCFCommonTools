//
//  UIButton+SCFBadge.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/20.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIButton (SCFBadge)

@property (nonatomic, strong) UILabel *scf_badge;

// Badge value to be display
@property (nonatomic, copy) NSString *scf_badgeValue;
// Badge background color
@property (nonatomic) UIColor *scf_badgeBGColor;
// Badge text color
@property (nonatomic) UIColor *scf_badgeTextColor;
// Badge font
@property (nonatomic) UIFont *scf_badgeFont;
// Padding value for the badge
@property (nonatomic) CGFloat scf_badgePadding;
// Minimum size badge to small
@property (nonatomic) CGFloat scf_badgeMinSize;
// Values for offsetting the badge over the BarButtonItem you picked
@property (nonatomic) CGFloat scf_badgeOriginX;
@property (nonatomic) CGFloat scf_badgeOriginY;
// In case of numbers, remove the badge when reaching zero
@property (nonatomic) BOOL scf_shouldHideBadgeAtZero;
// Badge has a bounce animation when value changes
@property (nonatomic) BOOL scf_shouldAnimateBadge;

@end
