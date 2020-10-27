//
//  Person.h
//  IosTraining
//
//  Created by release on 2020/10/15.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person<__contravariant ObjectType> : NSObject

//语言
@property(nonatomic,strong)ObjectType language;

//Xcode5之前 id
//instancetype:自动识别当前类的对象
//+(instancetype)person;
+(__kindof Person *)person;

- (void)run:(NSInteger)metre;
- (void)eat;

@end

NS_ASSUME_NONNULL_END
