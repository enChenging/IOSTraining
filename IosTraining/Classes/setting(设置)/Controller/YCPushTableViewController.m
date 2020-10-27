//
//  YCPushTableViewController.m
//  UI
//
//  Created by release on 2020/9/19.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCPushTableViewController.h"
#import "YCScoreTableViewController.h"
#import "YCAwardTableViewController.h"

@interface YCPushTableViewController ()

@end

@implementation YCPushTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //第0组
    [self setUpGroup0];
}

-(void)setUpGroup0{

    
    YCSettingArrowItem *item = [YCSettingArrowItem itemWithTitle:@"开奖推送"];
    item.desVC = [YCAwardTableViewController class];
    
    YCSettingArrowItem *item1 = [YCSettingArrowItem itemWithTitle:@"比分直播"];
    item1.desVC = [YCScoreTableViewController class];
    
    YCSettingArrowItem *item2 = [YCSettingArrowItem itemWithTitle:@"中奖活动"];

    YCSettingArrowItem *item3 = [YCSettingArrowItem itemWithTitle:@"购彩大厅"];

    YCSettingGroup *group = [YCSettingGroup groupWithItems:@[item,item1,item2,item3]];
    [self.groups addObject:group];
}

@end
