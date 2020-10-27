//
//  YCCoverView.m
//  UI
//
//  Created by release on 2020/9/17.
//  Copyright © 2020 Mr. release. All rights reserved.
//
#define YCKeyWindow [UIApplication sharedApplication].keyWindow
#import "YCCoverView.h"

@implementation YCCoverView

+ (void)show{
    //1.创建蒙版
    YCCoverView *cover = [[self alloc]init];
    //2.添加蒙版
    //显示到最外面的东西，我们一般都是添加到主窗口上面
    [YCKeyWindow addSubview:cover];
    //3.设置尺寸
    cover.frame = [UIScreen mainScreen].bounds;
    cover.backgroundColor  = [UIColor blackColor];
//    cover.alpha = 0.7;
    cover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f];
   
    //父控件透明子控件也透明
    //4.添加popMenu
//    UIView *popMinue = [[UIView alloc] init];
//    popMinue.backgroundColor = [UIColor greenColor];
//    popMinue.frame = CGRectMake(50, 50, 100, 100);
//    [cover addSubview:popMinue];
    
}

+ (void)hide{
    //隐藏蒙版
    for (UIView *view in YCKeyWindow.subviews) {
        if ([view isKindOfClass:[YCCoverView class]]) {
            //当前类
            [view removeFromSuperview];
            break;
        }
    }
}
@end
