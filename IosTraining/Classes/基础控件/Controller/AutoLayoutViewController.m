//
//  AutoLayoutViewController.m
//  UI
//
//  Created by release on 2019/11/13.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "AutoLayoutViewController.h"
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface AutoLayoutViewController ()
  
@property(nonatomic,strong)UIView* superView;
@property(nonatomic,strong)UILabel* label01;
@property(nonatomic,strong)UILabel* label02;
@property(nonatomic,strong)UILabel* label03;
@property(nonatomic,strong)UILabel* label04;
@property(nonatomic,strong)UIView* centerView;

@end

@implementation AutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initView];
}

-(void)initView{
    _superView = [[UIView alloc]initWithFrame:CGRectMake(30, 30, 150, 260)];
    _superView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_superView];
    
    _label01 = [[UILabel alloc]init];
    _label01.frame = CGRectMake(0, 0, 40, 40);
    _label01.text = @"1";
    _label01.textAlignment = NSTextAlignmentCenter;
    _label01.backgroundColor = [UIColor orangeColor];
    
    _label02 = [[UILabel alloc]init];
    _label02.text = @"2";
    _label02.textAlignment = NSTextAlignmentCenter;
    _label02.frame = CGRectMake(_superView.bounds.size.width - 40, 0, 40, 40);
    _label02.backgroundColor = [UIColor orangeColor];
   
    _label03 = [[UILabel alloc]init];
    _label03.text = @"3";
    _label03.textAlignment = NSTextAlignmentCenter;
    _label03.frame = CGRectMake(0, _superView.bounds.size.height - 40, 40, 40);
    _label03.backgroundColor = [UIColor orangeColor];
    
    _label04 = [[UILabel alloc]init];
    _label04.text = @"4";
    _label04.textAlignment = NSTextAlignmentCenter;
    _label04.frame = CGRectMake(_superView.bounds.size.width - 40, _superView.bounds.size.height - 40, 40, 40);
    _label04.backgroundColor = [UIColor orangeColor];
    
    _centerView = [[UIView alloc]init];
    _centerView.frame = CGRectMake(30, 0, _superView.bounds.size.width, 40);
    _centerView.center = CGPointMake(150/2, 260/2);
    _centerView.backgroundColor = [UIColor orangeColor];
    
    [_superView addSubview:_label01];
    [_superView addSubview:_label02];
    [_superView addSubview:_label03];
    [_superView addSubview:_label04];
    [_superView addSubview:_centerView];
    
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(320, 500, 60, 30)];
    [btn setTitle:@"放大" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn addTarget:self action:@selector(pressesBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:101];
    [self.view addSubview:btn];
    
    UIButton* btn2 = [[UIButton alloc]initWithFrame:CGRectMake(320, 550, 60, 30)];
    [btn2 setTitle:@"缩小" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor grayColor]];
    [btn2 addTarget:self action:@selector(pressesBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTag:102];
    [self.view addSubview:btn2];
    
    //方式一：autoresizing自动布局
    /*
    _centerView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    _label01.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    _label02.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    _label03.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin;
    _label04.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
     */
    
    //方式二：NSLayoutConstraint添加约束实现自动布局
    //关闭系统的自定义布局
    /*
    _centerView.translatesAutoresizingMaskIntoConstraints = NO;
    _label01.translatesAutoresizingMaskIntoConstraints = NO;
    _label02.translatesAutoresizingMaskIntoConstraints = NO;
    _label03.translatesAutoresizingMaskIntoConstraints = NO;
    _label04.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *centerViewLeft = [NSLayoutConstraint constraintWithItem:_centerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *centerViewRight =[NSLayoutConstraint constraintWithItem:_centerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.superView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *centerViewCenterY = [NSLayoutConstraint constraintWithItem:_centerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.superView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    NSLayoutConstraint *centerViewH = [NSLayoutConstraint constraintWithItem:_centerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:40];
    [self.superView addConstraints:@[centerViewLeft,centerViewRight ,centerViewCenterY,centerViewH]];

    NSLayoutConstraint *label01L = [NSLayoutConstraint constraintWithItem:_label01 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *label01T = [NSLayoutConstraint constraintWithItem:_label01 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *label01H = [NSLayoutConstraint constraintWithItem:_label01 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:40];
    NSLayoutConstraint *label01W = [NSLayoutConstraint constraintWithItem:_label01 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:40];
    [self.superView addConstraints:@[label01L,label01T,label01H,label01W]];

    NSLayoutConstraint *label02R = [NSLayoutConstraint constraintWithItem:_label02 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.superView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *label02T = [NSLayoutConstraint constraintWithItem:_label02 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *label02H = [NSLayoutConstraint constraintWithItem:_label02 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:40];
    NSLayoutConstraint *label02W = [NSLayoutConstraint constraintWithItem:_label02 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:40];
    [self.superView addConstraints:@[label02R,label02T,label02H,label02W]];

    NSLayoutConstraint *label03L = [NSLayoutConstraint constraintWithItem:_label03 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *label03B = [NSLayoutConstraint constraintWithItem:_label03 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *label03H = [NSLayoutConstraint constraintWithItem:_label03 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:40];
    NSLayoutConstraint *label03W = [NSLayoutConstraint constraintWithItem:_label03 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:40];
    [self.superView addConstraints:@[label03L,label03B,label03H,label03W]];

    NSLayoutConstraint *label04R = [NSLayoutConstraint constraintWithItem:_label04 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.superView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *label04B = [NSLayoutConstraint constraintWithItem:_label04 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *label04H = [NSLayoutConstraint constraintWithItem:_label04 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:40];
    NSLayoutConstraint *label04W = [NSLayoutConstraint constraintWithItem:_label04 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:40];
    [self.superView addConstraints:@[label04R,label04B,label04H,label04W]];
     */
    
    //方式三：Masonry框架实现
    [_centerView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.superView.left);
        make.right.equalTo(self.superView.right);
        make.centerY.equalTo(self.superView.centerY);
        make.height.equalTo(40);
    }];
    [_label01 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.superView.left);
        make.top.equalTo(self.superView.top);
        make.height.width.equalTo(40);
    }];
    [_label02 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.superView.right);
        make.top.equalTo(self.superView.top);
        make.height.width.equalTo(40);
    }];
    [_label03 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.superView.left);
        make.bottom.equalTo(self.superView.bottom);
        make.height.width.equalTo(40);
    }];
    [_label04 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.superView.right);
        make.bottom.equalTo(self.superView.bottom);
        make.height.width.equalTo(40);
    }];
    
}

-(void)pressesBtn:(UIButton*)btn{
    if (btn.tag == 101) {
        YCLog(@"放大");
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        _superView.frame = CGRectMake(0, 0, 300, 520);
        [UIView commitAnimations];
    }else if (btn.tag == 102){
        YCLog(@"缩小");
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        _superView.frame = CGRectMake(30, 30, 150, 260);
        [UIView commitAnimations];
    }
    //改变约束的值，让其做动画
    [UIView animateWithDuration:1 animations:^{
        [self.view layoutIfNeeded];
    }];
}


@end
