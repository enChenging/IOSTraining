//
//  YCNeteaseNewsVC.m
//  IosTraining
//
//  Created by release on 2020/10/23.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCNeteaseNewsVC.h"


@interface YCNeteaseNewsVC ()<UIScrollViewDelegate>

@property(nonatomic,weak)UIScrollView *titleScrollView;
@property(nonatomic,weak)UIScrollView *contentScrollView;
@property(nonatomic,weak)UIButton *selectButton;
@property(nonatomic,strong)NSMutableArray *titleButtons;
@property(nonatomic,assign)BOOL isInitiallize;

@end

@implementation YCNeteaseNewsVC

- (NSMutableArray *)titleButtons{
    if (_titleButtons == nil) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_isInitiallize == NO) {
        //4.设置所有标题
        [self setupAllTitle];
    }
    
    _isInitiallize = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.添加标题滚动视图
    [self setupTitleScrollView];
    //2.添加内容滚动视图
    [self setupContentScrollView];

    //ios7以后，导航控制器中scollView顶部会添加64的额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
}

/**
 添加标题滚动视图
 */
-(void)setupTitleScrollView{
    UIScrollView *titleScrollView = [[UIScrollView alloc]init];
//    CGFloat y = self.navigationController.navigationBarHidden ? 20 : 64;
    CGFloat y = 0;
    titleScrollView.frame = CGRectMake(0, y, kScreenWidth, 44);
    [self.view addSubview:titleScrollView];
    _titleScrollView = titleScrollView;
}

/**
 添加内容滚动视图
 */
-(void)setupContentScrollView{
    UIScrollView *contentScrollView = [[UIScrollView alloc]init];
    CGFloat y = CGRectGetMaxY(self.titleScrollView.frame);
    contentScrollView.frame = CGRectMake(0, y, kScreenWidth, kScreenHeight - y);
    [self.view addSubview:contentScrollView];
    _contentScrollView = contentScrollView;
    
    //分页
    self.contentScrollView.pagingEnabled = YES;
    //弹簧
    self.contentScrollView.bounces = NO;
    //指示器
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    
    //设置代理
    self.contentScrollView.delegate = self;
}

/**
 设置所有标题
 */
-(void)setupAllTitle{
    
    //添加所有标题按钮
    NSInteger count = self.childViewControllers.count;
    CGFloat btnW = 100;
    CGFloat btnH = self.titleScrollView.bounds.size.height;
    CGFloat btnX = 0;
    for (NSInteger i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        UIViewController *vc = self.childViewControllers[i];
        [titleButton setTitle:vc.title forState:UIControlStateNormal];
        btnX = i * btnW;
        titleButton.frame = CGRectMake(btnX, 0, btnW, btnH);
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //监听按钮点击
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        //把标题按钮保存到对应的数组
        [self.titleButtons addObject:titleButton];
        
        if (i == 0) {
            [self titleClick:titleButton];
        }
        
        [self.titleScrollView addSubview:titleButton];
    }
    
    //设置标题的滚动范围
    self.titleScrollView.contentSize = CGSizeMake(count * btnW, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    //设置内容的滚动范围
    self.contentScrollView.contentSize = CGSizeMake(count * kScreenWidth, 0);
}

/**
 处理标题点击
 */
-(void)titleClick:(UIButton *)btn{
    NSInteger i = btn.tag;
    //1.标题颜色变为红色
    [self selectButton:btn];
    //2.把对应的子控制器的view添加上去
    UIViewController *vc = self.childViewControllers[i];
    CGFloat x = i * kScreenWidth;
    vc.view.frame = CGRectMake(x, 0, kScreenWidth,  self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:vc.view];
    //3.内容滚动视图滚动到对应的位置
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
}

/**
 选中标题
 */
-(void)selectButton:(UIButton *)btn{
    [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    //标题居中
    [self setupTitleCenter:btn];
    
    //字体缩放：形变
    btn.transform  = CGAffineTransformMakeScale(1.3, 1.3);
    
     _selectButton = btn;
}

/**
 标题居中
 */
-(void)setupTitleCenter:(UIButton *)btn{
    //修改titleScrollView偏移量
    CGFloat offsetX = btn.center.x - kScreenWidth * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - kScreenWidth;
//    YCLog(@"maxOffsetX----%f",maxOffsetX);
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark  UIScrollViewDelegate
//滚动完成时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //获取当前角标
    NSInteger i = scrollView.contentOffset.x / kScreenWidth;
    
    //获取标题按钮
    UIButton *titleBtn = self.titleButtons[i];
    
    //1.选中标题
    [self selectButton:titleBtn];
    //2.把对应的子控件的view添加上去
    [self setupOneViewController:i];
}

//只要一滚动就需要字体渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //字体缩放
    NSInteger leftI = scrollView.contentOffset.x / kScreenWidth;
    NSInteger rightI = leftI + 1;
    
    //获取左边的按钮
    UIButton *leftBtn = self.titleButtons[leftI];
    NSInteger count = self.titleButtons.count;
    
    //获取右边的按钮
    UIButton *rightBtn;
    if (rightI < count) {
         rightBtn = self.titleButtons[rightI];
    }
   
    //0~1 => 1~1.3
    CGFloat scaleR = scrollView.contentOffset.x / kScreenWidth;
    scaleR -= leftI;
//    YCLog(@"-----scaleR----%f",scaleR);
    
    CGFloat scaleL = 1 - scaleR;
    
    //缩放按钮
    leftBtn.transform = CGAffineTransformMakeScale(scaleL * 0.3 + 1, scaleL * 0.3 + 1);
    rightBtn.transform = CGAffineTransformMakeScale(scaleR * 0.3 + 1, scaleR * 0.3 + 1);
    
    //颜色渐变
    UIColor *rightColor = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
    UIColor *leftColor = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
    [rightBtn setTitleColor:rightColor forState:UIControlStateNormal];
    [leftBtn setTitleColor:leftColor forState:UIControlStateNormal];
    
}

/**
 把对应的子控件的view添加上去
 */
-(void)setupOneViewController:(NSInteger)i{
    UIViewController *vc = self.childViewControllers[i];
//    if (vc.view.superview) {
//        return;
//    }
    
    if (vc.viewIfLoaded) {
        return;
    }
//    YCLog(@"--------%zd-------",i);
    CGFloat x = i * kScreenWidth;
    vc.view.frame = CGRectMake(x, 0, kScreenWidth, self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:vc.view];
}

@end
