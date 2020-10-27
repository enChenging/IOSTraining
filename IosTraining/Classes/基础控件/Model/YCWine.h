//
//  YCWine.h
//  UI
//
//  Created by release on 2020/8/8.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCWine : NSObject

/**
 *  图标
 */
@property (nonatomic ,copy)NSString *image;

/**
 *  价格
 */
@property (nonatomic ,copy)NSString *money;

/**
 *  名字
 */
@property (nonatomic ,copy)NSString *name;

/**
 记录打勾的控件状态
 */
@property(nonatomic,assign,getter=isChecked)BOOL checked;

/**
 购买数
 */
@property (nonatomic ,assign)int count;

@end

NS_ASSUME_NONNULL_END
