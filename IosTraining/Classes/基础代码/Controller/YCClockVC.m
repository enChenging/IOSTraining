//
//  YCClockVC.m
//  UI
//
//  Created by release on 2020/9/11.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCClockVC.h"

//秒针每一秒旋转6度
#define perSecondA 6

//分针每一分旋转6度
#define perMinA 6

//时针每一小时旋转
#define perHourA 30

//每一分时针旋转多少度
#define perMinHourA 0.5

@interface YCClockVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

/**秒针*/
@property (weak, nonatomic)CALayer *secondL;

/**分针*/
@property (weak, nonatomic)CALayer *minL;

/**时针*/
@property (weak, nonatomic)CALayer *hourL;


@end

@implementation YCClockVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addHourL];
    
    [self addMinL];
    
    [self addSecondL];
    
    //添加定时器（每一秒做一件事）
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    [self timeChange];
}

/**
 每一秒调用一次
 */
-(void)timeChange{
    
    //获取当前是多少秒
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获取日历当中的组建，年 月 日 时 分 秒
    //formDate:从哪个时间
    NSDateComponents *cmp = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    
    //秒针旋转的度  = 当前的秒数 * 每一秒旋转多少度
    //获取当前的秒数
    NSInteger curSec = cmp.second;
    CGFloat secondAngle = curSec * perSecondA;
    //让秒开始旋转
    self.secondL.transform = CATransform3DMakeRotation(angle2Rad(secondAngle), 0, 0, 1);
    
    //让分开始旋转
    //分针旋转的度  = 当前的分数 * 每一分旋转多少度
    //获取当前的分数
    NSInteger curMin = cmp.minute;
    CGFloat minAngle = curMin * perMinA;
    //让秒开始旋转
    self.minL.transform = CATransform3DMakeRotation(angle2Rad(minAngle), 0, 0, 1);
    
    //让时开始旋转
    //时针旋转的度  = 当前的时数 * 每一时旋转多少度
    //获取当前的时数
    NSInteger curHour = cmp.hour;
    CGFloat hourAngle = curHour * perHourA + curMin * perMinHourA;
    //让秒开始旋转
    self.hourL.transform = CATransform3DMakeRotation(angle2Rad(hourAngle), 0, 0, 1);
}

-(void)addSecondL{
    CALayer *secondL = [CALayer layer];
    secondL.bounds = CGRectMake(0, 0, 1, 80);
    secondL.backgroundColor = [UIColor redColor].CGColor;
    secondL.anchorPoint = CGPointMake(0.5, 1);
    secondL.position = CGPointMake(self.imageV.bounds.size.width * 0.5, self.imageV.bounds.size.height * 0.5);
    self.secondL = secondL;
    [self.imageV.layer addSublayer:secondL];
}

-(void)addMinL{
    CALayer *minL = [CALayer layer];
    minL.bounds = CGRectMake(0, 0, 3, 60);
    minL.backgroundColor = [UIColor blackColor].CGColor;
    minL.anchorPoint = CGPointMake(0.5, 1);
    minL.position = CGPointMake(self.imageV.bounds.size.width * 0.5, self.imageV.bounds.size.height * 0.5);
    self.minL = minL;
    [self.imageV.layer addSublayer:minL];
}

-(void)addHourL{
    CALayer *hourL = [CALayer layer];
    hourL.bounds = CGRectMake(0, 0, 4, 50);
    hourL.backgroundColor = [UIColor blackColor].CGColor;
    hourL.anchorPoint = CGPointMake(0.5, 1);
    hourL.position = CGPointMake(self.imageV.bounds.size.width * 0.5, self.imageV.bounds.size.height * 0.5);
    self.hourL = hourL;
    [self.imageV.layer addSublayer:hourL];
}


@end
