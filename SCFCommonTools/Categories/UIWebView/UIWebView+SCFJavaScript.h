//
//  UIWebView+SCFJavaScript.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/3.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIWebView (SCFJavaScript)

#pragma mark -
#pragma mark 获取网页中的数据
/// 获取某个标签的结点个数
- (NSInteger)nodeCountOfTag:(NSString *)tag;
/// 获取当前页面URL
- (NSString *)getCurrentURL;
/// 获取标题
- (NSString *)getTitle;
/// 获取图片
- (NSArray *)getImgs;
/// 获取当前页面所有链接
- (NSArray *)getOnClicks;

#pragma mark -
#pragma mark 改变网页样式和行为
/// 改变背景颜色
- (void)setBackgroundColor:(UIColor *)color;
/// 为所有图片添加点击事件(网页中有些图片添加无效)
- (void)addClickEventOnImg;
/// 改变所有图像的宽度
- (void)setImgWidth:(CGFloat)width;
/// 改变所有图像的高度
- (void)setImgHeight:(CGFloat)height;
/// 改变指定标签的字体颜色
- (void)setFontColor:(UIColor *)color withTag:(NSString *)tagName;
/// 改变指定标签的字体大小
- (void)setFontSize:(CGFloat)size withTag:(NSString *)tagName;

#pragma mark 删除
///根据 ElementsID 删除WebView 中的节点
- (void)deleteNodeByElementID:(NSString *)elementID;
/// 根据 ElementsClass 删除 WebView 中的节点
- (void)deleteNodeByElementClass:(NSString *)elementClass;
///根据  TagName 删除 WebView 的节点
- (void)deleteNodeByTagName:(NSString *)elementTagName;

@end
