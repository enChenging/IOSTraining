//
//  YCNeteaseNews2.m
//  IosTraining
//
//  Created by release on 2020/10/26.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCNeteaseNews2.h"
#import "YCTopLineVC.h"
#import "YCHotVC.h"
#import "YCVideoVC.h"
#import "YCScoietyVC.h"
#import "YCReaderVC.h"
#import "YCScienceVC.h"

@interface YCNeteaseNews2 ()

@end

@implementation YCNeteaseNews2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //3.添加所有子控件
    [self setupAllChildViewController];
}


/**
 添加所有子控件
 */
-(void)setupAllChildViewController{
    
    //头条
    YCTopLineVC *vc1 = [[YCTopLineVC alloc]init];
    vc1.title = @"头条";
    [self addChildViewController:vc1];
    //热点
    YCHotVC *vc2 = [[YCHotVC alloc]init];
    vc2.title = @"热点";
    [self addChildViewController:vc2];
    //视频
    YCVideoVC *vc3 = [[YCVideoVC alloc]init];
    vc3.title = @"视频";
    [self addChildViewController:vc3];
    //社会
    YCScoietyVC *vc4 = [[YCScoietyVC alloc]init];
    vc4.title = @"社会";
    [self addChildViewController:vc4];
    //订阅
    YCReaderVC *vc5 = [[YCReaderVC alloc]init];
    vc5.title = @"订阅";
    [self addChildViewController:vc5];
    //科技
    YCScienceVC *vc6 = [[YCScienceVC alloc]init];
    vc6.title = @"科技";
    [self addChildViewController:vc6];
}

@end
