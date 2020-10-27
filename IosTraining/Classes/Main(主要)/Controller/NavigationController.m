//
//  NavigationController.m
//  UI
//
//  Created by release on 2019/11/21.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "NavigationController.h"
#import <objc/runtime.h>

@interface NavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation NavigationController

/**
 当程序一启动时候就会调用
 作用：当前类加载进内存，放在代码区
 */
//+ (void)load{
//
//}
/**
 1.initialize 当第一次初始化这个类的时候调用，如果当这个类有子类会调用多次
 2.我们应该只是初始化一些 固定的值
 */
+ (void)initialize
{
    if (self == [super class]) {
        YCLog(@"Navigation -- initialize ==== ");
        
        //获取APP的导航条标识
        //appearance 是一个协议，只要遵守了这个协议都有这个方法
        //所有的都一样
//        UINavigationBar *bar = [UINavigationBar appearance];
        
        //只有属于数组中的类才生效,并进行设置
        NSArray *array = [NSArray arrayWithObjects:[self class], nil];
        UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:array];
        
        //设置Title字体大小
        NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
        //Title字体大小
        dicM[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
        //Title字体颜色
        dicM[NSForegroundColorAttributeName] = [UIColor whiteColor];
        [bar setTitleTextAttributes: dicM];
        //设置导航条前景色
        [bar setTintColor:[UIColor whiteColor]];
        
        //UIBarMetricsDefault {414, 672}
        //UIBarMetricsCompact {414, 736}
        //setBarTintColor  {414, 736}
        //[self.navigationBar setBarTintColor:[UIColor redColor]];
        //只要给导航设置背景图片只能用默认模式，但是控制器的view的尺寸是从64开始，高度 = 屏幕的高度 - 64
        [bar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //系统自带屏幕边缘滑动移除控制器，现在要实现全屏移除控制器
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;

}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    [self addbackBtn:viewController];
}

-(void)addbackBtn:(UIViewController *)viewController{
    //当非根控制器设置导航条左侧返回按钮，（设置之后导致控制器无法滑动返回）
    if (self.viewControllers.count != 1) {
        UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick)];
        viewController.navigationItem.leftBarButtonItems = @[back];
    }
}

-(void)backBtnClick{
    [self popViewControllerAnimated:YES];
}


@end
