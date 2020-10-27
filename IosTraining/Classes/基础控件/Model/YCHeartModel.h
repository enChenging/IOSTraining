//
//  YCHeartModel.h
//  UI
//
//  Created by release on 2020/7/11.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCHeartModel : NSObject

@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *name;

-(instancetype)initWithIcon:(NSString *)icon name:(NSString *)name;
+(instancetype)HeartWithIcon:(NSString *)icon name:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
