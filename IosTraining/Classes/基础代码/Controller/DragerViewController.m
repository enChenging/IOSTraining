//
//  DragerViewController.m
//  UI
//
//  Created by release on 2020/9/1.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "DragerViewController.h"

@interface DragerViewController ()

@end

@implementation DragerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控件
    [self setUp];
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.mainV addGestureRecognizer:pan];
    
    //给控制器的View添加点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}

-(void)tap{
    //让MainV复位
    [UIView animateWithDuration:0.5 animations:^{
        self.mainV.frame = self.view.bounds;
    }];
}

#define targetR 275
#define targetL -275
-(void)pan:(UIPanGestureRecognizer *)pan{
    //获取偏移量
    CGPoint transP = [pan translationInView:self.mainV];
    //不使用transform，是因为我们还要去修改高度，使用transform,只能修改x,y
//    self.mainV.transform = CGAffineTransformTranslate(self.mainV.transform, transP.x
//                                                      , transP.y);
    
    self.mainV.frame = [self frameWithOffsetX:transP.x];
    //判断拖动的方向
    if (self.mainV.frame.origin.x > 0) {
        //向右
        self.rightV.hidden = YES;
    }else if(self.mainV.frame.origin.x < 0){
        //向左
        self.rightV.hidden = NO;
    }
    
    //当手指松开时，做自动定位
    //CGRectGetMaxX 获取当前控件的x坐标值+宽度的数值
    CGFloat target = 0;
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (self.mainV.frame.origin.x > kScreenWidth * 0.5) {
            //判断在右侧
            target = targetR;
            NSLog(@"右侧 === %f",self.mainV.frame.origin.x);
        }else if (CGRectGetMaxX(self.mainV.frame) < kScreenWidth * 0.5){
            //判断在左侧
            target = targetL;
             NSLog(@"左侧 === %f",CGRectGetMaxX(self.mainV.frame));
        }
        
        //计算当前mainV的frame
        CGFloat offset = target - self.mainV.frame.origin.x;
        
        [UIView animateWithDuration:0.5 animations:^{
            self.mainV.frame = [self frameWithOffsetX:offset];
        }];
    }
    
    //复位
    [pan setTranslation:CGPointZero inView:self.mainV];
}

#define maxY 200
-(CGRect)frameWithOffsetX:(CGFloat)offsetX{
    CGRect frame = self.mainV.frame;
//    NSLog(@"x === %f",frame.origin.x);
    frame.origin.x += offsetX;
    
    CGFloat y = fabs(frame.origin.x * maxY/kScreenWidth);
    frame.origin.y = y;
    
    //屏幕的高度减去两倍的Y值
    frame.size.height = self.view.bounds.size.height - (2*y);
    
    YCLog(@"-----frame---%fd",frame.size.height);
    return  frame;
}

-(void)setUp{
    //leftV
    UIView *leftV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    leftV.backgroundColor = [UIColor blueColor];
    _leftV = leftV;
    [self.view addSubview:leftV];
    //rightV
    UIView *rightV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    rightV.backgroundColor = [UIColor greenColor];
    _rightV = rightV;
    [self.view addSubview:rightV];
    //mainV
    UIView *mainV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    mainV.backgroundColor = [UIColor redColor];
    _mainV = mainV;
    [self.view addSubview:mainV];
}

@end
