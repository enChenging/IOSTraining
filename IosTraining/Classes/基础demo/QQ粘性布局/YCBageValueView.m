//
//  YCBageValueView.m
//  UI
//
//  Created by release on 2020/9/15.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCBageValueView.h"

@interface YCBageValueView()

@property(nonatomic,weak)UIView *smallCircl;

@property(nonatomic,weak)CAShapeLayer *shapL;

@end
@implementation YCBageValueView

- (CAShapeLayer *)shapL{
    if (_shapL == nil) {
        CAShapeLayer *shapL = [CAShapeLayer layer];
        [self.superview.layer insertSublayer:shapL atIndex:0];
        shapL.fillColor = [UIColor redColor].CGColor;
        _shapL = shapL;
    }
    
    return _shapL;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUp];
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action: @selector(pan:)];
    [self addGestureRecognizer:pan];
}

-(void)pan:(UIPanGestureRecognizer *)pan{
    //拖动
    CGPoint transP = [pan translationInView:self];
    //transform 并没有修改center，它修改的是frame
//    self.transform  = CGAffineTransformTranslate(self.transform, transP.x, transP.y);
    CGPoint center = self.center;
    center.x += transP.x;
    center.y += transP.y;
    self.center = center;
    //复位
    [pan setTranslation:CGPointZero inView:self];
    
    CGFloat distance = [self distanceWithSmallCircle:self.smallCircl BigCircle:self];

    //让小圆半径根据距离的增大，半径减小
    CGFloat smallR = self.bounds.size.width * 0.5;
    smallR -= distance / 10.0;
    self.smallCircl.bounds = CGRectMake(0, 0, smallR * 2, smallR *2);
    self.smallCircl.layer.cornerRadius = smallR;
    
    UIBezierPath *path = [self pathWithSmallCircle:self.smallCircl BigCircle: self];
    
    //形状图层
    if (self.smallCircl.hidden == NO) {
        self.shapL.path = path.CGPath;
    }

    if (distance > 60) {
        //让小圆隐藏，让路径隐藏
        self.smallCircl.hidden = YES;
        [self.shapL removeFromSuperlayer];
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        //判断距离是否大于60
        //大于60让按钮消失
        if (distance < 60) {
            //小于60复位
            [self.shapL removeFromSuperlayer];
            self.center = self.smallCircl.center;
            self.smallCircl.hidden = NO;
        }else{
            self.backgroundColor = [UIColor clearColor];//隐藏大圆背景颜色
            //播放一个动画消失
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:self.bounds];
            
            NSMutableArray *imageArray = [NSMutableArray array];
            for (int i = 0; i < 8; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"heart%d",i]];
                [imageArray addObject:image];
            }
            
            imageV.animationImages = imageArray;
            imageV.animationDuration = 1;
            [imageV startAnimating];
            [self addSubview:imageV];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                [self removeFromSuperview];
            });
        }
    }
    
}

/**
 给两个圆，描述一个不规则的路径
 */
-(UIBezierPath *)pathWithSmallCircle:(UIView *)smallCircle BigCircle:(UIView *)bigCircle{
    
    CGFloat x1 = smallCircle.center.x;
    CGFloat y1 = smallCircle.center.y;
    
    CGFloat x2 = bigCircle.center.x;
    CGFloat y2 = bigCircle.center.y;
    
    CGFloat d = [self distanceWithSmallCircle:smallCircle BigCircle:bigCircle];
    
    if (d <=0) {
        return nil;
    }
    
    CGFloat cosθ = (y2 - y1) / d;
    CGFloat sinθ = (x2 - x1) / d;
    CGFloat r1 = smallCircle.bounds.size.width * 0.5;
    CGFloat r2 = bigCircle.bounds.size.width * 0.5;
    
    //描述点
    CGPoint pointA = CGPointMake(x1 - r1 * cosθ, y1 + r1 * sinθ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosθ, y1 - r1 * sinθ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosθ, y2 - r2 * sinθ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosθ, y2 + r2 * sinθ);
    CGPoint pointO = CGPointMake(pointA.x + d * 0.5 * sinθ, pointA.y + d*0.5*cosθ);
    CGPoint pointP = CGPointMake(pointB.x + d * 0.5 * sinθ, pointB.y + d*0.5*cosθ);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //AB
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    //BC（曲线）
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    //CD
    [path addLineToPoint:pointD];
    //DA(曲线)
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    
    return path;
}
/**
 求两个圆之间的距离
 */
-(CGFloat)distanceWithSmallCircle:(UIView *)smallCircle BigCircle:(UIView *)bigCircle{
    
    //x轴方向的偏移量
    CGFloat offsetX = bigCircle.center.x  - smallCircle.center.x;
    //y轴方向的偏移量
    CGFloat offsetY = bigCircle.center.y  - smallCircle.center.y;
    
    return sqrt(offsetX * offsetX + offsetY * offsetY);
}

-(void)setUp{
    
    //圆角
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    //设置背景颜色
    [self setBackgroundColor:[UIColor redColor]];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:12];


    //添加小圆
    UIView *smallCircle = [[UIView alloc]initWithFrame:self.frame];
    smallCircle.layer.cornerRadius = self.layer.cornerRadius;
    smallCircle.layer.backgroundColor = self.layer.backgroundColor;
    
    self.smallCircl = smallCircle;
    [self.superview addSubview:smallCircle];
    //把一个UIView添加到指定的位置
    [self.superview insertSubview:smallCircle belowSubview:self];
    
}

@end
