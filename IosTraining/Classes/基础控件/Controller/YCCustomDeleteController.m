//
//  YCCustomDeleteController.m
//  UI
//
//  Created by release on 2020/8/8.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCCustomDeleteController.h"
#import "MJExtension.h"
#import "YCCustomDeleteCell.h"
#import "YCWine.h"

@interface YCCustomDeleteController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSArray* ceshiArray;
@property(nonatomic,strong)UIButton* alertBtn;
/** 酒数据 */
@property (nonatomic, strong) NSMutableArray *wineArray;
/**记录用户选中行的索引*/
@property (nonatomic, strong) NSMutableArray *selectedIndexPath;
@end

@implementation YCCustomDeleteController

- (NSMutableArray *)selectedIndexPath{
    if (!_selectedIndexPath) {
        _selectedIndexPath = [NSMutableArray array];
    }
    return _selectedIndexPath;
}

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
    
    _alertBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 40, 70, 30)];
    [_alertBtn setTitle:@"批量删除" forState:UIControlStateNormal];
    _alertBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_alertBtn setTag:(101)];
    [_alertBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_alertBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_alertBtn setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:_alertBtn];
  
    
    //告诉tableView在编辑模式下可以多选
    _tableView.allowsMultipleSelectionDuringEditing = YES;
    
}

-(void)pressBtn:(UIButton*)btn{
    
    switch (btn.tag) {
        case 101:{
            NSMutableArray *deletedWine = [NSMutableArray array];
            for (NSIndexPath *indexPath in self.selectedIndexPath) {
                [deletedWine addObject:self.wineArray[indexPath.row]];
            }
            [self.wineArray removeObjectsInArray:deletedWine];
            [self.tableView deleteRowsAtIndexPaths:self.selectedIndexPath withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.selectedIndexPath removeAllObjects];
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
    YCCustomDeleteCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YCCustomDeleteCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.wine = self.wineArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YCWine *wine = self.wineArray[indexPath.row];
    if (wine.isChecked) {
        wine.checked = NO;
        [self.selectedIndexPath removeObject:indexPath];
    }else{
        wine.checked = YES;
        [self.selectedIndexPath addObject:indexPath];
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


@end
