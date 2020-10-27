//
//  YCFlagItem.h
//  UI
//
//  Created by release on 2020/8/13.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlagItem : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)UIImage *icon;

+(instancetype)itemWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
