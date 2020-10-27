//
//  YCAPP.h
//  UI
//
//  Created by release on 2020/9/26.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCAPP : NSObject


@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *download;

+(instancetype)appWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
