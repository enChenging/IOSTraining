//
//  YCPerson.h
//  UI
//
//  Created by release on 2020/7/11.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCPerson : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *age;
@property(nonatomic,copy)NSArray<NSString *> *friends;


//提供构造方法
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)personWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
