//
//  YCEnumVC.m
//  IosTraining
//
//  Created by release on 2020/10/9.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCEnumVC.h"

//第一种写法
typedef enum{
    YCEnumTypeTop,
    YCEnumTypeBottom,
}YCEnumType;

//第二种枚举，定义类型
typedef NS_ENUM(NSInteger,YCType) {
    YCTypeTop,
    YCTypeBottom,
};

//第三种枚举，位移枚举
//一个参数可以传递多个值
//如果是位移枚举，观察一个枚举值，如果该枚举值!=0,那么可以默认传0做参数，如果传0做参数，那么效率更高
typedef NS_OPTIONS(NSInteger, YCActionType) {
    YCActionTypeTop = 1<<0,  //1*2(0) = 1
    YCActionTypeBottom = 1<<1,  //1*2(1) = 2
    YCActionTypeLeft = 1<<2,  //1*2(2) = 4
    YCActionTypeRight = 1<<3,  //1*2(3) = 8
};

@interface YCEnumVC ()

@end

@implementation YCEnumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test:YCActionTypeTop|YCActionTypeBottom|YCActionTypeLeft|YCActionTypeRight];
}

/**
 按位与 &  1&1==1  1&0==0  0&0==0  只要有0则为0
 按位或 ｜ 1|1==1   1|0==1    0|0==0    只要有1则为1
 */
-(void)test:(YCActionType)type{
    
    if (type & YCActionTypeTop) {
        YCLog(@"向上-------");
    }
    
    if (type & YCActionTypeBottom) {
        YCLog(@"向下-------");
    }
    
    if (type & YCActionTypeLeft) {
        YCLog(@"向左-------");
    }
    
    if (type & YCActionTypeRight) {
        YCLog(@"向右-------");
    }
    
}

@end
