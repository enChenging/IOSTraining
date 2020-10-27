//
//  YCOperation.m
//  UI
//
//  Created by release on 2020/9/26.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCOperation.h"

@implementation YCOperation

//告知要执行的任务是什么
//1.有利于代码隐蔽
//2.服用行
- (void)main{
    
    for (NSInteger i = 0; i<10000; i++) {
        YCLog(@"download1------%zd---%@",i,[NSThread currentThread]);
    }
    //苹果官方的建议：每执行完一小段耗时操作的时候判断当前操作时候被取消
    if (self.isCancelled)return;
    
    YCLog(@"++++++++++++++++++++++++++++");
    
    for (NSInteger i = 0; i<10000; i++) {
        YCLog(@"download2------%zd---%@",i,[NSThread currentThread]);
    }
    
    for (NSInteger i = 0; i<10000; i++) {
        YCLog(@"download3------%zd---%@",i,[NSThread currentThread]);
    }
}
@end
