//
//  YCSettingGroup.m
//  UI
//
//  Created by release on 2020/9/19.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCSettingGroup.h"

@implementation YCSettingGroup


+ (instancetype)groupWithItems:(NSArray *)items{
    YCSettingGroup *group = [[self alloc]init];
    
    group.items = items;
    
    return group;
}
@end
