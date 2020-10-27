//
//  YCPageView.m
//  UI
//
//  Created by release on 2020/7/31.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCPageView.h"

@interface YCPageView ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property(nonatomic,weak)NSTimer *timer;

@end
@implementation YCPageView

+(instancetype)pageView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    /**
        UIViewAutoresizingNone
        UIViewAutoresizingFlexibleLeftMargin   距离父控件的左边是可以伸缩的
        UIViewAutoresizingFlexibleRightMargin  距离父控件的右边是可以伸缩的
        UIViewAutoresizingFlexibleTopMargin    距离父控件的顶部是可以伸缩的
        UIViewAutoresizingFlexibleBottomMargin 距离父控件的底部是可以伸缩的
        UIViewAutoresizingFlexibleHeight    高度会跟随父控件的高度进行伸缩
        UIViewAutoresizingFlexibleWidth  宽度会跟随父控件的宽度进行伸缩
        */
    self.scrollView.autoresizingMask =UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
    self.pageControl.hidesForSinglePage = YES;
    [self startTimer];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //根据最新的scrollview的尺寸计算imageView的x
    CGFloat scrollViewW = self.scrollView.frame.size.width;//340
    YCLog(@"layoutSubviews--scrollViewW--%f",scrollViewW);
    NSInteger count = self.scrollView.subviews.count;
    for (int i =0; i<count; i++) {
        UIImageView* imageView =self.scrollView.subviews[i];
        CGRect frame = imageView.frame;
        frame.origin.x = i*scrollViewW;
        imageView.frame = frame;
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.subviews.count*scrollViewW, 0);
}


- (void)setImageNames:(NSArray *)imageNames{
    _imageNames = imageNames;
    
    //移除之前添加的
    //让subviews这个数组中每一个对象都执行removeFromSuperview
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat scrollViewW = self.scrollView.frame.size.width;//300
    YCLog(@"setImageNames--scrollViewW--%f",scrollViewW);
    CGFloat scrollViewH = self.scrollView.frame.size.height;
    NSInteger count = imageNames.count;
    for (int i =0; i<count; i++) {
        UIImageView* _imageView = [[UIImageView alloc]initWithImage: [UIImage imageNamed:imageNames[i]]];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _imageView.frame = CGRectMake(i*scrollViewW, 0, scrollViewW, scrollViewH);
        [self.scrollView addSubview:_imageView];
    }
    
    self.scrollView.contentSize = CGSizeMake(count*scrollViewW, 0);
    self.pageControl.numberOfPages = imageNames.count;
}




-(void)startTimer{
    //返回一个自动执行的定时器对象
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];

    //NSDefaultRunLoopMode 默认：同一时间只能执行一个任务
    //NSRunLoopCommonModes 公用：可以分开配一定的时间执行其他任务
    //目的：不管主线程在做什么操作，都分配一定的时间处理定时器
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)stopTimer{
    [self.timer invalidate];
}

-(void)nextPage{
    NSInteger page = self.pageControl.currentPage + 1;
    if (page == _imageNames.count) {
        page = 0;
    }
//    YCLog(@"nextPage----%zd",page);
    [self.scrollView setContentOffset:CGPointMake(page * self.scrollView.frame.size.width, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    YCLog(@"y == %f",scrollView.contentOffset.y);
    int page = scrollView.contentOffset.x/scrollView.frame.size.width + 0.5;
    if (self.pageControl) {
        self.pageControl.currentPage = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    YCLog(@"即将开始拖拽");
    [self stopTimer];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    YCLog(@"即将结束拖拽");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    YCLog(@"已经结束拖拽");
    if (decelerate == NO) {
        YCLog(@"用户已经停止拖拽scrollview,停止滚动");
//        int page = scrollView.contentOffset.x/scrollView.frame.size.width;
//        if (self.pageControl) {
//            self.pageControl.currentPage = page;
//        }
    }else{
        YCLog(@"用户已经停止拖拽scrollview,但是scrollview由于惯性会继续滚动，减速");
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    YCLog(@"即将减速时");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    YCLog(@"scrollview减速完毕会调用，停止滚动");
//    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
//    if (self.pageControl) {
//        self.pageControl.currentPage = page;
//    }
    [self startTimer];
   
}



@end
