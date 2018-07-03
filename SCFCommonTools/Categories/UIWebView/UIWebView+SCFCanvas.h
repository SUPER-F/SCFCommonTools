//
//  UIWebView+SCFCanvas.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/2.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>

@interface UIWebView (SCFCanvas)

/**
 创建一个指定大小的画布，画布左上角的点为 (0, 0)

 @param canvasId 画布ID
 @param width 画布的宽度
 @param height 画布的高度
 */
- (void)scf_createCanvas:(NSString *)canvasId
                   width:(CGFloat)width
                  height:(CGFloat)height;

/**
 在指定位置创建一个指定大小的画布

 @param canvasId 画布ID
 @param startPoint 要创建的画布的左上角的点
 @param width 画布的宽度
 @param height 画布的高度
 */
- (void)scf_createCanvas:(NSString *)canvasId
              startPoint:(CGPoint)startPoint
                   width:(CGFloat)width
                  height:(CGFloat)height;

/**
 方法绘制“已填色”的矩形。默认的填充颜色是黑色：
 context.fillRect(x,y,width,height)

 @param canvasId 画布ID
 @param startPoint 要绘制的矩形的左上角的点
 @param width 矩形的宽度
 @param height 矩形的高度
 @param color 填充颜色
 */
- (void)scf_fillRectOnCanvas:(NSString *)canvasId
                  startPoint:(CGPoint)startPoint
                       width:(CGFloat)width
                      height:(CGFloat)height
                       color:(UIColor *)color;

/**
 方法绘制矩形（不填色），笔触的默认颜色是黑色：
 context.strokeRect(x,y,width,height)

 @param canvasId 画布ID
 @param startPoint 要绘制的矩形的左上角的点
 @param width 矩形的宽度
 @param height 矩形的高度
 @param color 笔触颜色
 @param lineWidth 线宽度
 */
- (void)scf_strokeRectOnCanvas:(NSString *)canvasId
                    startPoint:(CGPoint)startPoint
                         width:(CGFloat)width
                        height:(CGFloat)height
                         color:(UIColor *)color
                     lineWidth:(CGFloat)lineWidth;

/**
 方法清空给定矩形内的指定区域：
 context.clearRect(x,y,width,height)

 @param canvasId 画布ID
 @param startPoint 要清除的矩形左上角的点
 @param width 要清除的矩形的宽度
 @param height 要清除的矩形的高度
 */
- (void)scf_clearRectOnCanvas:(NSString *)canvasId
                   startPoint:(CGPoint)startPoint
                        width:(CGFloat)width
                       height:(CGFloat)height;

/**
 绘制圆弧填充：
 context.arc(x, y, radius, starAngle,endAngle, anticlockwise)

 @param canvasId 画布ID
 @param centerPoint 圆的中心点
 @param radius 圆的半径
 @param startAngle 起始角，以弧度计。（弧的圆形的三点钟位置是 0 度）
 @param endAngle 结束角，以弧度计
 @param anticlockwise 可选。规定应该逆时针还是顺时针绘图。False = 顺时针，true = 逆时针。
 @param color 线颜色
 */
- (void)scf_arcOnCanvas:(NSString *)canvasId
            centerPoint:(CGPoint)centerPoint
                 radius:(CGFloat)radius
             startAngle:(CGFloat)startAngle
               endAngle:(CGFloat)endAngle
          anticlockwise:(BOOL)anticlockwise
                  color:(UIColor *)color;


/**
 绘制一条线段：
 context.moveTo(x,y) context.lineTo(x,y)

 @param canvasId 画布ID
 @param beginPoint 开始点
 @param endPoint 结束点
 @param color 颜色
 @param lineWidth 线颜色
 */
- (void)scf_lineOnCanvas:(NSString *)canvasId
              beginPoint:(CGPoint)beginPoint
                endPoint:(CGPoint)endPoint
                   color:(UIColor *)color
               lineWidth:(CGFloat)lineWidth;

/**
 绘制一条折线

 @param canvasId 画布ID
 @param points 折点数组
 @param color 线颜色
 @param lineWidth 线宽度
 */
- (void)scf_linesOnCanvas:(NSString *)canvasId
                   points:(NSArray *)points
                    color:(UIColor *)color
                lineWidth:(CGFloat)lineWidth;

/**
 绘制三次贝塞尔曲线：
 context.bezierCurveTo(cp1x,cp1y,cp2x,cp2y,x,y)

 @param canvasId 画布ID
 @param beginPoint 开始点
 @param cp1 控制点1
 @param cp2 控制点2
 @param endPoint 结束点
 @param color 颜色
 @param lineWidth 曲线宽度
 */
- (void)scf_bezierCurveOnCanvas:(NSString *)canvasId
                      beginPoint:(CGPoint)beginPoint
                  controlPoint1:(CGPoint)cp1
                  controlPoint2:(CGPoint)cp2
                        endPoint:(CGPoint)endPoint
                          color:(UIColor *)color
                      lineWidth:(CGFloat)lineWidth;


/**
 剪切图像，并在画布上定位被剪切的部分：
 context.drawImage(img,sx,sy,swidth,sheight,x,y,width,height);

 @param canvasId 画布ID
 @param img 规定要使用的图像、画布或视频
 @param sx 可选。开始剪切的 x 坐标位置
 @param sy 可选。开始剪切的 y 坐标位置
 @param sWidth 可选。被剪切图像的宽度
 @param sHeight 可选。被剪切图像的高度
 @param x 在画布上放置图像的 x 坐标位置
 @param y 在画布上放置图像的 y 坐标位置
 @param width 可选。要使用的图像的宽度。（伸展或缩小图像）
 @param height 可选。要使用的图像的高度。（伸展或缩小图像）
 */
- (void)scf_drawImageOnCanvas:(NSString *)canvasId
                        image:(NSString *)img
                           sx:(CGFloat)sx
                           sy:(CGFloat)sy
                       sWidth:(CGFloat)sWidth
                      sHeight:(CGFloat)sHeight
                            x:(CGFloat)x
                            y:(CGFloat)y
                        width:(CGFloat)width
                       height:(CGFloat)height;

@end
