//
//  YCUserInfoVC.m
//  UI
//
//  Created by release on 2020/8/25.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCUserInfoVC.h"
#import "UIImage+Image.h"


#define oriOfftY -244
#define oriHeight 200

@interface YCUserInfoVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstr;

@end

@implementation YCUserInfoVC

static NSString *ID = @"YCUserInfoVC";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;


    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    //不要自动设置偏移量
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //当调用contentInset会自动调用scrollViewDidScroll
    self.tableView.contentInset = UIEdgeInsetsMake(244, 0, 0, 0);
    
    //设置标题
    UILabel *title = [[UILabel alloc] init];
    title.text = @"个人详情页";
    [title sizeToFit];
    title.textColor = [UIColor colorWithWhite:0 alpha:0];
    
    self.navigationItem.titleView = title;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //求偏移量
    //当前点 - 最原始的点
    NSLog(@"current======%f",scrollView.contentOffset.y);
    CGFloat offset = scrollView.contentOffset.y - oriOfftY;
    NSLog(@"offset======%f",offset);
    
    CGFloat h = oriHeight - offset;
    if (h < 64) {
        h = 64;
    }
    self.heightConstr.constant = h;
    
    
    //根据透明度来生成图片
    //找最大值/
    CGFloat alpha = offset * 1 / 136.0;
    NSLog(@"alpha======%f",alpha);
    if (alpha >= 1) {
        alpha = 0.99;
    }
    
    //拿到标题
    UILabel *titleL = (UILabel *)self.navigationItem.titleView;
    titleL.textColor = [UIColor colorWithWhite:0 alpha:alpha];
    
    //把颜色生成图片
    UIColor *alphaColor = [UIColor colorWithWhite:1 alpha:alpha];
    UIImage *alphaImage = [UIImage imageWithColor:alphaColor];
    //修改导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:alphaImage forBarMetrics:UIBarMetricsDefault];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.textLabel.text = @"release";
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIImage *image = [UIImage imageWithColor:[UIColor brownColor]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

@end
