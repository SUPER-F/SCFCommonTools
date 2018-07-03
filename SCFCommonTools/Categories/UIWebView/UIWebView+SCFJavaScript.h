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
- (NSInteger)scf_nodeCountOfTag:(NSString *)tag;
/// 获取当前页面URL
- (NSString *)scf_getCurrentURL;
/// 获取标题
- (NSString *)scf_getTitle;
/// 获取图片
- (NSArray *)scf_getImgs;
/// 获取当前页面所有链接
- (NSArray *)scf_getOnClicks;

#pragma mark -
#pragma mark 改变网页样式和行为
/// 改变背景颜色
- (void)scf_setBackgroundColor:(UIColor *)color;
/// 为所有图片添加点击事件(网页中有些图片添加无效)
- (void)scf_addClickEventOnImg;
/// 改变所有图像的宽度
- (void)scf_setImgWidth:(CGFloat)width;
/// 改变所有图像的高度
- (void)scf_setImgHeight:(CGFloat)height;
/// 改变指定标签的字体颜色
- (void)scf_setFontColor:(UIColor *)color withTag:(NSString *)tagName;
/// 改变指定标签的字体大小
- (void)scf_setFontSize:(CGFloat)size withTag:(NSString *)tagName;

#pragma mark 删除
///根据 ElementsID 删除WebView 中的节点
- (void)scf_deleteNodeByElementID:(NSString *)elementID;
/// 根据 ElementsClass 删除 WebView 中的节点
- (void)scf_deleteNodeByElementClass:(NSString *)elementClass;
///根据  TagName 删除 WebView 的节点
- (void)scf_deleteNodeByTagName:(NSString *)elementTagName;

@end
