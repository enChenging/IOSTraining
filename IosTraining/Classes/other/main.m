//
//  main.m
//  UI
//
//  Created by release on 2019/11/7.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

/**
 应用程序启动
 1.执行main函数
 2.执行UIApplicationMain，创建UIApplication对象，并设置UIApplication它的代理
 3.开启了一个事件循环（主运行循环，死循环:保证应用程序不退出）
 4.去加载info.plist文件（判断info.plist当中有没有Main,如果有，加载Main.storyBoard）
 5.应用程序启动完毕（通知代理应用程序启动完毕）
 */
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    
    //第三个参数：设置是应用程序对象的名称UIApplication或者是它的子类。如果是nil，默认是UIApplication
    //第四个参数：设置UIApplication代理的名称
     return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
