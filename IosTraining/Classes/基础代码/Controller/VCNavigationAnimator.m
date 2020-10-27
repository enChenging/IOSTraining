//
//  VCNavigationAnimator.m
//  UI
//
//  Created by release on 2019/11/19.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "VCNavigationAnimator.h"
#import "VCNavigationAnimator2.h"

@interface VCNavigationAnimator ()

@end

@implementation VCNavigationAnimator

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initView];
}

-(void)initView{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIImageView* _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide_6"]];
    [_imageView setFrame:CGRectMake(55, 55, 300, 500)];
    [self.view addSubview:_imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CATransition* _anim = [CATransition animation];
    [_anim setDuration:1];
    //动画的过渡方式
    //kCATransitionPush 平移
    //kCATransitionFade 渐变
    //kCATransitionReveal 揭示（平移）
    //kCATransitionMoveIn 平移
    //cube 立方体式选装
    //rippleEffect 涟漪效应
    //pageCurl 向前翻页
    //pageUnCurl 向后翻页
    //oglFlip 上下翻转
    //suckEffect 吸收效果
    [_anim setType:@"suckEffect"];
    //动画的过渡方向
    [_anim setSubtype:kCATransitionFromRight];
    //设置动画轨迹
    [_anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [self.navigationController.view.layer addAnimation:_anim forKey:nil];
    
    VCNavigationAnimator2* _navigat2 = [[VCNavigationAnimator2 alloc]init];
    [self.navigationController pushViewController:_navigat2 animated:NO];
}

@end
