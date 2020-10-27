//
//  YCRootVC.m
//  UI
//
//  Created by release on 2020/9/19.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCRootVC.h"
#import "AppDelegate.h"
#import "TabBarController.h"
#import "YCGuideVC.h"

#define Version @"version"
@implementation YCRootVC

+ (UIViewController *)chooseWindowRootVC{
    //1.获取版本更新
       NSString *currVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
       //2.上一次版本号
       NSString *lastVersion = [YCSaveTool objectForKey:Version];
       
       UIViewController *rootVc;
       rootVc = [[YCGuideVC alloc]init];
       if (![currVersion isEqualToString:lastVersion]) {
           //进入引导界面
           rootVc = [[YCGuideVC alloc]init];
           //存储当前版本号
           [YCSaveTool setObject:currVersion forKey:Version];
       }else{
           //进入主进程
           rootVc = [[TabBarController alloc]init];
       }
    
    return rootVc;
}

@end
