//
//  YCSnowflakeView.m
//  UI
//
//  Created by release on 2020/9/1.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCSnowflakeView.h"

@implementation YCSnowflakeView


- (void)awakeFromNib{
    [super awakeFromNib];
//    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeY) userInfo:nil repeats:YES];
    
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeY)];
    //每一次屏幕刷新的时候就会调用指定的方法（屏幕每一秒刷新60次）
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

static int _snowY = 0;

/**
 setNeedsDisplay会调用drawRect:但是并不是立马调用，只是设定了一个标志，当下一次屏幕刷新的时候去调用drawRect:
 */
-(void)changeY{
    _snowY += 5;
    if (_snowY > kScreenHeight) {
        _snowY = 0;
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    
    UIImage *image = [UIImage imageNamed:@"雪花"];
    [image drawAtPoint:CGPointMake(0, _snowY+50)];
}

@end
