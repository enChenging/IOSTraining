//
//  YCFlagItem.m
//  UI
//
//  Created by release on 2020/8/13.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "FlagItem.h"

@implementation FlagItem

+ (instancetype)itemWithDict:(NSDictionary *)dict{
    
    FlagItem *item = [[FlagItem alloc]init];
    
//    [item setValuesForKeysWithDictionary:dict];
//    setValuesForKeysWithDictionary:实现原理
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [item setValue:obj forKey:key];
    }];
    
    /**
     setValue:forKey:实现原理
     1.查该对应的 key值有没有set方法，如果有就会自动调用set方法进行赋值
     2.如果有set方法，那么它就会判断有没有key相同名称且带有下划线的属性，如果有就给该属性赋值
     3.如果没有带有下划线的属性，那么它就会查看有没有根key值相同名称的属性，如果有就给该属性赋值
     4.如果还没有跟key值相同名称的属性，那么就会报错
     */
 
    return item;
}

- (void)setIcon:(UIImage *)icon{
    NSString *iconName = (NSString *)icon;
    _icon = [UIImage imageNamed:iconName];
}

@end
