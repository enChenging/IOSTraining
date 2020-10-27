//
//  YCDrawRoundView.m
//  UI
//
//  Created by release on 2020/9/1.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCDrawRoundView.h"

@implementation YCDrawRoundView


- (void)drawRect:(CGRect)rect {
    
//    [self drawRect];
    //画圆
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 100)];
//     [path fill];
    //椭圆
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 50)];
//    [path stroke];
   
    //画弧
    //clockwise: YES为顺时针 NO为逆时针
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = rect.size.height * 0.5 -10;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    //添加一根线到圆心
    [path addLineToPoint:center];
    //从路径终点连接一根线到路径的起点
    [path closePath];
    [path stroke];
}

/**
 画矩形/圆形
 */
-(void)drawRect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 100, 100)];
    //圆形
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 100, 100) cornerRadius:50];
    [[UIColor yellowColor]set];
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
}

@end
