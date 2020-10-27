//
//  TimerViewController.m
//  UI
//
//  Created by release on 2019/11/8.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()

@end

@implementation TimerViewController

//@synthesize timer = _timerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    
    UIButton * btn01 = [[UIButton alloc]initWithFrame:CGRectMake(150, 100, 120, 100)];
    [btn01 setTitle:@"启动定时器" forState:UIControlStateNormal];
    [btn01 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn01 addTarget:self action:@selector(pressBtn01:) forControlEvents:UIControlEventTouchUpInside];
    btn01.tag = 101;
    
    UIButton *btn02 = [[UIButton alloc]initWithFrame:CGRectMake(150, 200, 120,100)];
    [btn02 setTitle:@"停止定时器" forState:UIControlStateNormal];
    [btn02 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn02 addTarget:self action:@selector(pressBtn01:) forControlEvents:UIControlEventTouchUpInside];
    btn02.tag = 102;
    
    UIView* cview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    cview.backgroundColor = [UIColor magentaColor];
    cview.tag = 103;

    
    [self.view addSubview:btn01];
    [self.view addSubview:btn02];
    [self.view addSubview:cview];
}

-(void)pressBtn01:(UIButton*)btn{
    switch (btn.tag) {
        case 101:
            if (!_timerView || (!_timerView.isValid && _timerView)) {
                YCLog(@"启动定时器");
                _timerView =  [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(updateTime:) userInfo:@"用户嘻嘻" repeats:YES];
            }
            break;
        case 102:
            if (_timerView) {
                [self stopTimer];
            }
            break;
            
        default:
            break;
    }
    YCLog(@"timer--%@",_timerView.isValid?@"YES":@"NO");
}

-(void)updateTime:(NSTimer*)timer{
    YCLog(@"Update--%@",timer.userInfo);
    UIView* cview = [self.view viewWithTag:103];
    cview.frame = CGRectMake(cview.frame.origin.x+0.2, cview.frame.origin.y+1, 60, 60);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopTimer];
}

-(void)stopTimer{
    YCLog(@"停止定时器");
    if (_timerView) {
             if ([_timerView isValid]) {
                 [_timerView invalidate];
                 _timerView = nil;
             }
         }
}
@end
