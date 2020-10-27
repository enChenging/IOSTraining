//
//  UIScrollViewViewController.m
//  UI
//
//  Created by release on 2019/11/11.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "UIScrollViewViewController.h"
#import "YCPageView.h"

@interface UIScrollViewViewController ()<UIScrollViewDelegate>
    
@property(nonatomic,strong)UIScrollView* sv;

@end

@implementation UIScrollViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initTitle];
//    [self initVerticalScroll];
    [self initBanner];
}


-(void)initTitle{
     UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"回到顶部" style:UIBarButtonItemStylePlain target:self action:@selector(pressTop)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

-(void)pressBack{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)pressTop{
    [_sv scrollRectToVisible:CGRectMake(0, 0, kScreenWidth, kScreenHeight) animated:YES];
}

/**
 初始化垂直滚动
 */
-(void)initVerticalScroll{
    _sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight)];
    _sv.backgroundColor = [UIColor whiteColor];
    
    _sv.contentSize  = CGSizeMake(kScreenWidth, kScreenHeight*5);//设置内容尺寸
    _sv.contentOffset = CGPointMake(0, 0);//滚动的初始化位置（偏移量 = 内容左上角 - 图片左上角）
//    _sv.contentInset = UIEdgeInsetsMake(10, 20, 30, 40);//内边距
    _sv.alwaysBounceVertical = YES;//默认为NO 竖向弹动效果
    _sv.delegate = self;
//    _sv.clipsToBounds = YES;//默认为YES 超出边框裁切掉
//    _sv.scrollEnabled = YES;//默认为YES 是否可以有滚动效果
//    _sv.userInteractionEnabled = YES;//默认为YES 是否能够跟用户交互
//    _sv.bounces = YES;//默认为YES 是否可以边缘弹动效果
//    _sv.pagingEnabled  = NO;//默认为NO 是否开启分页功能（标准：以scrollview的尺寸为一页）
//    _sv.showsHorizontalScrollIndicator = YES;//默认为YES 显示横向滚动条
//    _sv.showsVerticalScrollIndicator = YES;//默认为YES 显示竖向滚动条
//    _sv.alwaysBounceHorizontal = NO;//默认为NO 横向弹动效果
    
    for (int i =0; i<5; i++) {
        NSString *strImage = [NSString stringWithFormat:@"guide_%d",i+1];
        UIImage* image = [UIImage imageNamed:strImage];
        UIImageView* _imageView = [[UIImageView alloc]initWithImage:image];
        _imageView.frame = CGRectMake(0, kScreenHeight*i, kScreenWidth, kScreenHeight);
        [_sv addSubview:_imageView];
    }
    
    [self.view addSubview:_sv];
}

/**初始化轮播图*/
-(void)initBanner{
    YCPageView *pageView = [YCPageView pageView];
    pageView.center  = self.view.center;
   
    pageView.backgroundColor = [UIColor redColor];
    pageView.imageNames = @[@"ad_00",@"ad_01",@"ad_02",@"ad_03",@"ad_04"];
    pageView.frame = CGRectMake(0, 0, kScreenWidth, 200);
    [self.view addSubview:pageView];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    YCLog(@"y == %f",scrollView.contentOffset.y);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    YCLog(@"即将开始拖拽");
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    YCLog(@"即将结束拖拽");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    YCLog(@"已经结束拖拽");
    if (decelerate == NO) {
        YCLog(@"用户已经停止拖拽scrollview,停止滚动");
    }else{
        YCLog(@"用户已经停止拖拽scrollview,但是scrollview由于惯性会继续滚动，减速");
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    YCLog(@"即将减速时");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    YCLog(@"scrollview减速完毕会调用，停止滚动");
}

/**
 返回需要缩放的子控件
 */
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
//
//}

/**
 监听缩放行为
 */
//- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
//    
//}

@end
