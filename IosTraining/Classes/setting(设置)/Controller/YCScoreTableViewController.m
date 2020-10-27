//
//  YCScoreTableViewController.m
//  UI
//
//  Created by release on 2020/9/19.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCScoreTableViewController.h"

@interface YCScoreTableViewController ()

@end

@implementation YCScoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpGroup0];
    
    [self setUpGroup1];
    
    [self setUpGroup2];
    [self setUpGroup2];
    [self setUpGroup2];
    [self setUpGroup2];
    [self setUpGroup2];
}


-(void)setUpGroup0{
    
    YCSettingSwitchItem *item = [YCSettingSwitchItem itemWithTitle:@"关注比赛"];
    YCSettingGroup *group = [YCSettingGroup groupWithItems:@[item]];
    [self.groups addObject:group];
}

-(void)setUpGroup1{
    YCSettingItem *item = [YCSettingItem itemWithTitle:@"起始时间"];
    item.subTitle = @"00:00";
    YCSettingGroup *group = [YCSettingGroup groupWithItems:@[item]];
    [self.groups addObject:group];
}

-(void)setUpGroup2{
    YCSettingItem *item = [YCSettingItem itemWithTitle:@"结束时间"];
    item.subTitle = @"00:00";
    
//    __weak typeof(self) weakSelf = self;
    __unsafe_unretained typeof(self) weakSelf = self;
    item.operationBlock = ^(NSIndexPath *indexPath){
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
        UITextField *textField = [[UITextField alloc]init];
        [cell addSubview:textField];
        [textField becomeFirstResponder];
    };
    YCSettingGroup *group = [YCSettingGroup groupWithItems:@[item]];
    [self.groups addObject:group];
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
@end
