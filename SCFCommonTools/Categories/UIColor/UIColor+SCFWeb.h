//
//  UIColor+SCFWeb.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/3.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIColor (SCFWeb)


/**
获取canvas用的颜色字符串

 @return canvas颜色
 */
- (NSString *)scf_canvasColorString;


/**
 获取网页颜色字串

 @return 网页颜色
 */
- (NSString *)scf_webColorString;

@end
