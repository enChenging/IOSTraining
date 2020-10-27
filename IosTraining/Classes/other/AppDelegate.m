//
//  AppDelegate.m
//  UI
//
//  Created by release on 2019/11/7.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"
#import "YCRootVC.h"

/**
 1.如果有Main，它会加载Main.storyBoard
 2.创建一个窗口
 3.把Main.storyBoard箭头指向的控制器，设为窗口的根控制器
 4.显示窗口（把窗口的根控制器的View,添加到窗口）
 */
@interface AppDelegate()


@end

@implementation AppDelegate

/**
 应用程序启动完毕
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    YCLog(@"%s",__func__);
    //1.创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    //2.1一个窗口必须得有根控制器（设置窗口的根控制器）
//    TabBarController* tbc = [[TabBarController alloc]init];
    //如果一个控件是透明的，那么它是不能够接收事件的
//    tbc.view.alpha = 0;
    //开始创建的控制器的颜色是透明的(默认)
//    tbc.view.backgroundColor = [UIColor clearColor];
    
    self.window.rootViewController = [YCRootVC chooseWindowRootVC];    
     //2.2通过StroyBoard加载控制器
//     UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //2.2.1加载storyBoard箭头指向的控制器
//    UIViewController *vc = [storyBoard instantiateInitialViewController];
//    self.window.rootViewController = vc;
    //2.2.2加载制定的控制器
//    UIViewController *vc2 = [storyBoard instantiateViewControllerWithIdentifier:@"vc"];
//    self.window.rootViewController = vc2;
    //2.3通过xib加载控制器
    /**
     initWithNibName:如果指定了特定的名称的xib，会去加载指定的xib。
     如果指定的是nil，判断有没有当前控制器相同民称的控制器。
     如果没有跟它相同名称的xib,自动加载跟它相同名称并且是去掉Controller的xib。
     init底层会自动调用initWithNibName。
     */
//    TabBarController* tbc2 = [[TabBarController alloc]initWithNibName:@"TabBar" bundle:nil];
//    self.window.rootViewController = tbc2;

    //3.显示
    /*
     makeKeyAndVisible:
     1.设置应用程序的主窗口
     2.让窗口显示，把窗口的hidden = no
     3.把窗口的根控制器的view添加到窗口上
     [self.window addsubView:rootViewController.view]
     注意：从ios9之后，如果添加了多个窗口，控制器它会自动把状态栏给隐藏掉。
     解决办法，把状态栏给应用程序管理
     */
    [self.window makeKeyAndVisible];
    
    /*
    //键盘，状态栏其实都是window
     UITextField *textF = [[UITextField alloc]init];
     [textF becomeFirstResponder];
     //UITextField想要显示键盘，必须要添加到一个View上
     [tbc.view addSubview:textF];
     
     //设置窗口层级
     //UIWindowLevelAlert > UIWindowLevelStatusBar > UIWindowLevelNormal
     self.window.windowLevel = UIWindowLevelStatusBar;
    **/
    
    /**
     在info.plist文件中 View controller-based status bar appearance-> YES，
     则控制器对状态栏设置的优先级高于application， 此时 prefersStatusBarHidden方法会起作用
     View controller-based status bar appearance->NO， 则以application为准，控制器设置状态栏prefersStatusBarHidden是无效的的根本不会被调用
     */
    UIApplication *app = [UIApplication sharedApplication];
    app.statusBarHidden = NO;
    app.statusBarStyle = UIStatusBarStyleLightContent;
    return YES;
}

/**
 应用程序获取焦点
 */
- (void)applicationDidBecomeActive:(UIApplication *)application{
//    YCLog(@"%s",__func__);
}

/**
 应用程序将要失去焦点
 */
-(void)applicationWillResignActive:(UIApplication *)application{
    YCLog(@"%s",__func__);
}

/**
 应用程序进入后台
 */
- (void)applicationDidEnterBackground:(UIApplication *)application{
    YCLog(@"%s",__func__);
}

/**
 应用程序进入到前台
 */
- (void)applicationWillEnterForeground:(UIApplication *)application{
    YCLog(@"%s",__func__);
}

/**
 应用程序退出
 */
- (void)applicationWillTerminate:(UIApplication *)application{
    YCLog(@"%s",__func__);
}

/**
 当收到内存警告
 */
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    //清理缓存，图片，视频
    YCLog(@"%s",__func__);
}

//- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
//    YCLog(@"将要开始");
//}
//
//- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed{
//    YCLog(@"将要结束");
//}
//
//- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed{
//    YCLog(@"已经结束");
//}
//
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    YCLog(@"选中控制器");
//    switch (tabBarController.tabBarItem.tag) {
//        case 101:{
//
//        }
//            break;
//
//        default:
//            break;
//    }
//}

@end
