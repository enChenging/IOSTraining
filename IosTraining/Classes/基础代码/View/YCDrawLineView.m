//
//  YCDrawLineView.m
//  UI
//
//  Created by release on 2020/9/1.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCDrawLineView.h"

@implementation YCDrawLineView

/**
 作用：专门用来绘图
 调用时间：当View显示的时候调用
 rect:当前View的bounds
 */
- (void)drawRect:(CGRect)rect {
    //1.获取上下文（获取，创建上下文都以UIGraphics开头）
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2.绘制路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    //2.1设置起点
    [path moveToPoint:CGPointMake(50, 180)];
    //2.2添加一根线到终点
    [path addLineToPoint:CGPointMake(280, 50)];
    [path addLineToPoint:CGPointMake(200, 180)];
    
    //设置线的宽度
    CGContextSetLineWidth(ctx, 10);
    //设置线的连接样式
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    //设置线的顶角样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    //设置颜色
    [[UIColor redColor] set];
    
    //3.把绘制的内容添加到上下文当中
    CGContextAddPath(ctx, path.CGPath);
    //4.把上下文的内容显示到View上（渲染到View的layer）
    CGContextStrokePath(ctx);
    
}


@end
