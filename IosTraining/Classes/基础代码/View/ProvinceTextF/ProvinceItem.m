//
//  ProvinceItem.m
//  UI
//
//  Created by release on 2020/8/13.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "ProvinceItem.h"

@implementation ProvinceItem

+ (instancetype)provinceItemWithDict:(NSDictionary *)dict{
    ProvinceItem *item = [[self alloc]init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}
@end
