//
//  YCTopicListVCViewController.m
//  IosTraining
//
//  Created by release on 2020/11/27.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCTopicListVCViewController.h"
#import "YCTopicListCell.h"

@interface YCTopicListVCViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)NSArray *modules;
@end

@implementation YCTopicListVCViewController

static NSString * const ID = @"YCTopicListCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modules = @[@"语文",@"数学",@"英语",@"历史",@"地理",@"生物",@"政治",@"物理",@"化学"];
    
    //布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = self.view.bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    
    //collectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.pagingEnabled = YES;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor redColor];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YCTopicListCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modules.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YCTopicListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.module = self.modules[indexPath.item];
//    YCLog(@"%zd -- %p",indexPath.item,cell)
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    YCLog(@"index -- %d",(int)(scrollView.contentOffset.x / scrollView.frame.size.width));
}

@end

