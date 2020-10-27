//
//  YCShoppingCartController.m
//  UI
//
//  Created by release on 2020/8/10.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCShoppingCartController.h"
#import "MJExtension.h"
#import "YCShoppingCartCell.h"
#import "YCWine.h"

@interface YCShoppingCartController ()<UITableViewDelegate,UITableViewDataSource,YCShoppingCartCellDelegate>

@property(nonatomic,weak)UILabel *totalPriceLabel;
@property(nonatomic,weak)UIButton *buyBtn;
@property(nonatomic,strong)UITableView* tableView;
/** 酒数据 */
@property (nonatomic, strong)NSMutableArray *wineArray;
/**购买对象*/
@property(nonatomic,strong)NSMutableArray *shoppingCart;

@end

@implementation YCShoppingCartController

- (NSMutableArray *)shoppingCart{
    if (!_shoppingCart) {
        _shoppingCart = [NSMutableArray array];
    }
    return _shoppingCart;
}

- (NSMutableArray *)wineArray{
    if (!_wineArray) {
        _wineArray = [YCWine mj_objectArrayWithFilename:@"wine.plist"];
    }
    return _wineArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.alwaysBounceVertical = YES;
    _tableView.rowHeight = 70;
    [self.view addSubview:_tableView];
    
    UIView *bottomLayout = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50-64, kScreenWidth, 50)];
    bottomLayout.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomLayout];
    
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70,30)];
    [priceLabel setText:@"总价¥："];
    [priceLabel setTextColor:[UIColor blackColor]];
    [bottomLayout addSubview:priceLabel];
    
    UILabel *totalPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, 120,30)];
    self.totalPriceLabel = totalPriceLabel;
    [totalPriceLabel setText:@"0"];
    [totalPriceLabel setTextColor:[UIColor orangeColor]];
    [bottomLayout addSubview:totalPriceLabel];
    
    UIButton *clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-110, 10, 100,30)];
    [clearBtn setTitle:@"清空购物车" forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [clearBtn addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    [bottomLayout addSubview:clearBtn];
    
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-160, 10, 40,30)];
    self.buyBtn = buyBtn;
    buyBtn.enabled = NO;
    buyBtn.alpha = 0.5;
    [buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [buyBtn addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchUpInside];
    [bottomLayout addSubview:buyBtn];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-50-64, kScreenWidth, 1)];
    line.backgroundColor = [UIColor blackColor];
    line.alpha = 0.5;
    [self.view addSubview:line];
}

/**
 清空购物车
 */
-(void)clear:(UIButton*)button{
    for (YCWine *wine in self.shoppingCart) {
        wine.count = 0;
    }
    [self.tableView reloadData];
    self.totalPriceLabel.text = @"0";
    [self.shoppingCart removeAllObjects];
    self.buyBtn.enabled = NO;
    self.buyBtn.alpha = 0.5;
}

/**
 购买
 */
-(void)buy:(UIButton*)button{
    for (YCWine *wine in self.shoppingCart) {
        YCLog(@"购买了%d瓶%@",wine.count,wine.name);
    }
}

/**
 添加
 */
- (void)wineCellDidClickAddButton:(YCShoppingCartCell *)cell{
    int totalPrice = self.totalPriceLabel.text.intValue + cell.wine.money.intValue;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
    self.buyBtn.enabled = YES;
    self.buyBtn.alpha = 1;
    if (![self.shoppingCart containsObject:cell.wine]) {
        [self.shoppingCart addObject:cell.wine];
    }
    
}

/**
 减少
 */
- (void)wineCellDidClickMinusButton:(YCShoppingCartCell *)cell{
    int totalPrice = self.totalPriceLabel.text.intValue - cell.wine.money.intValue;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
    if (totalPrice == 0) {
        self.buyBtn.enabled = NO;
        self.buyBtn.alpha = 0.5;
    }
    if (cell.wine.count == 0) {
        [self.shoppingCart removeObject:cell.wine];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wineArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"wines";
    YCShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YCShoppingCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.wine = self.wineArray[indexPath.row];
    cell.delegate = self;
    return cell;
}


@end
