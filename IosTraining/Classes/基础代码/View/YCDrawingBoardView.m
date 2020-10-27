//
//  YCDrawingBoardView.m
//  UI
//
//  Created by release on 2020/9/3.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCDrawingBoardView.h"
#import "YCBezierPath.h"

@interface YCDrawingBoardView()
//当前绘制的路径
@property(nonatomic,strong)UIBezierPath *path;
//保存当前绘制的所有路径
@property(nonatomic,strong)NSMutableArray *allPathArray;
//当前路径的线宽
@property(nonatomic,assign)CGFloat width;
//当前路径的线宽
@property(nonatomic,assign)UIColor *color;

@end


@implementation YCDrawingBoardView

- (NSMutableArray *)allPathArray{
    if (!_allPathArray) {
        _allPathArray = [NSMutableArray array];
    }
    return _allPathArray;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    self.width = 1;
    self.color = [UIColor blackColor];
}

-(void)pan:(UIPanGestureRecognizer *)pan{
    
    //获取当前手指的点
    CGPoint curP = [pan locationInView:self];
    if (pan.state == UIGestureRecognizerStateBegan) {
        //创建路径
        YCBezierPath *path = [YCBezierPath bezierPath];
        self.path = path;
        //设置起点
        [path moveToPoint:curP];
        //设置线的宽度
        [path setLineWidth:self.width];
        //设置线的颜色
        path.color = self.color;
        [self.allPathArray addObject:path];
    }else if (pan.state == UIGestureRecognizerStateChanged){
        //绘制一根线到当前手指所在的点
        [self.path addLineToPoint:curP];
        //重绘
        [self setNeedsDisplay];
    }
    
}

- (void)drawRect:(CGRect)rect{
    //绘制当前路径
    for (YCBezierPath *path in self.allPathArray) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)path;
            [image drawInRect:rect];
        }else{
            //设置线的颜色
            [path.color set];
            [path stroke];
        }
    }
    
}

/**
 清屏
 */
- (void)clear{
    [self.allPathArray removeAllObjects];
    [self setNeedsDisplay];
}

/**
 撤销
 */
- (void)undo{
    [self.allPathArray removeLastObject];
    [self setNeedsDisplay];
}

/**
 橡皮擦
 */
- (void)erase{
    [self setLineColor:[UIColor whiteColor]];
}
/**
 设置线的宽度
 */
- (void)setLineWith:(CGFloat)lineWith{
    self.width = lineWith;
    
}

/**
 设置线的颜色
 */
- (void)setLineColor:(UIColor *)color{
    self.color = color;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    //将图片添加到数组中
    [self.allPathArray addObject:image];
    [self setNeedsDisplay];
}


@end
