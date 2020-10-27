//
//  YCHomeTVC.m
//  IosTraining
//
//  Created by release on 2020/10/22.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCHomeTVC.h"
#import "YCHome1VC.h"
#import "YCHome2VC.h"
#import "YCHome3VC.h"

@interface YCHomeTVC ()
@property (weak, nonatomic) IBOutlet UIView *titleContainV;

@property (weak, nonatomic) IBOutlet UIView *containV;

@end

@implementation YCHomeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.添加所有的子控制器
    [self setupAllViewController];
    // 2.设置按钮的内容
    [self setupTitleButton];
}

// 设置按钮的内容
- (void)setupTitleButton
{
    NSInteger count = self.titleContainV.subviews.count;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.titleContainV.subviews[i];
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
    }
}

// 添加所有的子控制器
- (void)setupAllViewController
{
    
    YCHome1VC *home1 = [[YCHome1VC alloc] init];
    home1.title = @"Home1";
    [self addChildViewController:home1];

    YCHome2VC *home2 = [[YCHome2VC alloc] init];
    home2.title = @"Home2";
    [self addChildViewController:home2];

    YCHome3VC *home3 = [[YCHome3VC alloc] init];
    home3.title = @"Home3";
    [self addChildViewController:home3];
    
}

 //点击标题按钮
- (IBAction)showChildVcView:(UIButton *)sender {

    // 移除之前控制器的view
    [self.containV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //    for (UIView *vcView in self.containView.subviews) {
    //        [vcView removeFromSuperview];
    //    }

    // 把对应子控制器的view添加上去
    UIViewController *vc = self.childViewControllers[sender.tag];
    vc.view.backgroundColor = sender.backgroundColor;
    vc.view.frame = self.containV.bounds;
    [self.containV addSubview:vc.view];
}
@end
