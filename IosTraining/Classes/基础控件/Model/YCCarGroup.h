//
//  YCCarGroup.h
//  UI
//
//  Created by release on 2020/8/4.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCCarGroup : NSObject

@property(nonatomic,copy)NSString *title;

@property(nonatomic,strong)NSArray *cars;

+(instancetype)carGroupWithDict:(NSDictionary*) dict;

@end

NS_ASSUME_NONNULL_END
