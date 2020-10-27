//
//  YCFindVC.m
//  UI
//
//  Created by release on 2020/9/18.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCFindVC.h"

@interface YCFindVC ()

@end

@implementation YCFindVC

//第一次加载View的时候调用
//如果自定义View，重写这个方法
//- (void)loadView{
//
//    //在这个方法里面不能调用self.view.bounds,如果调用会造成死循环
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    self.view = imageView;
//    //设置背景图片
//    imageView.image = [UIImage imageNamed:@"NLArenaBackground"];
//    //设置允许用户交互
//    imageView.userInteractionEnabled = YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置titleView
    UISegmentedControl *segMentControl = [[UISegmentedControl alloc]initWithItems:@[@"足球",@"篮球"]];
    //2.设置背景图片
    [segMentControl setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentBG"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [segMentControl setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentSelectedBG"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    //3.设置字体颜色
    [segMentControl setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor]} forState:UIControlStateNormal];
    
    //4.设置选中的索引
    segMentControl.selectedSegmentIndex = 0;
    
    //5.设置前景颜色
    segMentControl.tintColor = [UIColor colorWithRed:70/255.0 green:156/255.0 blue:159/255.0 alpha:1];
    
    self.navigationItem.titleView = segMentControl;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

//当cell将要显示的时候调用
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //当cell将要现实的时候做动画从右向左的动画
    //1.将cell平移到屏幕外
    cell.transform = CGAffineTransformMakeTranslation(kScreenWidth, 0);
    //2.让cell复位
    [UIView animateWithDuration:0.5 animations:^{
        cell.transform = CGAffineTransformIdentity;
    }];
    
}

@end
