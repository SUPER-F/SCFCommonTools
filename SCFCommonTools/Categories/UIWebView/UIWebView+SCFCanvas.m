//
//  UIWebView+SCFCanvas.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/2.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIWebView+SCFCanvas.h"
#import "UIColor+SCFWeb.h"

@implementation UIWebView (SCFCanvas)

- (void)scf_createCanvas:(NSString *)canvasId width:(CGFloat)width height:(CGFloat)height {
    NSString *jsString = [NSString stringWithFormat:
                          @"var canvas = document.createElement('canvas');"
                          "canvas.id = %@; canvas.width = %f; canvas.height = %f;"
                          "document.body.appendChild(canvas);"
                          "var g = canvas.getContext('2d');"
                          "g.strokeRect(%f,%f,%f,%f);",
                          canvasId, width, height, 0.0f, 0.0f, width, height];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

- (void)scf_createCanvas:(NSString *)canvasId
              startPoint:(CGPoint)startPoint
                   width:(CGFloat)width
                  height:(CGFloat)height {
    NSString *jsString = [NSString stringWithFormat:
                          @"var canvas = document.createElement('canvas');"
                          "canvas.id = %@; canvas.width = %f; canvas.height = %f;"
                          "canvas.style.position = 'absolute';"
                          "canvas.style.top = '%f';"
                          "canvas.style.left = '%f';"
                          "document.body.appendChild(canvas);"
                          "var g = canvas.getContext('2d');"
                          "g.strokeRect(%f,%f,%f,%f);",
                          canvasId, width, height, startPoint.y, startPoint.x, 0.0f, 0.0f, width, height];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

- (void)scf_fillRectOnCanvas:(NSString *)canvasId
                  startPoint:(CGPoint)startPoint
                       width:(CGFloat)width
                      height:(CGFloat)height
                       color:(UIColor *)color {
    NSString *jsString = [NSString stringWithFormat:
                          @"var canvas = document.getElementById('%@');"
                          "var context = canvas.getContext('2d');"
                          "context.fillStyle = '%@';"
                          "context.fillRect(%f,%f,%f,%f);"
                          ,canvasId, [color scf_canvasColorString], startPoint.x, startPoint.y, width, height];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

- (void)scf_strokeRectOnCanvas:(NSString *)canvasId
                    startPoint:(CGPoint)startPoint
                         width:(CGFloat)width
                        height:(CGFloat)height
                         color:(UIColor *)color
                     lineWidth:(CGFloat)lineWidth {
    NSString *jsString = [NSString stringWithFormat:
                          @"var canvas = document.getElementById('%@');"
                          "var context = canvas.getContext('2d');"
                          "context.strokeStyle = '%@';"
                          "context.lineWidth = '%f';"
                          "context.strokeRect(%f,%f,%f,%f);"
                          ,canvasId, [color scf_canvasColorString], lineWidth, startPoint.x, startPoint.y, width, height];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

- (void)scf_clearRectOnCanvas:(NSString *)canvasId
                   startPoint:(CGPoint)startPoint
                        width:(CGFloat)width
                       height:(CGFloat)height {
    NSString *jsString = [NSString stringWithFormat:
                          @"var canvas = document.getElementById('%@');"
                          "var context = canvas.getContext('2d');"
                          "context.clearRect(%f,%f,%f,%f);"
                          ,canvasId, startPoint.x, startPoint.y, width, height];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

- (void)scf_arcOnCanvas:(NSString *)canvasId
            centerPoint:(CGPoint)centerPoint
                 radius:(CGFloat)radius
             startAngle:(CGFloat)startAngle
               endAngle:(CGFloat)endAngle
          anticlockwise:(BOOL)anticlockwise
                  color:(UIColor *)color {
    NSString *jsString = [NSString stringWithFormat:
                          @"var canvas = document.getElementById('%@');"
                          "var context = canvas.getContext('2d');"
                          "context.beginPath();"
                          "context.arc(%f,%f,%f,%f,%f,%@);"
                          "context.closePath();"
                          "context.fillStyle = '%@';"
                          "context.fill();",
                          canvasId, centerPoint.x, centerPoint.y, radius, startAngle, endAngle, anticlockwise ? @"true" : @"false", [color scf_canvasColorString]];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

- (void)scf_lineOnCanvas:(NSString *)canvasId
              beginPoint:(CGPoint)beginPoint
                endPoint:(CGPoint)endPoint
                   color:(UIColor *)color
               lineWidth:(CGFloat)lineWidth {
    NSString *jsString = [NSString stringWithFormat:
                          @"var canvas = document.getElementById('%@');"
                          "var context = canvas.getContext('2d');"
                          "context.beginPath();"
                          "context.moveTo(%f,%f);"
                          "context.lineTo(%f,%f);"
                          "context.closePath();"
                          "context.strokeStyle = '%@';"
                          "context.lineWidth = %f;"
                          "context.stroke();",
                          canvasId, beginPoint.x, beginPoint.y, endPoint.x, endPoint.y, [color scf_canvasColorString], lineWidth];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

- (void)scf_linesOnCanvas:(NSString *)canvasId
                   points:(NSArray *)points
                    color:(UIColor *)color
                lineWidth:(CGFloat)lineWidth {
    NSString *jsString = [NSString stringWithFormat:
                          @"var canvas = document.getElementById('%@');"
                          "var context = canvas.getContext('2d');"
                          "context.beginPath();",
                          canvasId];
    for (int i = 0; i < [points count] / 2; i++) {
        jsString = [jsString stringByAppendingFormat:@"context.lineTo(%@,%@);",
                    points[i * 2], points[i * 2 + 1]];
    }
    jsString = [jsString stringByAppendingFormat:@""
                "context.strokeStyle = '%@';"
                "context.lineWidth = %f;"
                "context.stroke();",
                [color scf_canvasColorString], lineWidth];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

- (void)scf_bezierCurveOnCanvas:(NSString *)canvasId
                     beginPoint:(CGPoint)beginPoint
                  controlPoint1:(CGPoint)cp1
                  controlPoint2:(CGPoint)cp2
                       endPoint:(CGPoint)endPoint
                          color:(UIColor *)color
                      lineWidth:(CGFloat)lineWidth {
    NSString *jsString = [NSString stringWithFormat:
                          @"var canvas = document.getElementById('%@');"
                          "var context = canvas.getContext('2d');"
                          "context.beginPath();"
                          "context.moveTo(%f,%f);"
                          "context.bezierCurveTo(%f,%f,%f,%f,%f,%f);"
                          "context.strokeStyle = '%@';"
                          "context.lineWidth = %f;"
                          "context.stroke();",
                          canvasId, beginPoint.x, beginPoint.y, cp1.x, cp1.y, cp2.x, cp2.y, endPoint.x, endPoint.y, [color scf_canvasColorString], lineWidth];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

- (void)scf_drawImageOnCanvas:(NSString *)canvasId
                        image:(NSString *)img
                           sx:(CGFloat)sx
                           sy:(CGFloat)sy
                       sWidth:(CGFloat)sWidth
                      sHeight:(CGFloat)sHeight
                            x:(CGFloat)x
                            y:(CGFloat)y
                        width:(CGFloat)width
                       height:(CGFloat)height {
    NSString *jsString = [NSString stringWithFormat:
                          @"var image = new Image();"
                          "image.src = '%@';"
                          "var canvas = document.getElementById('%@');"
                          "var context = canvas.getContext('2d');"
                          "context.drawImage(image,%f,%f,%f,%f,%f,%f,%f,%f)",
                          img, canvasId, sx, sy, sWidth, sHeight, x, y, width, height];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

@end
