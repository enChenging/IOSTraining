//
//  NSObject+Model.h
//  IosTraining
//
//  Created by release on 2020/10/22.
//  Copyright © 2020 Mr. release. All rights reserved.
//
/**
 字典转模型
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Model)

+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
