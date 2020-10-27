//
//  YCFreeCellStoryBoardController.h
//  UI
//
//  Created by release on 2020/8/7.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YCStatus;
@interface YCFreeCellStoryBoardController : UITableViewController

//微博模型
@property(nonatomic,strong)YCStatus *status;
@end

NS_ASSUME_NONNULL_END
