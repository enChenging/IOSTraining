//
//  YCCar.h
//  UI
//
//  Created by release on 2020/8/4.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCCar : NSObject

@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *name;

+(instancetype)carWithDict:(NSDictionary*)dict;
@end

NS_ASSUME_NONNULL_END
