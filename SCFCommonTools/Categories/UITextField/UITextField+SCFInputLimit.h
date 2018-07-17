//
//  UITextField+SCFInputLimit.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/29.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UITextField (SCFInputLimit)

@property (nonatomic, assign) NSInteger maxLength;  // if <= 0, no limit

@end
