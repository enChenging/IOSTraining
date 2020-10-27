//
//  NSObject+Property.m
//  IosTraining
//
//  Created by release on 2020/10/15.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/message.h>

@implementation NSObject (Property)

//static NSString *_name;

- (void)setName:(NSString *)name{
    // 让这个字符串与当前对象产生联系
    
//    _name = name;
    // object:给哪个对象添加属性
    // key:属性名称
    // value:属性值
    // policy:保存策略
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name{
    return objc_getAssociatedObject(self, @"name");
}

@end
