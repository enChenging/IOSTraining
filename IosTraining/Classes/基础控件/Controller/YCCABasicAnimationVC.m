//
//  YCCABasicAnimationVC.m
//  UI
//
//  Created by release on 2020/9/12.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCCABasicAnimationVC.h"

@interface YCCABasicAnimationVC ()
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIImageView *heartV;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *pageV;

@end

@implementation YCCABasicAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self basicAnimation];
//    [self heartAnimation];
//    [self keyFrameAnimation];
//    [self keyFrameAnimation2];
//    [self transiton];
    [self groupAnim];
}

-(void)basicAnimation{
    //1.初始化一个核心动画
    CABasicAnimation *anim = [CABasicAnimation animation];
    //2.设置属性
    anim.keyPath = @"transform.scale.x";
    anim.toValue = @0.5;
    
    //设置执行完毕，不要删除动画
    anim.removedOnCompletion = NO;
    //设置让动画效果最后执行样子
    anim.fillMode = kCAFillModeForwards;
    //3.添加动画
    [self.redView.layer addAnimation:anim forKey:nil];
}

-(void)heartAnimation{
    //创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    //设置属性值
    anim.keyPath = @"transform.scale";
    anim.toValue = @0;
    //设置动画执行次数
    anim.repeatCount = MAXFLOAT;
    //设置动画的执行时长
    anim.duration = 0.5;
    //自动反转
    anim.autoreverses = YES;

    [self.heartV.layer addAnimation:anim forKey:nil];
}

-(void)keyFrameAnimation{
    //添加动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    //设置属性值
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(angle2Rad(-5)),@(angle2Rad(5)),@(angle2Rad(-5))];
    
    //设置次数
    anim.repeatCount = MAXFLOAT;
    //执行时长
    anim.duration = 0.5;
    //自动反转
//    anim.autoreverses = YES;
    
//    [self.iconView.layer addAnimation:anim forKey:nil];
     [self.iconView.layer addAnimation:anim forKey:nil];
}

-(void)keyFrameAnimation2{
    //添加动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    //根据路径做动画
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(300, 50)];
    [path addLineToPoint:CGPointMake(300, 400)];
    [path addLineToPoint:CGPointMake(50, 400)];
    
    anim.keyPath = @"position";
    anim.path = path.CGPath;
    anim.removedOnCompletion = NO;
    anim.duration = 1;
    anim.fillMode = kCAFillModeForwards;
    
    [self.iconView.layer addAnimation:anim forKey:nil];
}

static int _i = 0;
-(void)transiton{
    //专场代码跟转场动画必须得在同一个方法中
    //转场代码
    _i++;
    if (_i > 3) {
        _i = 1;
    }
    
    self.pageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"page%d",_i]];
    
    //添加转场动画
    CATransition *anim = [CATransition animation];
    anim.duration = 1;
    //设置动画的起始点
    anim.startProgress = 0.3;
    //设置动画的截止点
    anim.endProgress = 1;
    
    /**
     fade 交叉淡化过度
     push 新视图把旧视图推出去
     moveIn 新视图移动到旧视图上
     reveal 将旧视图移开，显示下面的新视图
     cube 立方体的翻滚效果
     oglFlip 上下左右翻滚效果
     suckEffect 收缩效果，如一块布被抽走
     rippleEffect 水滴效果
     pageCurl 向上翻页效果
     pageUnCurl 向下翻页效果
     cameraIrisHollowOpen 相机镜头打开效果
     cameraIrisHollowClose 相机镜头关闭效果
     */
    //设置转场类型
    anim.type = @"pageCurl";
    
    [self.pageV.layer addAnimation:anim forKey:nil];
}

-(void)groupAnim{
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale";
    anim.toValue = @0.5;
//    anim.removedOnCompletion = NO;
//    anim.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *anim2 = [CABasicAnimation animation];
    anim2.keyPath = @"position.y";
    anim2.toValue = @400;
//    anim2.removedOnCompletion = NO;
//    anim2.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *anim3 = [CABasicAnimation animation];
    anim3.keyPath = @"position.rotation";
    anim3.toValue = @(M_PI);
//    anim3.removedOnCompletion = NO;
//    anim3.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *groupAnim = [CAAnimationGroup animation];
    groupAnim.animations = @[anim,anim2,anim3];
    groupAnim.removedOnCompletion = NO;
    groupAnim.fillMode = kCAFillModeForwards;
    [self.redView.layer addAnimation:groupAnim forKey:nil];
}

@end
