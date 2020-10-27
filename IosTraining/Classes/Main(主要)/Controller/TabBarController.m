//
//  TabBarController.m
//  UI
//
//  Created by release on 2019/11/21.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "TabBarController.h"
#import "HomeViewController.h"
#import "UseViewController.h"
#import "DemosViewController.h"
#import "NavigationController.h"
#import "YCTabBar.h"
#import "YCMineVC.h"
#import "YCFindVC.h"
#import "YCFindNavigationController.h"

@interface TabBarController ()<YCTabBarDelegate>

@property(nonatomic, strong) NSMutableArray *itemArray;

@end

@implementation TabBarController

/**
 作用：用来创建控制器的View
 当控制器的View第一次使用时调用
 loadView底层原理：
 1.先判断当前控制器是不是从storyBoard当中加载的，如果是从storyBoard加载的控制器，
 那么它就会从storyBoard当中加载的控制器的View，设置为当前控制器的view.
 2.当前控制器是不是从xib中加载的，如果是从xib当中加载的话，把xib当中制定的view，
 设置为当前控制器的view
 3.如果也不是从xib中加载的，它就会创建空白的view
 
 一旦重写了loadView方法，就说明要自己定义view
 一般使用场景：当控制器的view一显示时，就是一张图片或者UIWebView。
 节省内存
 */
//- (void)loadView{
//    //如果一个控件不能j够接收事件，那么它里面子控件是不能够接收事件的
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide_1"]];
//    imageView.userInteractionEnabled = YES;//这样就可以接收事件了
//    self.view = imageView;
//}

//-(UIView *)view{
//    if (_view == nil) {
//        [self loadView];
//        [self viewDidLoad];
//    }
//    return _view;
//}

-(NSMutableArray *)itemArray{
    
    if (_itemArray == nil) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //移除系统的tabbar的子控件 UITabBarButton
    //UITabBarButton是私有属性
    for (UIView *view in self.tabBar.subviews) {
//        YCLog(@"=== %@",view);
        if (![view isKindOfClass:[YCTabBar class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //添加自控制器
    [self setUpAllChildViewController];
    //自定义tabBar
    [self setUpTabBar];
}

-(void)setUpTabBar{
//    [self.tabBar setTintColor:[UIColor brownColor]];
    
    //1.移除系统的tabBar
//    [self.tabBar removeFromSuperview];
    //2.添加自己的tabBar
    YCTabBar *tabBar = [[YCTabBar alloc]init];
    tabBar.frame = self.tabBar.bounds;
    tabBar.backgroundColor = [UIColor redColor];
    tabBar.itemArray = self.itemArray;
    tabBar.delegate = self;
    [self.tabBar addSubview:tabBar];
}

- (void)tabBar:(YCTabBar *)tabBar didSelectBtn:(NSInteger)selectIndex{
    self.selectedIndex = selectIndex;
}

-(void)setUpAllChildViewController{
    HomeViewController *homeVc = [[HomeViewController alloc]init];
    [self addChildViewController:homeVc WithTitle:@"基础控件" image:@"TabBar_LotteryHall_new" SelectImage:@"TabBar_LotteryHall_selected_new"];
    UseViewController *site = [[UseViewController alloc]init];
    [self addChildViewController:site WithTitle:@"基础代码" image:@"TabBar_Arena_new" SelectImage:@"TabBar_Arena_selected_new"];
    DemosViewController *demo = [[DemosViewController alloc]init];
    [self addChildViewController:demo WithTitle:@"基础demo" image:@"TabBar_History_new" SelectImage:@"TabBar_History_selected_new"];
//    YCFindVC *find = [[YCFindVC alloc]init];
    UIStoryboard *stroyBoard = [UIStoryboard storyboardWithName:NSStringFromClass(YCFindVC.class) bundle:nil];
    YCFindVC *find = [stroyBoard instantiateInitialViewController];//初始化箭头指向的控制器
    [self addChildViewController:find WithTitle:@"发现" image:@"TabBar_Discovery_new" SelectImage:@"TabBar_Discovery_selected_new"];
    YCMineVC *mine = [[YCMineVC alloc]init];
    [self addChildViewController:mine WithTitle:@"我的" image:@"TabBar_MyLottery_new" SelectImage:@"TabBar_MyLottery_selected_new"];
}

/*
 
 在这里由于我们设置的图片尺寸大小为64*49
 在TabBar当中设置的图片大小, 不能够超过40.所以导致图片无法显示出来.
 这个时候发现系统的TabBar无法满足我们的要求了.所以我们要自定义TabBar.
 
*/
-(void)addChildViewController:(UIViewController *)vc WithTitle:(NSString *)title image:(NSString *)imageName SelectImage:(NSString *)selectImage {
    vc.tabBarItem.image = [UIImage imageOriRenderingImageName:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageOriRenderingImageName:selectImage];
    vc.tabBarItem.title = title;
    [self.itemArray addObject:vc.tabBarItem];
    
    //initWithRootViewController底层调用pushViewController
    UINavigationController *nav = [[NavigationController alloc]initWithRootViewController:vc];
    
    if ([vc isKindOfClass:[YCFindVC class]]) {
        nav = [[YCFindNavigationController alloc]initWithRootViewController:vc];
    }
    
    [self addChildViewController:nav];
    
    //导航控制器上的内容有栈顶控制器navigationItem
    vc.navigationItem.title = title;
}


@end
