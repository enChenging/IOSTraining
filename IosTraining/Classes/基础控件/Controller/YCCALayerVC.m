//
//  YCCALayerVC.m
//  UI
//
//  Created by release on 2020/9/11.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCCALayerVC.h"

@interface YCCALayerVC ()
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) CALayer *layer;
@end

@implementation YCCALayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self UIViewLayer];
    [self UIImageVLayer];
    [self customLayer];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    self.redView.layer.position = self.view.center;
    //anchorPoint为锚点，默认（0.5，0.5），运行后锚点会自动定位到position点的位置
//    self.redView.layer.anchorPoint = CGPointMake(0, 0);
    
//    [self CATransform3D];
    
    [self implicitAnimation];
}

-(void)UIViewLayer{
    //默认是自带阴影的效果，只不过是透明的，1为不透明
    self.redView.layer.shadowOpacity = 1;
    //设置阴影的颜色
    self.redView.layer.shadowColor = [UIColor yellowColor].CGColor;
    //设置阴影的偏移量
    self.redView.layer.shadowOffset = CGSizeMake(10, 10);
    //设置阴影的模糊度
    self.redView.layer.shadowRadius = 10;
    
    //设置边框
    self.redView.layer.borderColor = [UIColor greenColor].CGColor;
    //设置的边框他是往里面走
    self.redView.layer.borderWidth = 3;
    //设置圆角半径
    self.redView.layer.cornerRadius = 50;
}

-(void)UIImageVLayer{
    //默认是自带阴影的效果，只不过是透明的，1为不透明
    self.imageV.layer.shadowOpacity = 1;
    //设置阴影的颜色
    self.imageV.layer.shadowColor = [UIColor yellowColor].CGColor;
    //设置阴影的偏移量
    self.imageV.layer.shadowOffset = CGSizeMake(10, 10);
    //设置阴影的模糊度
    self.imageV.layer.shadowRadius = 10;
    
    //设置的所有属性是直接作用在layer
    //UIImageView当中image它并不是直接添加到layer.它是添加到contents这个里面
    //设置边框
    self.imageV.layer.borderColor = [UIColor greenColor].CGColor;
    //设置的边框他是往里面走
    self.imageV.layer.borderWidth = 3;
    //设置圆角半径
    self.imageV.layer.cornerRadius = 50;
    
    //设置超过根层以外的内容都给裁剪掉
    self.imageV.layer.masksToBounds = YES;
}

-(void)CATransform3D{
    
    [UIView animateWithDuration:1 animations:^{
        //x,y,z轴，z轴朝向自己
        //旋转
        self.imageV.layer.transform = CATransform3DMakeRotation(M_PI, 1, 1, 0);
        //平移
//        self.imageV.layer.transform = CATransform3DMakeTranslation(100, 100, 0);
//        //缩放
//        self.imageV.layer.transform = CATransform3DMakeScale(1.2, 1.2, 0);
        
        //KVC
        //把结构体转为对象
//        NSValue *value = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 1, 0)];
        //想要做一些快速平移，缩放，旋转的时候可以用KVC
        //rotation.x rotation.y rotation.z rotation
        //scale.x scale.y scale.z scale
        //translation.x translation.y translation.z translation
        [self.imageV.layer setValue:@(M_PI) forKeyPath:@"transform.rotation.z"];
    }];
}

-(void)customLayer{
    CALayer *layer = [CALayer layer];
    layer.frame  = CGRectMake(30, 200, 50, 50);
    layer.backgroundColor = [UIColor redColor].CGColor;
//    layer.contents = (id)[UIImage imageNamed:@"火影"].CGImage;
    self.layer = layer;
    [self.view.layer addSublayer:layer];
}

-(void)implicitAnimation{
    //开启一个事务
//    [CATransaction begin];
    //操作动画执行时常
    [CATransaction setAnimationDuration:2];
    //取消动画
//    [CATransaction setDisableActions:YES];
    
    self.layer.backgroundColor = [self randomColor].CGColor;
    self.layer.cornerRadius = arc4random_uniform(50);
    self.layer.position = CGPointMake(arc4random_uniform(300), arc4random_uniform(400));
//    [CATransaction commit];
    
}

-(UIColor *)randomColor{
    CGFloat r = arc4random_uniform(256)/255.0;
    CGFloat g = arc4random_uniform(256)/255.0;
    CGFloat b = arc4random_uniform(256)/255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

@end
