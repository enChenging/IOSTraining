//
//  YCSettingTableVC.m
//  UI
//
//  Created by release on 2020/9/19.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCSettingTableVC.h"
#import "YCSettingItem.h"
#import "YCSettingGroup.h"
#import "YCSettingArrowItem.h"
#import "YCSettingSwitchItem.h"
#import "YCSettingTableViewCell.h"
#import "YCPushTableViewController.h"
#import "MBProgressHUD+XMG.h"

@interface YCSettingTableVC ()

@end

@implementation YCSettingTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //第0组
    [self setUpGroup0];
    
    //第1组
    [self setUpGroup1];
    
    //第2组
    [self setUpGroup2];
}

-(void)setUpGroup0{
    //第0组
    YCSettingItem *item = [YCSettingArrowItem itemWithIcon:[UIImage imageNamed:@"RedeemCode"] title:@"使用兑换码"];
    
    YCSettingGroup *group = [YCSettingGroup groupWithItems:@[item]];
    group.headerTitle = @"111111111";
    group.footTitle = @"2222222";
    //将行模型数组添加到数组总数
    [self.groups addObject:group];
}

-(void)setUpGroup1{
    //第1组
    YCSettingArrowItem *item11 = [YCSettingArrowItem itemWithIcon:[UIImage imageNamed:@"RedeemCode"] title:@"推送和提醒"]; __weak typeof (self) weakSelf = self;
    item11.operationBlock = ^(NSIndexPath *indexPath){
        UIViewController *vc = [[YCPushTableViewController alloc]init];
        vc.title = @"123";
        [weakSelf.navigationController pushViewController:vc animated:YES];
        //self -> _groups
        //在block中如果访问它下划线的成员属性，会造成循环引用
        NSLog(@"%@",weakSelf.groups);
    };
    
    YCSettingSwitchItem *item12 = [YCSettingSwitchItem itemWithIcon:[UIImage imageNamed:@"RedeemCode"] title:@"使用兑换码"];
    item12.on = YES;
    
    YCSettingItem *item13 = [YCSettingSwitchItem itemWithIcon:[UIImage imageNamed:@"RedeemCode"] title:@"使用兑换码"];
    
    YCSettingItem *item14 = [YCSettingSwitchItem itemWithIcon:[UIImage imageNamed:@"RedeemCode"] title:@"使用兑换码"];
    
    NSArray *items2 = @[item11,item12,item13,item14];
    
    YCSettingGroup *group = [YCSettingGroup groupWithItems:items2];
    group.headerTitle = @"111rfewf";
    group.footTitle = @"222ewrewrwr";
    [self.groups addObject:group];
}

-(void)setUpGroup2{
    //第2组
    YCSettingItem *item21 = [YCSettingItem itemWithIcon:[UIImage imageNamed:@"RedeemCode"] title:@"检查版本更新"];
    item21.operationBlock = ^(NSIndexPath *indexPath){
        [MBProgressHUD showSuccess:@"没有版本更新"];
    };
    
    YCSettingItem *item22 = [YCSettingItem itemWithIcon:[UIImage imageNamed:@"RedeemCode"] title:@"使用兑换码"];
    
    
    YCSettingItem *item23 = [YCSettingItem itemWithIcon:[UIImage imageNamed:@"RedeemCode"] title:@"使用兑换码"];
    
    
    YCSettingItem *item24 = [YCSettingItem itemWithIcon:[UIImage imageNamed:@"RedeemCode"] title:@"使用兑换码"];
    
    
    NSArray *items3 = @[item21,item22,item23,item24];
    
    YCSettingGroup *group = [YCSettingGroup groupWithItems:items3];
    group.headerTitle = @"111r44444f";
    group.footTitle = @"222ewr444444r";
    [self.groups addObject:group];
    
}

- (void)dealloc
{
    YCLog(@"%s",__FUNCTION__);
}

@end
