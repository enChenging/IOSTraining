//
//  YCCarGroup.m
//  UI
//
//  Created by release on 2020/8/4.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCCarGroup.h"
#import "YCCar.h"

@implementation YCCarGroup


+ (instancetype)carGroupWithDict:(NSDictionary *)dict{
    
    YCCarGroup *group = [[self alloc]init];
    group.title = dict[@"title"];
    
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *carDict in dict[@"cars"]) {
        [temp addObject:[YCCar carWithDict:carDict]];
    }
    group.cars = temp;
    
    return group;
}
@end
