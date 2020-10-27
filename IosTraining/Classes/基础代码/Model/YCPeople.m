//
//  YCPeople.m
//  UI
//
//  Created by release on 2020/8/11.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCPeople.h"

/**
 创建单例
 */
@implementation YCPeople

//1.程序一运行，就创建对象
static YCPeople *_instance;
//当类被加载到内存当中就会调用
+ (void)load{
//    YCLog(@"%s",__func__);
    _instance = [[YCPeople alloc]init];
}

//2.创建的对象，只有一个
+ (instancetype)sharePeople{
    return _instance;
}

//3.只要调用alloc，程序就崩溃
+ (instancetype)alloc{
    if (_instance) {
        //程序就崩溃
        NSException *exc = [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"There can only be one YCPeople instance." userInfo:nil];
        [exc raise];
    }
    
    return [super alloc];
}

@end
