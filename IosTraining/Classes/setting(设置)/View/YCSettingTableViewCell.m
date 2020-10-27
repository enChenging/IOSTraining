//
//  YCSettingTableViewCell.m
//  UI
//
//  Created by release on 2020/9/19.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCSettingTableViewCell.h"
#import "YCSettingItem.h"
#import "YCSettingGroup.h"
#import "YCSettingArrowItem.h"
#import "YCSettingSwitchItem.h"
#import "YCSettingTableViewCell.h"

@implementation YCSettingTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView cellStyle:(UITableViewCellStyle)cellSytle{
    static NSString *ID = @"cell";
    YCSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[YCSettingTableViewCell alloc]initWithStyle:cellSytle reuseIdentifier:ID];
    }
    
    return cell;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    return [self cellWithTableView:tableView cellStyle:UITableViewCellStyleValue1];
}

- (void)setItem:(YCSettingItem *)item{
    _item = item;
    self.imageView.image = item.icon;
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subTitle;
    
    //设置右侧视图
    [self setupRightView];
}

-(void)setupRightView{
    if ([_item isKindOfClass: [YCSettingArrowItem class]]) {
           self.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right"]];
       }else if ([_item isKindOfClass: [YCSettingSwitchItem class]]){
           YCSettingSwitchItem *swi =  (YCSettingSwitchItem *)_item;
           
           UISwitch *sw = [[UISwitch alloc]init];
           sw.on = swi.isOn;
           self.accessoryView = sw;
           
       }else{
           self.accessoryView = nil;
       }
}
@end
