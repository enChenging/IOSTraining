//
//  YCBaseTableViewController.m
//  UI
//
//  Created by release on 2020/9/19.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCBaseTableViewController.h"

@interface YCBaseTableViewController ()

@end

@implementation YCBaseTableViewController

- (NSMutableArray *)groups{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        return [super initWithStyle:UITableViewStyleGrouped];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    YCSettingGroup *group = self.groups[section];
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YCSettingTableViewCell *cell = [YCSettingTableViewCell cellWithTableView:tableView];
    
    YCSettingGroup *group = self.groups[indexPath.section];
    YCSettingItem *item = group.items[indexPath.row];
    cell.item = item;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    YCSettingGroup *group = self.groups[section];
    
    return group.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    YCSettingGroup *group = self.groups[section];
    
    return group.footTitle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YCSettingGroup *group = self.groups[indexPath.section];
    YCSettingItem *item = group.items[indexPath.row];
    
    if (item.operationBlock) {
        item.operationBlock(indexPath);
    }else if ([item isKindOfClass:[YCSettingArrowItem class]]) {
        //跳转
        YCSettingArrowItem *arrowItem = (YCSettingArrowItem *)item;
        if (arrowItem.desVC) {
            UIViewController *vc = [[arrowItem.desVC alloc]init];
            vc.title = item.title;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}



@end
