//
//  YCTabBar.h
//  UI
//
//  Created by release on 2020/9/16.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YCTabBar;
@protocol YCTabBarDelegate <NSObject>

- (void)tabBar:(YCTabBar *)tabBar didSelectBtn:(NSInteger)selectIndex;

@end

@interface YCTabBar : UIView

//存放的都TabBarItem模型.
@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, weak) id<YCTabBarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
