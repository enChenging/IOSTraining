//
//  YCUIApplicationController.m
//  UI
//
//  Created by release on 2020/8/11.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCUIApplicationController.h"

@interface YCUIApplicationController ()

@end

@implementation YCUIApplicationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 设置提醒图标
 */
- (IBAction)addBadge {
    UIApplication *app = [UIApplication sharedApplication];
    //注册用户通知
    UIUserNotificationSettings *notice = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [app registerUserNotificationSettings:notice];
    app.applicationIconBadgeNumber = 10;
}

/**
 设置网络状态
 */
- (IBAction)netStatus:(id)sender {
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
}

/**
 设置状态栏
 */
- (IBAction)setStatusBar {
    YCLog(@"设置状态栏");
    UIApplication *app = [UIApplication sharedApplication];
    app.statusBarStyle = UIStatusBarStyleDefault;
}

/**
 打开一个URL
 */
- (IBAction)openNetPage:(id)sender {
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    [app openURL:url];
}

/**
 打电话
 */
- (IBAction)call:(id)sender {
    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:[NSURL URLWithString:@"tel://10086"]];
}

/**
 发短信
 */
- (IBAction)sendMessage:(id)sender {
    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:[NSURL URLWithString:@"sms://10086"]];
}


/**
 发邮件
 */
- (IBAction)sendMail:(id)sender {
    NSURL *url = [NSURL URLWithString:@"mailto:frank@wwdcdemo.example.com"];
    if ([[UIApplication sharedApplication]canOpenURL:url]) {
        [[UIApplication sharedApplication]openURL:url];
    }
}

//状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//是否隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return NO;
}


@end
