//
//  YCCoustomCollectionVC.m
//  IosTraining
//
//  Created by release on 2020/10/27.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCCoustomCollectionVC.h"
#import "YCPhotoCell.h"
#import "YCFlowLayout.h"

@interface YCCoustomCollectionVC ()<UICollectionViewDataSource>

@end

@implementation YCCoustomCollectionVC

static NSString * const ID  =@"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //UICollectionView使用注意点
    //1.创建UICollectionView必须要有布局参数
    //2.cell必须通过注册
    //3.cell必须自定义，系统cell没有任何子控件
    
    //流水布局
    YCFlowLayout *layout = ({

        layout = [[YCFlowLayout alloc]init];
        //设置尺寸
        layout.itemSize = CGSizeMake(160, 160);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat margin = (kScreenWidth - 160) * 0.5;
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        //设置最小行间距
        layout.minimumLineSpacing = 50;
        layout;
    });
    
    UICollectionView *collectionView = ({
        
        collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor brownColor];
        collectionView.center  = self.view.center;
        collectionView.bounds = CGRectMake(0, 0, kScreenWidth, 200);
        [self.view addSubview:collectionView];
        //设置数据源
        collectionView.dataSource = self;
        collectionView;
    });
    
    //注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YCPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YCPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"%ld",indexPath.item + 1];
    
    cell.image = [UIImage imageNamed:imageName];
    
    return cell;
}


@end
