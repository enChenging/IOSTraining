//
//  YCDrawCurveView.m
//  UI
//
//  Created by release on 2020/9/1.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCDrawCurveView.h"

@implementation YCDrawCurveView


- (void)drawRect:(CGRect)rect {
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2.描述路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    //画曲线
    [path moveToPoint:CGPointMake(50, 180)];
    [path addQuadCurveToPoint:CGPointMake(250, 180) controlPoint:CGPointMake(50, 50)];
    //3.把路径添加到上下文上
    CGContextAddPath(ctx,path.CGPath);
    //4.把上下文的内容渲染到View上
    CGContextStrokePath(ctx);
}


@end
