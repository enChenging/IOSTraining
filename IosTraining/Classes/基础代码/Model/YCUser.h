//
//  YCUser.h
//  UI
//
//  Created by release on 2020/8/24.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class YCDog;
@interface YCUser : NSObject<NSCoding>

@property(nonatomic,strong)NSString *name;

@property(nonatomic,assign)int age;

@property(nonatomic,strong)YCDog *dog;

@end

NS_ASSUME_NONNULL_END
