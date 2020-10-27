//
//  YCGraphicsContextStackView.m
//  UI
//
//  Created by release on 2020/9/1.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCGraphicsContextStackView.h"

@implementation YCGraphicsContextStackView

- (void)drawRect:(CGRect)rect{
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2.描述路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 120)];
    [path addLineToPoint:CGPointMake(220, 120)];
    //3.把路径添加到上下文上
    CGContextAddPath(ctx,path.CGPath);
    //保存上下文的状态
    CGContextSaveGState(ctx);
    //设置上下文的状态
    CGContextSetLineWidth(ctx, 10);
    [[UIColor redColor]set];
    //4.把上下文的内容渲染到View上
    CGContextStrokePath(ctx);
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(120, 20)];
    [path2 addLineToPoint:CGPointMake(120, 220)];
    CGContextAddPath(ctx,path2.CGPath);
    CGContextRestoreGState(ctx);
    CGContextStrokePath(ctx);
    
}

@end
