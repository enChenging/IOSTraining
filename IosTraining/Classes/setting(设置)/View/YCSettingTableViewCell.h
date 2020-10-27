//
//  YCSettingTableViewCell.h
//  UI
//
//  Created by release on 2020/9/19.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCSettingItem.h"
#import "YCSettingGroup.h"
#import "YCSettingArrowItem.h"
#import "YCSettingSwitchItem.h"

@class YCSettingItem;

NS_ASSUME_NONNULL_BEGIN

@interface YCSettingTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(instancetype)cellWithTableView:(UITableView *)tableView cellStyle:(UITableViewCellStyle)cellSytle;

@property(nonatomic,strong)YCSettingItem *item;
@end

NS_ASSUME_NONNULL_END
