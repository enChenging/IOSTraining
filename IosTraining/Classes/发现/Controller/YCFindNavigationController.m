//
//  YCFindNavigationController.m
//  UI
//
//  Created by release on 2020/9/18.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCFindNavigationController.h"

@interface YCFindNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation YCFindNavigationController

+(void)initialize{
    //获取导航条标识
    NSArray *array = [NSArray arrayWithObjects:[self class], nil];
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:array];
    
    //设置导航条背景图片
    [bar setBackgroundImage:[UIImage resizableImageWithLocalImageName:@"NLArenaNavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    //设置Title字体大小
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    //Title字体大小
    dicM[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    //Title字体颜色
    dicM[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [bar setTitleTextAttributes: dicM];
    //设置导航条前景色
    [bar setTintColor:[UIColor whiteColor]];
    
    //获取到导航条按钮的标示
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:array];
    //修改返回按钮的位置
    [item setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100) forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
}



@end
