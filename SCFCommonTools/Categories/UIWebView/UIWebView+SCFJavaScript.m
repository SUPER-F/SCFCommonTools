//
//  UIWebView+SCFJavaScript.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/3.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIWebView+SCFJavaScript.h"
#import "UIColor+SCFWeb.h"

@implementation UIWebView (SCFJavaScript)

#pragma mark -
#pragma mark 获取网页中的数据
/// 获取某个标签的结点个数
- (NSInteger)scf_nodeCountOfTag:(NSString *)tag {
    NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('%@').length", tag];
    NSInteger len = [[self stringByEvaluatingJavaScriptFromString:jsString] integerValue];
    return len;
}
/// 获取当前页面URL
- (NSString *)scf_getCurrentURL {
    return [self stringByEvaluatingJavaScriptFromString:@"document.location.href"];
}
/// 获取标题
- (NSString *)scf_getTitle {
    return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}
/// 获取所有图片链接
- (NSArray *)scf_getImgs {
    NSMutableArray *arrImgURL = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < [self scf_nodeCountOfTag:@"img"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%ld].src", i];
        [arrImgURL addObject:[self stringByEvaluatingJavaScriptFromString:jsString]];
    }
    return arrImgURL;
}
/// 获取当前页面所有点击链接
- (NSArray *)scf_getOnClicks {
    NSMutableArray *arrOnClicks = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < [self scf_nodeCountOfTag:@"a"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('a')[%ld].getAttribute('onclick')", i];
        NSString *clickString = [self stringByEvaluatingJavaScriptFromString:jsString];
        NSLog(@"%@", clickString);
        [arrOnClicks addObject:clickString];
    }
    return arrOnClicks;
}

#pragma mark -
#pragma mark 改变网页样式和行为
/// 改变背景颜色
- (void)scf_setBackgroundColor:(UIColor *)color {
    NSString * jsString = [NSString stringWithFormat:@"document.body.style.backgroundColor = '%@'",[color scf_webColorString]];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}
/// 为所有图片添加点击事件(网页中有些图片添加无效,需要协议方法配合截取)
- (void)scf_addClickEventOnImg {
    for (NSInteger i = 0; i < [self scf_nodeCountOfTag:@"img"]; i++) {
        //利用重定向获取img.src，为区分，给url添加'img:'前缀
        NSString *jsString = [NSString stringWithFormat:
                              @"document.getElementsByTagName('img')[%ld].onclick = \
                              function() { document.location.href = 'img' + this.src; }",i];
        [self stringByEvaluatingJavaScriptFromString:jsString];
    }
}
/// 改变所有图像的宽度
- (void)scf_setImgWidth:(CGFloat)width {
    for (NSInteger i = 0; i < [self scf_nodeCountOfTag:@"img"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%ld].width = '%f'", i, width];
        [self stringByEvaluatingJavaScriptFromString:jsString];
        jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%ld].style.width = '%fpx'", i, width];
        [self stringByEvaluatingJavaScriptFromString:jsString];
    }
}
/// 改变所有图像的高度
- (void)scf_setImgHeight:(CGFloat)height {
    for (NSInteger i = 0; i < [self scf_nodeCountOfTag:@"img"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%ld].height = '%f'", i, height];
        [self stringByEvaluatingJavaScriptFromString:jsString];
        jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%ld].style.height = '%fpx'", i, height];
        [self stringByEvaluatingJavaScriptFromString:jsString];
    }
}
/// 改变指定标签的字体颜色
- (void)scf_setFontColor:(UIColor *)color withTag:(NSString *)tagName {
    NSString *jsString = [NSString stringWithFormat:
                          @"var nodes = document.getElementsByTagName('%@'); \
                          for(var i=0;i<nodes.length;i++){\
                          nodes[i].style.color = '%@';}", tagName, [color scf_webColorString]];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}
/// 改变指定标签的字体大小
- (void)scf_setFontSize:(CGFloat)size withTag:(NSString *)tagName {
    NSString *jsString = [NSString stringWithFormat:
                          @"var nodes = document.getElementsByTagName('%@'); \
                          for(var i=0;i<nodes.length;i++){\
                          nodes[i].style.fontSize = '%fpx';}", tagName, size];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

#pragma mark -
#pragma mark 删除
/**
 *  根据 ElementsID 删除WebView 中的节点
 */
- (void )scf_deleteNodeByElementID:(NSString *)elementID {
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('%@').remove();",elementID]];
}
/**
 *  根据 ElementsClass 删除 WebView 中的节点
 */
- (void)scf_deleteNodeByElementClass:(NSString *)elementClass {
    NSString *javaScriptString = [NSString stringWithFormat:@"\
                                  function getElementsByClassName(n) {\
                                  var classElements = [],allElements = document.getElementsByTagName('*');\
                                  for (var i=0; i< allElements.length; i++ )\
                                  {\
                                  if (allElements[i].className == n) {\
                                  classElements[classElements.length] = allElements[i];\
                                  }\
                                  }\
                                  for (var i=0; i<classElements.length; i++) {\
                                  classElements[i].style.display = \"none\";\
                                  }\
                                  }\
                                  getElementsByClassName('%@')",elementClass];
    [self stringByEvaluatingJavaScriptFromString:javaScriptString];
}
/**
 *  根据 ElementsClassTagName 删除 WebView 的节点
 */
- (void)scf_deleteNodeByTagName:(NSString *)elementTagName {
    NSString *javaScritptString = [NSString stringWithFormat:@"document.getElementByTagName('%@').remove();",elementTagName];
    [self stringByEvaluatingJavaScriptFromString:javaScritptString];
}

@end
