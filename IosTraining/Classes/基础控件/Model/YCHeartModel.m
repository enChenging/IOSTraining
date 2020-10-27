//
//  YCHeartModel.m
//  UI
//
//  Created by release on 2020/7/11.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCHeartModel.h"

@implementation YCHeartModel

- (instancetype)initWithIcon:(NSString *)icon name:(NSString *)name{
    if (self = [super init]) {
        self.icon = icon;
        self.name = name;
    }
    
    return self;
}

+ (instancetype)HeartWithIcon:(NSString *)icon name:(NSString *)name{
    
    return [[self alloc]initWithIcon:icon name:name];
}

@end
