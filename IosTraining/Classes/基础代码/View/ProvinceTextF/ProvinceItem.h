//
//  ProvinceItem.h
//  UI
//
//  Created by release on 2020/8/13.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProvinceItem : NSObject

//每个省的城市
@property(nonatomic,strong)NSArray *cities;
//省的名称
@property(nonatomic,strong)NSString *name;

+(instancetype)provinceItemWithDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
