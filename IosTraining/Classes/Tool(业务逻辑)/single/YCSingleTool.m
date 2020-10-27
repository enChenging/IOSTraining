//
//  YCSingleTool.m
//  UI
//
//  Created by release on 2020/9/26.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCSingleTool.h"

@implementation YCSingleTool

static YCSingleTool *_instance;

//alloc ----->allocWithZone
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    //加互斥锁解决线程安全问题
//    @synchronized (self) {
//        if (_instance == nil) {
//            _instance = [super allocWithZone:zone];
//        }
//    }
    
    //本身就是线程安全的
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

//提供类方法
+ (instancetype)shareSingleTool{
    
    return [[self alloc]init];
}

//严谨
+ (id)copyWithZone:(struct _NSZone *)zone{
    return _instance;
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return _instance;
}

#if __has_feature(objc_arc)
//条件满足 ARC
#else
//MRC
- (oneway void)release{
    
}

- (instancetype)retain{
    return _instance;
}

//习惯
- (NSUInteger)retainCount{
    return MAXFLOAT;
}

#endif

@end
