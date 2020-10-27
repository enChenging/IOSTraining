//
//  YCAwardTableViewController.m
//  UI
//
//  Created by release on 2020/9/19.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCAwardTableViewController.h"

@interface YCAwardTableViewController ()

@end

@implementation YCAwardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
      [self setUpGroup0];
      
}
-(void)setUpGroup0{
    
    YCSettingSwitchItem *item = [YCSettingSwitchItem itemWithTitle:@"双色球"];
    item.subTitle = @"每天开奖";
    YCSettingSwitchItem *item1 = [YCSettingSwitchItem itemWithTitle:@"双色球"];
    item1.subTitle = @"每天开奖";
    YCSettingSwitchItem *item2 = [YCSettingSwitchItem itemWithTitle:@"双色球"];
    item2.subTitle = @"每天开奖";
    YCSettingSwitchItem *item3 = [YCSettingSwitchItem itemWithTitle:@"双色球"];
    item3.subTitle = @"每天开奖";
    YCSettingSwitchItem *item4 = [YCSettingSwitchItem itemWithTitle:@"双色球"];
    item4.subTitle = @"每天开奖";
    
    YCSettingGroup *group = [YCSettingGroup groupWithItems:@[item,item1,item2,item3,item4]];
    [self.groups addObject:group];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YCSettingTableViewCell *cell = [YCSettingTableViewCell cellWithTableView:tableView cellStyle:UITableViewCellStyleSubtitle];
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    
    YCSettingGroup *group = self.groups[indexPath.section];
    YCSettingItem *item = group.items[indexPath.row];
    cell.item = item;
    
    return cell;
}

@end
