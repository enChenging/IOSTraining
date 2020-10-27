//
//  UIViewViewController.m
//  UI
//
//  Created by release on 2019/11/8.
//  Copyright © 2019 Mr. release. All rights reserved.
//

/**
自定义view
1.在initWithFrame:方法中添加字控件，提供便利构造方法
2.在layoutSubviews方法中设置子控件的frame(一定要调用super的layoutSubviews)
3.增加模型属性，在模型属性set方法中设置数据到子控件上
*/
#import "UIViewViewController.h"
#import "YCHeartView.h"
#import "YCHeartView2.h"
#import "YCHeartView3.h"
#import "YCHeartModel.h"

@interface UIViewViewController ()

@end

@implementation UIViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUIView];
}

-(void)createUIView{
    //代码自定义view
    YCHeartModel *heartModel = [[YCHeartModel alloc]initWithIcon:@"heart1" name:@"小爱心"];
    YCHeartView *heartView = [[YCHeartView alloc]initWithHartModel:heartModel];
    heartView.frame = CGRectMake(20, 100, 100, 150);
    [self.view addSubview:heartView];
    
    YCHeartModel *heartModel2 = [[YCHeartModel alloc]initWithIcon:@"heart2" name:@"五角星"];
    YCHeartView *heartView2 = [[YCHeartView alloc]initWithFrame:CGRectMake(140, 100, 120, 160)];
    heartView2.heartModel = heartModel2;
    [self.view addSubview:heartView2];
    
    //xib自定view
     YCHeartModel *heartModel3 = [[YCHeartModel alloc]initWithIcon:@"heart3" name:@"五角星"];
    YCHeartView2 *hv = [YCHeartView2 HeartView2];
    hv.frame =CGRectMake(20, 300, 0, 0);
    hv.heartModel = heartModel3;
    [self.view addSubview:hv];
    
    //自定义button
    YCHeartModel *heartModel4 = [[YCHeartModel alloc]initWithIcon:@"heart3" name:@"五角星"];
    YCHeartView3 *hv3 = [YCHeartView3 heartView3];
    hv3.frame =CGRectMake(120, 300, 80, 110);
    hv3.heartModel = heartModel4;
    [self.view addSubview:hv3];
}

@end
