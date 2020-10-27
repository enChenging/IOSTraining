//
//  YCSettingGroup.h
//  UI
//
//  Created by release on 2020/9/19.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCSettingItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface YCSettingGroup :YCSettingItem

@property(nonatomic,copy)NSString *headerTitle;

@property(nonatomic,copy)NSString *footTitle;

@property(nonatomic,strong)NSArray *items;

+(instancetype)groupWithItems:(NSArray *)items;
@end

NS_ASSUME_NONNULL_END
