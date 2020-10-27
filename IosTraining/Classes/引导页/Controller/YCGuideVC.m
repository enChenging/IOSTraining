//
//  YCGuideVC.m
//  UI
//
//  Created by release on 2020/9/18.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCGuideVC.h"
#import "YCGuideCollectionViewCell.h"


@interface YCGuideVC ()

//记录上一次的偏移量
@property(nonatomic,assign)CGFloat lastOffsetX;

//球
@property(nonatomic,weak)UIImageView *guide;

//大标题
@property(nonatomic,weak)UIImageView *guideLargeText;

//小标题
@property(nonatomic,weak)UIImageView *guideSmallText;

@end

@implementation YCGuideVC

static NSString * const reuseIdentifier = @"Cell";
- (instancetype)init
{
    self = [super init];
    if (self) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        //修改item大小
        flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
        //修改行间距
        flowLayout.minimumLineSpacing = 0;
        //修改每一个item的间距
        flowLayout.minimumInteritemSpacing = 0;
        //修改滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        //修改每一组的边距
        //    flowLayout.sectionInset = UIEdgeInsetsMake(100, 20, 20, 70);
        
        return [super initWithCollectionViewLayout:flowLayout];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.collectionView.backgroundColor = [UIColor redColor];
    
    //注册cell
    [self.collectionView registerClass:[YCGuideCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //设置分也
    self.collectionView.pagingEnabled = YES;
    //禁止弹簧效果
    self.collectionView.bounces = NO;
    //隐藏滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //添加内容
    //1.添加图片
    //2.添加到collectionView
    [self setUpAddChildImageView];
}

-(void)setUpAddChildImageView{
    //1.线
    UIImageView *guideLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guideLine"]];
    [self.collectionView addSubview:guideLine];
    guideLine.x -= 150;
    
    //2.球
    UIImageView *guide = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide1"]];
    [self.collectionView addSubview:guide];
    guide.x += 50;
    self.guide = guide;
    
    //3.大标题
    UIImageView *guideLargeText = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guideLargeText1"]];
    [self.collectionView addSubview:guideLargeText];
    guideLargeText.center = CGPointMake(kScreenWidth / 2, kScreenHeight * 0.7f);
    self.guideLargeText = guideLargeText;
    
    //4.小标题
    UIImageView *guideSmallText = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guideSmallText1"]];
    [self.collectionView addSubview:guideSmallText];
    guideSmallText.center = CGPointMake(kScreenWidth / 2, kScreenHeight * 0.8f);
    self.guideSmallText = guideSmallText;
}

/**
 滑动滚动的时候调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //平移一个屏幕宽度
    
    //总偏移量
    CGFloat offestx = scrollView.contentOffset.x;
    
    //计算一个偏移量
    CGFloat del = offestx - self.lastOffsetX;
    
    //切换图片
    NSInteger page = offestx / del + 1;
    YCLog(@"page == %zd",page);
    self.guide.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%ld",page]];
    self.guideLargeText.image = [UIImage imageNamed:[NSString stringWithFormat:@"guideLargeText%ld",page]];
    self.guideSmallText.image = [UIImage imageNamed:[NSString stringWithFormat:@"guideSmallText%ld",page]];

    //偏移子空间
    self.guide.x += del * 2;
    self.guideLargeText.x += del * 2;
    self.guideSmallText.x += del * 2;
    [UIView animateWithDuration:0.5 animations:^{
        self.guide.x -= del;
        self.guideLargeText.x -= del;
        self.guideSmallText.x -= del;
    }];
    
    self.lastOffsetX = offestx;
}
#define pageSize 4
#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return pageSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YCGuideCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *name = [NSString stringWithFormat:@"guide%ldBackground",indexPath.item + 1];
    cell.image = [UIImage imageNamed:name];
    
    [cell setIndexPath:indexPath count:pageSize];
    
    return cell;
}

@end
