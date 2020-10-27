//
//  YCPerson.m
//  UI
//
//  Created by release on 2020/7/11.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCPerson.h"

@implementation YCPerson

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.age = dict[@"age"];
        self.friends = dict[@"friends"];
    }
    return self;
}

+ (instancetype)personWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}

@end
