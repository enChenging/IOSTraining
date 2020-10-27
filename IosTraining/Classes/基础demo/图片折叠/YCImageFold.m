//
//  YCImageFold.m
//  UI
//
//  Created by release on 2020/9/15.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCImageFold.h"

@interface YCImageFold ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageV;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageV;
@property(nonatomic,weak)CAGradientLayer *gradientL;

@end

@implementation YCImageFold

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.让上部分图片只显示上半部
    self.topImageV.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    //2.让下部分图片只显示下半部分
    self.bottomImageV.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    
    self.topImageV.layer.anchorPoint = CGPointMake(0.5, 1);
    self.bottomImageV.layer.anchorPoint = CGPointMake(0.5, 0);
    
    
    //渐变层
    CAGradientLayer *gradientL = [CAGradientLayer layer];
    gradientL.frame = self.bottomImageV.bounds;
    //设置渐变的颜色
    gradientL.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
    //设置渐变透明
    gradientL.opacity = 0;
    self.gradientL = gradientL;
    [self.bottomImageV.layer addSublayer:gradientL];
}

-(void)gradientLayer{
    //渐变层
    CAGradientLayer *gradientL = [CAGradientLayer layer];
    gradientL.frame = self.bottomImageV.bounds;
    //设置渐变的颜色
    gradientL.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor yellowColor].CGColor];
    //设置渐变的方向
    gradientL.startPoint = CGPointMake(0, 0);
    gradientL.endPoint = CGPointMake(1, 0);
    //设置一个渐变到另一个渐变的起始位置
    gradientL.locations  = @[@0.2,@0.6];
    [self.bottomImageV.layer addSublayer:gradientL];
}

- (IBAction)pan:(UIPanGestureRecognizer *)pan {
    //获取移动的偏移量
    CGPoint transP = [pan translationInView:pan.view];
    //让上部分图片开始旋转
//    NSLog(@"transP.y == %f",transP.y);
    CGFloat angle = transP.y * M_PI / 128;
    
    self.gradientL.opacity = transP.y * 1 / 128.0;
    
    //近大远小
    CATransform3D transform = CATransform3DIdentity;
    //眼睛离屏幕的距离
    transform.m34 = -1 / 300.0;
    
//    self.topImageV.layer.transform = CATransform3DMakeRotation(-angle, 1, 0, 0);
    self.topImageV.layer.transform = CATransform3DRotate(transform, -angle, 1, 0, 0);
    
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        //上部的图片复位
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.topImageV.layer.transform = CATransform3DIdentity;
        } completion:nil];
    }
}

@end
