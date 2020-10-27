//
//  YCWheelView.m
//  UI
//
//  Created by release on 2020/9/12.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCWheelView.h"
#import "YCWheelBtn.h"

@interface YCWheelView()<CAAnimationDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *contentV;

//当前选中的按钮
@property (weak, nonatomic) UIButton *selectBtn;

@property(nonatomic,strong)CADisplayLink *link;

@end

@implementation YCWheelView

- (CADisplayLink *)link{
    if (_link == nil) {
        //添加定时器，保持一直旋转
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        _link = link;
    }
    
    return _link;
}

+ (instancetype)wheelView{
    return [[[NSBundle mainBundle]loadNibNamed:@"WheelView" owner:nil options:nil]lastObject];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"WheelView" owner:nil options:nil]lastObject];
    }
    return self;
    //    NSLog(@"%f",[UIScreen mainScreen].scale);“
}


- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.contentV.userInteractionEnabled = YES;
    CGFloat btnW = 68;
    CGFloat btnH = 143;
    CGFloat angle = 0;
    
    //1.加载要截取的原始图片
    UIImage *oriImage = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *oriSelImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    CGFloat clipW = oriImage.size.width / 12.0 * 2;
    CGFloat clipH = oriImage.size.height * 2;
    CGFloat clipX = 0;
    CGFloat clipY = 0;
    
    for (int i = 0; i < 12; i++) {
        YCWheelBtn *btn = [YCWheelBtn buttonWithType:UIButtonTypeCustom];
        btn.bounds = CGRectMake(0, 0, btnW, btnH);
        
//        [btn setBackgroundColor:[UIColor blueColor]];
        
        //设置选中状态下的背景图片
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        //设置按钮位置
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.layer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        //让第一个按钮在上一个基础上面旋转30
        btn.transform = CGAffineTransformMakeRotation(angle2Rad(angle));
        angle += 30;
        
        clipX = i * clipW;
        //设置按钮的图片
        //正常状态下
        //CGImageCreateWithImageInRect 使用的坐标都是以像素点（在ios当中使用的都是坐标）
        //指定一个图片，指定一个区域，根据区域，从给定的图片当中，截取一张新的图片
        CGImageRef clipImage = CGImageCreateWithImageInRect(oriImage.CGImage, CGRectMake(clipX, clipY, clipW, clipH));
        [btn setImage:[UIImage imageWithCGImage:clipImage]forState:UIControlStateNormal];
        
        //选中状态下
        CGImageRef clipSelImage = CGImageCreateWithImageInRect(oriSelImage.CGImage, CGRectMake(clipX, clipY, clipW, clipH));
        [btn setImage:[UIImage imageWithCGImage:clipSelImage]forState:UIControlStateSelected];
        
        [self.contentV addSubview:btn];
        //监听按钮的点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        //默认第一个成为选中状态
        if (i == 0) {
            [self btnClick:btn];
        }
    }
}

-(void)btnClick:(UIButton *)btn{
    
    //让当前选中的按钮取消选中状态
    self.selectBtn.selected = NO;
    //让当前点击的按钮成为选中状态
    btn.selected = YES;
    //把当前点击的按钮成为当前选中按钮
    self.selectBtn = btn;
}

- (void)startRotation{
    self.link.paused = NO;

}

-(void)update{
    self.contentV.transform = CGAffineTransformRotate(self.contentV.transform,M_PI/200.0);
}

- (void)stopRatation{
    self.link.paused = YES;
}

/**
开始选号
*/
- (IBAction)startChoose:(id)sender {
    
    //让转盘快速旋转几圈，当前选中的按钮指向最上方
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath  = @"transform.rotation";
    anim.toValue = @(M_PI * 4);
    anim.duration = 0.5;
    anim.delegate = self;
    [self.contentV.layer addAnimation:anim forKey:nil];
}

//当动画结束时调用
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //动画结束时当前选中的按钮指向最上方
    //让当前选中的按钮副控件倒着旋转回去
    
    //获取当前选中按钮旋转的角度
    CGAffineTransform transform = self.selectBtn.transform;
    //通过transform获取旋转的度数
    CGFloat angle = atan2(transform.b,transform.a);
    
    self.contentV.transform = CGAffineTransformMakeRotation(-angle);
}

@end
