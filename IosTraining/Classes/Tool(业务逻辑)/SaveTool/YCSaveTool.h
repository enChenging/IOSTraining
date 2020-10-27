//
//  YCSaveTool.h
//  UI
//
//  Created by release on 2020/9/19.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCSaveTool : NSObject

+ (nullable id)objectForKey:(NSString *)defaultName;

+ (void)setObject:(nullable id)value forKey:(NSString *)defaultName;

@end

NS_ASSUME_NONNULL_END
