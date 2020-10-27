//
//  YCProgressView.m
//  UI
//
//  Created by release on 2020/9/1.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCProgressView.h"

@implementation YCProgressView

- (void)setProgressValue:(CGFloat)progressValue{
    _progressValue = progressValue;
    
    //重绘（系统自动帮你调用drawRect:）
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    //画弧
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radus = rect.size.height * 0.5 -10;
    CGFloat startA = -M_PI_2;
    CGFloat angle = self.progressValue * M_PI * 2;
    NSLog(@"self.progressValue === %f",self.progressValue);
    CGFloat endA = startA + angle;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radus startAngle:startA endAngle:endA clockwise:YES];
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
}

@end
