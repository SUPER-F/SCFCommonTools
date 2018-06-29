//
//  UITextView+SCFPlaceHolder.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/29.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UITextView (SCFPlaceHolder)

@property (nonatomic, strong) UITextView *scf_placeHolderTextView;

- (void)scf_addPlaceHolder:(NSString *)placeHolder;

@end
