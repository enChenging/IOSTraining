//
//  YCGraphicsContextMatrixView.m
//  UI
//
//  Created by release on 2020/9/1.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCGraphicsContextMatrixView.h"

@implementation YCGraphicsContextMatrixView

- (void)drawRect:(CGRect)rect{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 50)];
    
    //平移
    CGContextTranslateCTM(ctx, 100, 100);
    //旋转
    CGContextRotateCTM(ctx, M_PI_4);
    //缩放
    CGContextScaleCTM(ctx, 1.5, 1.5);
    
    CGContextAddPath(ctx, path.CGPath);
    [[UIColor redColor]set];
    CGContextFillPath(ctx);
}

@end
