//
//  UILabel+SCFAutoSize.h
//  SCFCommonTools
//
//  Created by scf on 2018/6/26.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UILabel (SCFAutoSize)


/**
 获取垂直方向固定，动态宽度的label

 @return 动态宽度label（起始位置相同）
 */
- (UILabel *)labelAutoSizeHorizontal;


/**
 获取水平方向固定，动态高度的label

 @return 动态高度label（起始位置相同）
 */
- (UILabel *)labelAutoSizeVertical;


/**
 获取垂直方向固定，动态宽度的label

 @param minWidth 最小宽度
 @return 动态宽度label（起始位置相同）
 */
- (UILabel *)labelAutoSizeHorizontalWithMinWidth:(CGFloat)minWidth;


/**
 获取水平方向固定，动态高度的label

 @param minHeight 最小高度
 @return 动态高度label（起始位置相同）
 */
- (UILabel *)labelAutoSizeVerticalWithMinHeight:(CGFloat)minHeight;

@end
