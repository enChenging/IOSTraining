//
//  UISlide_ProgressViewController.m
//  UI
//
//  Created by release on 2019/11/8.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "UISlide_ProgressViewController.h"

@interface UISlide_ProgressViewController (){
 
    UISlider* _slide;
    UIProgressView* _progressView;
}

@end

@implementation UISlide_ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    _slide = [[UISlider alloc]initWithFrame:CGRectMake(120, 100, 200, 100)];
    _slide.maximumValue = 100;
    _slide.minimumValue = -100;
    _slide.value = 20;
    _slide.minimumTrackTintColor = [UIColor redColor];//左侧进度条颜色
    _slide.maximumTrackTintColor = [UIColor blackColor];//右侧进度条颜色
    _slide.thumbTintColor = [UIColor blueColor];//滑动按钮颜色
    [_slide addTarget:self action:@selector(pressSlide:) forControlEvents:UIControlEventValueChanged];

    
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(120, 300, 200, 100)];
    _progressView.progressTintColor = [UIColor redColor];//进度条颜色
    _progressView.trackTintColor = [UIColor blackColor];//进度条背景色
    _progressView.progress = 0.1;
    _progressView.progressViewStyle = UIProgressViewStyleDefault;
    
    [self.view addSubview:_slide];
    [self.view addSubview:_progressView];
}

-(void)pressSlide:(UISlider*)slide{
    _progressView.progress = (_slide.value - _slide.minimumValue)/(_slide.maximumValue - _slide.minimumValue);
    YCLog(@"slide%f",slide.value);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
