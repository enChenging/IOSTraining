//
//  YCContactItem.m
//  UI
//
//  Created by release on 2020/8/16.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCContactItem.h"

@implementation YCContactItem

+ (instancetype)itemWithName:(NSString *)name phoneNum:(NSString *)phoneNum{
    YCContactItem *contact = [[self alloc]init];
    contact.name = name;
    contact.phoneNum = phoneNum;
    return contact;
}

@end
