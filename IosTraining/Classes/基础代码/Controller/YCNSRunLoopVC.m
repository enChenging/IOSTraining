//
//  YCNSRunLoopVC.m
//  IosTraining
//
//  Created by release on 2020/10/9.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCNSRunLoopVC.h"

@interface YCNSRunLoopVC ()

@property(nonatomic,strong)dispatch_source_t timer;

@end

@implementation YCNSRunLoopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test];
//    [self timer1];
//    [self timer2];
    [self observer];
}

-(void)test{
    //1.获得主线程对应的runLoop
    NSRunLoop *mainRunLoop = [NSRunLoop mainRunLoop];
    YCLog(@"mainRunLoop--------%p",mainRunLoop);
    
    //2.获得当前线程对应的runLoop
    NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
    YCLog(@"currentRunLoop-------%p",currentRunLoop);
    
    
    YCLog(@"CFRunLoopGetMain--------%p",CFRunLoopGetMain());
    YCLog(@"CFRunLoopGetCurrent---------%p",CFRunLoopGetCurrent());
    YCLog(@"mainRunLoop.getCFRunLoop--------%p",mainRunLoop.getCFRunLoop);
    
    //主线程的runloop已经创建，但子线程的需要手动创建
    [[[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil]start];
}

/**
 在runloop中有多个运行模式，但是runloop只能选择一种模式运行
 //mode里面至少要有一个timer或者是source
 */
-(void)run{
    NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
    YCLog(@"NSThread----%p",currentRunLoop);
}


-(void)timer1{
    //1.创建定时器
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run1) userInfo:nil repeats:YES];
    
    //2.添加定时器到runloop中，指定runloop的运行模式为NSDefaultRunLoopMode
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    
    //UITrackingRunLoopMode 界面追踪
    //[[NSRunLoop currentRunLoop]addTimer:timer forMode:UITrackingRunLoopMode];
    
    //NSRunLoopCommonModes = NSDefaultRunLoopMode + UITrackingRunLoopMode
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)run1{
    YCLog(@"run-------%@------%@",[NSThread currentThread],[NSRunLoop currentRunLoop].currentMode);
}

/**
 GCD中的定时器
 */
-(void)timer2{
    //1.创建GCD中的定时器
    /**
     第一个参数：source的类型DISPATCH_SOURCE_TYPE_TIMER 表示是定时器
     第二个参数：描述信息，线程ID
     第三个参数：更详细的描述信息
     第四个参数：队列，决定GCD定时器中的任务在哪个线程中执行
     */
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    
    //2.设置定时器（起始时间｜间隔时间｜精准时间）
    /**
     第一个参数：定时器对象
     第二个参数：起始时间，DISPATCH_TIME_NOW 从现在开始计时
     第三个参数：间隔时间2.0 GCD中时间单位为纳秒
     第四个参数：精准度 绝对精准0
     */
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    //3.设置定时器执行的任务
    dispatch_source_set_event_handler(timer, ^{
        YCLog(@"GCD--------%@",[NSThread currentThread]);
    });
    
    //4.启动执行
    dispatch_resume(timer);
    
    self.timer = timer;
}

-(void)observer{
    //1.创建监听者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        /*
           kCFRunLoopEntry = (1UL << 0),         即将进入runloop
           kCFRunLoopBeforeTimers = (1UL << 1),  即将处理timer事件
           kCFRunLoopBeforeSources = (1UL << 2), 即将处理source事件
           kCFRunLoopBeforeWaiting = (1UL << 5), 即将进入睡眠
           kCFRunLoopAfterWaiting = (1UL << 6),  被唤醒
           kCFRunLoopExit = (1UL << 7),          runloop退出
           kCFRunLoopAllActivities = 0x0FFFFFFFU
         */
        switch (activity) {
            case kCFRunLoopEntry:
                YCLog(@"即将进入runloop");
                break;
            case kCFRunLoopBeforeTimers:
                YCLog(@"即将处理timer事件");
                break;
            case kCFRunLoopBeforeSources:
                YCLog(@"即将处理source事件");
                break;
            case kCFRunLoopBeforeWaiting:
                YCLog(@"即将进入睡眠");
                break;
            case kCFRunLoopAfterWaiting:
                YCLog(@"被唤醒");
                break;
            case kCFRunLoopExit:
                YCLog(@"runloop退出");
                break;
            default:
                break;
        }
    });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    //NSDefaultRunLoopMode == kCFRunLoopDefaultMode
    //NSRunLoopCommonModes == kCFRunLoopCommonModes
}
@end
