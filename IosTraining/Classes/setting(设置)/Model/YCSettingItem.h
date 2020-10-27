//
//  YCSettingItem.h
//  UI
//
//  Created by release on 2020/9/19.
//  Copyright © 2020 Mr. release. All rights reserved.
//
//typedef enum : NSUInteger {
//    YCSettingItemRightViewStateNone,
//    YCSettingItemRightViewStateArrow,
//    YCSettingItemRightViewStateSwitch,
//} YCSettingItemRightViewState;
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCSettingItem : NSObject

@property(nonatomic,strong)UIImage *icon;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *subTitle;

////条目的右侧视图
//@property(nonatomic,assign)YCSettingItemRightViewState type;

+(instancetype)itemWithIcon:(UIImage *)icon title:(NSString *)title;

+(instancetype)itemWithTitle:(NSString *)title;

//点击这一行要做的事
@property(nonatomic,copy)void(^operationBlock)(NSIndexPath *indexPath);
@end

NS_ASSUME_NONNULL_END
