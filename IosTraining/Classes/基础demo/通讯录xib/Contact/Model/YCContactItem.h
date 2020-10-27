//
//  YCContactItem.h
//  UI
//
//  Created by release on 2020/8/16.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCContactItem : NSObject

@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)NSString *phoneNum;

+(instancetype)itemWithName:(NSString *)name phoneNum:(NSString *)phoneNum;

@end

NS_ASSUME_NONNULL_END
