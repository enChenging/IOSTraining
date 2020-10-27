//
//  UIView+Frame.h
//  UI
//
//  Created by release on 2020/9/17.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

//在分类中 @property 只会生成get, set 方法，并不会生成下划线的成员属性
@property(nonatomic,assign)CGFloat width;

@property(nonatomic,assign)CGFloat height;

@property(nonatomic,assign)CGFloat x;

@property(nonatomic,assign)CGFloat y;
@end

NS_ASSUME_NONNULL_END
