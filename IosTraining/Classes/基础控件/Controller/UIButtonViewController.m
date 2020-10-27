//
//  UIButtonViewController.m
//  UI
//
//  Created by release on 2019/11/8.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "UIButtonViewController.h"

@interface UIButtonViewController ()

@end

@implementation UIButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUIButton];
}

-(void)createUIButton{
    
    UIButton *cButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    cButton.frame=CGRectMake(100, 100, 100, 50);
    cButton.backgroundColor=[UIColor blackColor];
    cButton.titleLabel.font=[UIFont systemFontOfSize:20];
    [cButton setTitle:@"Button" forState:UIControlStateNormal];
    [cButton setTitle:@"selected" forState:UIControlStateHighlighted];
    [cButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [cButton addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cButton addTarget:self action:@selector(touchBtn) forControlEvents:UIControlEventTouchDown];
    cButton.tag=101;
    [self.view addSubview:cButton];
    
    
    UIButton *cButton2=[UIButton buttonWithType:UIButtonTypeCustom];
    cButton2.frame = CGRectMake(100, 200, 120, 60);
    [cButton2 setTitle:@"镜像" forState:UIControlStateNormal];
    [cButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cButton2 setTitleColor:[UIColor magentaColor] forState:UIControlStateHighlighted];
    cButton2.backgroundColor = [UIColor grayColor];
    cButton2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    //设置按钮内边距
    //(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    cButton2.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    cButton2.titleEdgeInsets = UIEdgeInsetsMake(0, -33, 0, 0);
    cButton2.imageEdgeInsets = UIEdgeInsetsMake(10, -23, 10, 0);
    //控制按钮内部的子控件对齐
//    cButton2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    cButton2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    UIImage *icon1 = [UIImage imageNamed:@"live_mirror_n.png"];
    UIImage *icon2 = [UIImage imageNamed:@"live_mirror_p.png"];
    [cButton2 setImage:icon1 forState:UIControlStateNormal];
    [cButton2 setImage:icon2 forState:UIControlStateHighlighted];
    [cButton2 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    cButton2.tag=102;
    [self.view addSubview:cButton2];
    
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame=CGRectMake(100, 300, 200, 100);
//    btn3.backgroundColor = [UIColor redColor];
    [btn3 setTitle:@"普通状态" forState:UIControlStateNormal];
    [btn3 setTitle:@"高亮状态" forState:UIControlStateHighlighted];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [btn3 setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn3 setTitleShadowColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    btn3.titleLabel.shadowOffset = CGSizeMake(5, 7);
    [btn3 setImage:[UIImage imageNamed:@"heart1"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"heart2"] forState:UIControlStateHighlighted];
    btn3.imageView.backgroundColor = [UIColor blackColor];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"login_btn_bg"] forState:UIControlStateNormal];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"login_btn_bg_p"] forState:UIControlStateHighlighted];
    [self.view addSubview:btn3];
}

-(void)pressBtn:(UIButton*)btn{
    if (btn.tag == 101) {
         YCLog(@"点击按钮cButton");//抬起手指时打印
    }else if(btn.tag == 102){
         YCLog(@"点击按钮cButton2");//抬起手指时打印
    }
   
}

-(void)touchBtn{
    YCLog(@"触摸按钮");//触摸按钮时打印
}


@end
