//
//  YCBaseTableViewController.h
//  UI
//
//  Created by release on 2020/9/19.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCSettingTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface YCBaseTableViewController : UITableViewController
//数组总数
@property(nonatomic,strong)NSMutableArray *groups;
@end

NS_ASSUME_NONNULL_END
