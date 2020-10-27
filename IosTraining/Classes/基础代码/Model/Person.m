//
//  Person.m
//  IosTraining
//
//  Created by release on 2020/10/15.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>

@implementation Person


//+ (instancetype)person{
//    return [[self alloc]init];
//}

+ (__kindof Person *)person{
    return [[self alloc]init];
}

- (void)eat
{
    NSLog(@"吃");
}
- (void)run:(NSInteger)metre
{
    NSLog(@"跑了%ld",metre);
}

//_cmd:当前方法的方法编号
// 没有返回值,也没有参数
// void,(id,SEL)
void aaa(id self, SEL _cmd, NSNumber *meter) {
    
    NSLog(@"跑了%@", meter);
    
}

// 任何方法默认都有两个隐式参数,self,_cmd
// 什么时候调用:只要一个对象调用了一个未实现的方法就会调用这个方法,进行处理
// 作用:动态添加方法,处理未实现
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    // [NSStringFromSelector(sel) isEqualToString:@"eat"];
    if (sel == NSSelectorFromString(@"goRun:")) {

        // class: 给哪个类添加方法
        // SEL: 添加哪个方法
        // IMP: 方法实现 => 函数 => 函数入口 => 函数名
        // type: 方法类型
        class_addMethod(self, sel, (IMP)aaa, "v@:@");
        
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];

}

@end
