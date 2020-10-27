//
//  YCSettingSwitchItem.h
//  UI
//
//  Created by release on 2020/9/19.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCSettingItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface YCSettingSwitchItem : YCSettingItem

//开关状态
@property(nonatomic,assign,getter=isOn)BOOL on;

@end

NS_ASSUME_NONNULL_END
