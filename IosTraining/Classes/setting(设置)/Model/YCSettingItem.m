//
//  YCSettingItem.m
//  UI
//
//  Created by release on 2020/9/19.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCSettingItem.h"

@implementation YCSettingItem


+ (instancetype)itemWithIcon:(UIImage *)icon title:(NSString *)title{
    YCSettingItem *item = [[self alloc]init];

    item.icon = icon;
    
    item.title = title;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title{
    
    return [self itemWithIcon:nil title:title];
}


@end
