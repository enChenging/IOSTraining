//
//  YCTableViewEditController.m
//  UI
//
//  Created by release on 2020/8/7.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCTableViewEditController.h"
#import "MJExtension.h"
#import "YCWineCell.h"
#import "YCWine.h"

@interface YCTableViewEditController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSArray* ceshiArray;
@property(nonatomic,strong)UIButton* alertBtn;
/** 酒数据 */
@property (nonatomic, strong) NSMutableArray *wineArray;

@end

@implementation YCTableViewEditController

- (NSMutableArray *)wineArray{
    if (!_wineArray) {
        _wineArray = [YCWine mj_objectArrayWithFilename:@"wine.plist"];
    }
    return _wineArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 90, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.alwaysBounceVertical = YES;
    [self.view addSubview:_tableView];
    
    
    for (int i = 0; i<5; i++) {
        _alertBtn = [[UIButton alloc]initWithFrame:CGRectMake(70*i+10, 30, 65, 30)];
        if (i == 0) {
            [_alertBtn setTitle:@"添加" forState:UIControlStateNormal];
        }else if(i == 1){
            [_alertBtn setTitle:@"删除" forState:UIControlStateNormal];
        }else if(i == 2){
            [_alertBtn setTitle:@"修改" forState:UIControlStateNormal];
        }else if(i == 3){
            [_alertBtn setTitle:@"编辑" forState:UIControlStateNormal];
        }else if(i == 4){
            [_alertBtn setTitle:@"批量删除" forState:UIControlStateNormal];
        }
        _alertBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_alertBtn setTag:(101+i)];
        [_alertBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_alertBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_alertBtn setBackgroundColor:[UIColor orangeColor]];
        [self.view addSubview:_alertBtn];
    }
    
    //告诉tableView在编辑模式下可以多选
    _tableView.allowsMultipleSelectionDuringEditing = YES;
    
}

-(void)pressBtn:(UIButton*)btn{
    
    switch (btn.tag) {
        case 101:{
            YCWine *wine = [[YCWine alloc]init];
            wine.image = @"newWine";
            wine.money = @"100000.0";
            wine.name = @"上等茅台坛子酒";
            [self.wineArray insertObject:wine atIndex:0];
            //全部刷新
//            [_tableView reloadData];
            //局部刷新
            NSArray *indexPaths = @[
                [NSIndexPath indexPathForRow:0 inSection:0]
            ];
            [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
        }
            break;
        case 102:{
            [self.wineArray removeObjectAtIndex:0];
            //局部刷新
            NSArray *indexPaths = @[
                [NSIndexPath indexPathForRow:0 inSection:0]
            ];
            [_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationMiddle];
        }
            break;
        case 103:{
            YCWine *wine = self.wineArray[0];
            wine.name = @"大啤酒🍺";
            YCWine *wine2 = self.wineArray[1];
            wine2.money = @"10000000000000";
            NSArray *indexPaths = @[
                [NSIndexPath indexPathForRow:0 inSection:0],
                [NSIndexPath indexPathForRow:1 inSection:0]
            ];
            [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
        }
            break;
        case 104:{
            [self.tableView setEditing:!self.tableView.isEditing animated:YES];
        }
            break;
        case 105:{
            NSMutableArray *deletedWine = [NSMutableArray array];
            for (NSIndexPath *indexPath in self.tableView.indexPathsForSelectedRows) {
                [deletedWine addObject:self.wineArray[indexPath.row]];
            }
            [self.wineArray removeObjectsInArray:deletedWine];
            [self.tableView deleteRowsAtIndexPaths:self.tableView.indexPathsForSelectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;
        default:
            break;
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wineArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"wine";
    YCWineCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YCWineCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.wine = self.wineArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
/**
 *  只要实现这个方法,就拥有左滑删除功能
 *  点击左滑出现的Delete按钮 会调用这个
 */
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.wineArray removeObjectAtIndex:indexPath.row];
//    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
//}

/**
 *  修改默认Delete按钮的文字
 */
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return @"删除";
//}

/**
 左滑出现什么按钮
 */
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"关注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //退出编辑模式
        self.tableView.editing = NO;
    }];
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
           //删除
           [self.wineArray removeObjectAtIndex:indexPath.row];
           [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
       }];
    
    return @[action2,action];
}

@end
