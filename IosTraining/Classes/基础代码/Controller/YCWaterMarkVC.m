//
//  YCWaterMarkVC.m
//  UI
//
//  Created by release on 2020/9/1.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCWaterMarkVC.h"

@interface YCWaterMarkVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIImageView *imageCircle;

@end

@implementation YCWaterMarkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self waterMark];
    [self cropCircle];
}

-(void)cropCircle{
    //1.加载图片
    UIImage *image = [UIImage imageNamed:@"火影"];
    //2.开启一个跟图片原始大小的上下文
    CGFloat borderW = 10;
    CGSize size = CGSizeMake(image.size.width+2*borderW, image.size.height+2*borderW);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //3.设置一个圆形裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [[UIColor redColor]set];
    [path fill];
    //绘制一个小圆，把小圆设置成裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, image.size.width, image.size.height)];
    //把图片路径设置成裁剪区域
    [clipPath addClip];
    //4.把图片绘制到上下文中
    [image drawAtPoint:CGPointMake(borderW, borderW)];
    //5.从上下文中生成一张图片（把上下文中绘制的所有内容，生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //6.关闭上下文
    UIGraphicsEndImageContext();
    
    self.imageCircle.image = newImage;
}

-(void)waterMark{
    //1.加载图片
    UIImage *image = [UIImage imageNamed:@"bg"];
    //2.开启一个跟图片原始大小的上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //3.把图片绘制到上下文中
    [image drawAtPoint:CGPointZero];
    //4.把文字绘制到上下文中
    NSString *str = @"release";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //字体大小
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:120];
    //设置颜色
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //设置描边
    //    dict[NSStrokeColorAttributeName] = [UIColor redColor];
    //    dict[NSStrokeWidthAttributeName] = @1;
    //设置阴影
    //    NSShadow *shaw = [[NSShadow alloc]init];
    //    shaw.shadowColor = [UIColor blueColor];
    //设置阴影的偏移量
    //    shaw.shadowOffset = CGSizeMake(10, 10);
    //    shaw.shadowBlurRadius = 2;
    //    dict[NSShadowAttributeName] = shaw;
    
    [str drawAtPoint:CGPointMake(10, 20) withAttributes:dict];
    //5.从上下文中生成一张图片（把上下文中绘制的所有内容，生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //6.关闭上下文
    UIGraphicsEndImageContext();
    
    self.imageV.image = newImage;
}
- (IBAction)cropScreenClick:(id)sender {
    
    //1.开启一个位图上下文
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    //2.把UIView上面的东西绘制到上下文中
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:ctx];
    //3.从上下文中生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭上下文
    UIGraphicsEndImageContext();
    
    NSData *data = UIImagePNGRepresentation(newImage);
    [data writeToFile:@"/Users/releasemr./Desktop/newImage.png" atomically:YES];
}




@end
