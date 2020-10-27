//
//  NSObject+Property.h
//  IosTraining
//
//  Created by release on 2020/10/15.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Property)

// @property分类:只会生成get,set方法声明,不会生成实现,也不会生成下划线成员属性
@property NSString *name;

@end

NS_ASSUME_NONNULL_END
