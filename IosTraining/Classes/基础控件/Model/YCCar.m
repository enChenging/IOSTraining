//
//  YCCar.m
//  UI
//
//  Created by release on 2020/8/4.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCCar.h"

@implementation YCCar

+ (instancetype)carWithDict:(NSDictionary *)dict{
    
    YCCar *car = [[self alloc]init];
//    car.name = dict[@"name"];
//    car.icon = dict[@"icon"];
    [car setValuesForKeysWithDictionary:dict];
    return car;
}
@end
