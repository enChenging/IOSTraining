//
//  YCImageSwipeVC.m
//  UI
//
//  Created by release on 2020/9/2.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCImageSwipeVC.h"

@interface YCImageSwipeVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation YCImageSwipeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.imageV addGestureRecognizer:pan];
}

-(void)pan:(UIPanGestureRecognizer *)pan{
    //获取当前手指的点
    CGPoint curP = [pan locationInView:self.imageV];
    
    //确定擦除区域
    CGFloat rectWH = 30;
    CGFloat x = curP.x -rectWH * 0.5;
    CGFloat y = curP.y - rectWH * 0.5;
    CGRect rect = CGRectMake(x, y, rectWH, rectWH);
    
    //生成一张透明擦初区域的图片
    //1.开启图片上下文  NO：为透明
    UIGraphicsBeginImageContextWithOptions(self.imageV.bounds.size, NO, 0);
    //2.把imageV内容渲染到当前上下文中
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.imageV.layer renderInContext:ctx];
    //3.擦除上下文中的指定区域
    CGContextClearRect(ctx, rect);
    //4.从上下文中取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.imageV.image = newImage;
}


@end
