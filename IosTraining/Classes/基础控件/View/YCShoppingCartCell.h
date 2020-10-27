//
//  YCShoppingCartCell.h
//  UI
//
//  Created by release on 2020/8/10.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YCWine,YCShoppingCartCell;
@protocol YCShoppingCartCellDelegate <NSObject>
@optional
-(void)wineCellDidClickAddButton:(YCShoppingCartCell*)cell;
-(void)wineCellDidClickMinusButton:(YCShoppingCartCell*)cell;

@end

@interface YCShoppingCartCell : UITableViewCell
@property(nonatomic,strong)YCWine *wine;
//代理属性
@property(nonatomic,weak)id<YCShoppingCartCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
