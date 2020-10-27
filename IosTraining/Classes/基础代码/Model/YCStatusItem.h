//
//  YCStatusItem.h
//  IosTraining
//
//  Created by release on 2020/10/22.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCStatusItem : NSObject

@property(nonatomic,strong)NSString *source;

@property(nonatomic,assign)NSInteger reposts_count;

@property(nonatomic,strong)NSArray *pic_urls;

@property(nonatomic,strong)NSString *created_at;

@property(nonatomic,assign)BOOL isA;

@property(nonatomic,assign)NSInteger attitudes_count;

@property(nonatomic,strong)NSString *idstr;

@property(nonatomic,strong)NSString *text;

@property(nonatomic,assign)NSInteger comments_count;

@property(nonatomic,strong)NSDictionary *user;

@end

NS_ASSUME_NONNULL_END
