//
//  ViewController.m
//  UI
//
//  Created by release on 2019/11/7.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "HomeViewController.h"
#import "UIViewTableViewCell.h"
#import "UILableViewController.h"
#import "UIButtonViewController.h"
#import "UIViewViewController.h"
#import "TimerViewController.h"
#import "UISwitchViewController.h"
#import "UISlide_ProgressViewController.h"
#import "UIStepper_UISegmentedControlViewController.h"
#import "UIAlertViewController.h"
#import "UITextFieldViewController.h"
#import "UIScrollViewViewController.h"
#import "UITouchViewController.h"
#import "UIGestureViewController.h"
#import "ManualLayoutViewController.h"
#import "AutoLayoutViewController.h"
#import "UiPickerViewController.h"
#import "VCUICollectionView.h"
#import "WebViewController.h"
#import "UIImageViewController.h"
#import "YCUITableViewController.h"
#import "YCCellCodeController.h"
#import "YCCellXibController.h"
#import "YCCellStoryBoardController.h"
#import "YCCellFrameController.h"
#import "YCFreeCellFrameController.h"
#import "YCFreeCellStoryBoardController.h"
#import "YCTableViewEditController.h"
#import "YCCustomDeleteController.h"
#import "YCShoppingCartController.h"
#import "YCPeople.h"
#import "YCCollectVC.h"
#import "YCCALayerVC.h"
#import "YCCABasicAnimationVC.h"
#import "YCCoverView.h"
#import "YCPopMenuView.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,YCPopMenuDelegate>

@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSArray* ceshiArray;


@end

@implementation HomeViewController

/**
 懒加载
 过程：
 1.重写成员变量的get方法
 2.在get方法中判断
 1.如果为空，加载数据
 2.如果不为空，就返回数据
 */
- (NSArray *)ceshiArray{
    if (_ceshiArray == nil) {
        NSString *dataPath = [[NSBundle mainBundle]pathForResource:@"homeUI.plist" ofType:nil];
        self.ceshiArray = [NSArray arrayWithContentsOfFile:dataPath];
    }
    return _ceshiArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    YCLog(@"HomeViewController---viewDidLoad-- %@",NSStringFromCGRect(self.view.frame));
    self.view.backgroundColor=[UIColor grayColor];
    //    NSArray *ceshiArray = @[@"UILabel",@"UIButton",@"UIImageView",@"UIView",@"TimerView",@"UISwitch",@"UISlide_ProgressView",@"UIStepper_UISegmentedControl",@"UIAlert",@"UITextField",@"UIScrollView",@"UITouch",@"UIGesture",@"ManualLayout",@"AutoLayout",@"UiPickerView",@"UICollectionView",@"WebView"];
    //    BOOL flag = [ceshiArray writeToFile:@"/Users/releasemr./Desktop/homeUI.plist" atomically:YES];
    //    if (flag) {
    //        YCLog(@"写入成功");
    //    }
    
    [self initTitle];
    [self createTableView];
    
    //    YCPeople *peo = [YCPeople sharePeople];
    //    YCPeople *peo2 = [YCPeople sharePeople];
    //    YCLog(@"%p-----%p",peo,peo2);
}

-(void)initTitle{
    UIBarButtonItem* rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"收藏"
                                                                style:UIBarButtonItemStyleDone target:self action:@selector(pressRight)];
    
    UIImage *image = [UIImage imageNamed:@"heart3"];
    UIImage *oriImage =  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBtn2 = [[UIBarButtonItem alloc]initWithImage:oriImage style:0 target:self action:@selector(heartClick:)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"heart2"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"heart3"] forState:UIControlStateHighlighted];
    //让按钮自适应大小
    //    [btn sizeToFit];
    
    NSArray* arryTopBtn = [NSArray arrayWithObjects:rightBtn, rightBtn2,nil];
    self.navigationItem.rightBarButtonItems = arryTopBtn;
    
    UIImage *legImage = [UIImage imageOriRenderingImageName:@"CS50_activity_image"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:legImage style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonOnClick)];;
    
    self.tabBarItem.badgeValue = @"100";//设置角标数量
    
}

-(void)leftButtonOnClick{
    //1.弹出蒙版，占据整个屏幕，不允许与用户交互
    [YCCoverView show];
    //2.popMenu
    YCPopMenuView *popMenu = [YCPopMenuView showInPoint:self.view.center];
    popMenu.delegate = self;
}

#pragma mark - YCPopMenuDelegate
-(void)popMenuDidCloseBtn:(YCPopMenuView *)popMenu{
    
    void(^completion)(void) = ^(){
        [YCCoverView hide];
    };
    [popMenu hideInCenter:CGPointMake(44, 44) completion:completion];
    //    [popMenu hideInCenter:CGPointMake(44, 44) completion:^{
    //        [YCCoverView hide];
    //    }];
}


-(void)pressRight{
    YCLog(@"收藏");
    
    YCCollectVC *cvc = [[YCCollectVC alloc]init];
    /**
     当在modal时，会把窗口上面的view给移除，然后要modal控制器的view，给添加到窗口上
     如果当一个控制器被销毁，那么它view的业务逻辑是没有办法处理
     控制器被销毁，控制器的view不一定被销毁（只要有强指针指向它，就不会被销毁）
     应用场景：
     - 收集用户输入信息
     - 临时呈现一些内容
     - 临时改变工作模式
     - 相应设备方向变化（用于针对不同方向分别是想两个ViewController的情况）
     - 显示一个新的view层级
     */
    [self presentViewController:cvc animated:YES completion:^{
        NSLog(@"%@",[UIApplication sharedApplication].keyWindow.rootViewController);
        NSLog(@"%@",self.presentedViewController);
    }];
    
}

-(void)heartClick:(UIBarButtonItem *)bi{
    YCLog(@"星星");
}


-(void)createTableView{
    // 状态栏(statusbar)
    //    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    //    YCLog(@"status width - %f", rectStatus.size.width); // 宽度
    //    YCLog(@"status height - %f", rectStatus.size.height);  // 高度
    
    // 导航栏（navigationbar）
    //    CGRect rectNav = self.navigationController.navigationBar.frame;
    //    YCLog(@"nav width - %f", rectNav.size.width); // 宽度
    //    YCLog(@"nav height - %f", rectNav.size.height);  // 高度
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);//分割线
    //    _tableView.separatorInset = UIEdgeInsetsZero;
    //    _tableView.separatorColor = [UIColor blueColor];
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    _tableView.backgroundColor = [UIColor clearColor];
    
    _tableView.scrollEnabled = YES;//石否可以有滚动效果
    _tableView.bounces = YES;//是否可以边缘弹动效果
    _tableView.alwaysBounceVertical = YES;
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 120)];
    [self.view addSubview:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ceshiArray.count;
}

////设置数据视图的组数
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 2;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* indentify = @"cellr4rfrklfkre";
    UIViewTableViewCell* cell=[_tableView dequeueReusableCellWithIdentifier:indentify];
    
    if (!cell) {
        cell = [[UIViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify];
    }
    
    cell.nameLable.text = self.ceshiArray[indexPath.row];
    cell.FistImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"heart%d",(int)indexPath.row%11]];
    
    return cell;
}

typedef void (^CaseBlock)(void);

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *title =  self.ceshiArray[indexPath.row];
    NSDictionary *dict = @{
        @"UILabel":^(){
            [self pushVC:[[UILableViewController alloc]init] withTitile:title];
        },
        @"UIButton":^(){
            [self pushVC:[[UIButtonViewController alloc]init] withTitile:title];
        },
        @"UIImageView":^(){
            [self pushVC:[[UIImageViewController alloc]init] withTitile:title];
        },
        @"UIView":^(){
            [self pushVC:[[UIViewViewController alloc]init] withTitile:title];
        },
        @"TimerView":^(){
            [self pushVC:[[TimerViewController alloc]init] withTitile:title];
        },
        @"UISwitch":^(){
            [self pushVC:[[UISwitchViewController alloc]init] withTitile:title];
        },
        @"UISlide_ProgressView":^(){
            [self pushVC:[[UISlide_ProgressViewController alloc]init] withTitile:title];
        },
        @"UIStepper_UISegmentedControl":^(){
            [self pushVC:[[UIStepper_UISegmentedControlViewController alloc]init] withTitile:title];
        },
        @"UIAlert":^(){
            [self pushVC:[[UIAlertViewController alloc]init] withTitile:title];
        },
        @"UITextField":^(){
            [self pushVC:[[UITextFieldViewController alloc]init] withTitile:title];
        },
        @"UIScrollView":^(){
            [self pushVC:[[UIScrollViewViewController alloc]init] withTitile:title];
        },
        @"UITouch":^(){
            [self pushVC:[[UITouchViewController alloc]init] withTitile:title];
        },
        @"UIGesture":^(){
            [self pushVC:[[UIGestureViewController alloc]init] withTitile:title];
        },
        @"ManualLayout":^(){
            [self pushVC:[[ManualLayoutViewController alloc]init] withTitile:title];
        },
        @"AutoLayout":^(){
            [self pushVC:[[AutoLayoutViewController alloc]init] withTitile:title];
        },
        @"UiPickerView":^(){
            [self pushVC:[[UiPickerViewController alloc]init] withTitile:title];
        },
        @"UICollectionView":^(){
            [self pushVC:[[VCUICollectionView alloc]init] withTitile:title];
        },
        @"WebView":^(){
            [self pushVC:[[WebViewController alloc]init] withTitile:title];
        },
        @"UITableView基本使用":^(){
            [self pushVC:[[YCUITableViewController alloc]init] withTitile:title];
        },
        @"自定义等高cell -frame":^(){
            [self pushVC:[[YCCellFrameController alloc]init] withTitile:title];
        },
        @"自定义等高cell-autolayout":^(){
            [self pushVC:[[YCCellCodeController alloc]init] withTitile:title];
        },
        @"自定义不同类型等高cell-xib":^(){
            [self pushVC:[[YCCellXibController alloc]init] withTitile:title];
        },
        @"自定义等高cell-storyboard":^(){
            [self pushStorybVC:@"YCCellsb" withTitle:title];
        },
        @"自定义不等高cell-frame":^(){
            [self pushVC:[[YCFreeCellFrameController alloc]init] withTitile:title];
        },
        @"自定义不等高cell-storyboard":^(){
            [self pushStorybVC:@"YCCellFree" withTitle:title];
        },
        @"数据的增删改查":^(){
            [self pushVC:[[YCTableViewEditController alloc]init] withTitile:title];
        },
        @"自定义批量删除":^(){
            [self pushVC:[[YCCustomDeleteController alloc]init] withTitile:title];
        },
        @"购物车":^(){
            [self pushVC:[[YCShoppingCartController alloc]init] withTitile:title];
        },
        @"CALayer":^(){
            [self pushVC:[[YCCALayerVC alloc]initWithNibName:NSStringFromClass(YCCALayerVC.class) bundle:nil] withTitile:title];
        },
        @"CABasicAnimation":^(){
            [self pushVC:[[YCCABasicAnimationVC alloc]initWithNibName:NSStringFromClass(YCCABasicAnimationVC.class) bundle:nil] withTitile:title];
        }
    };
    
    CaseBlock c = (CaseBlock)dict[title];
    if (c) {
        c();
    }
    
}

/**
 [self presentViewController:lableControl animated:YES completion:nil];//没有导航控制器的跳转
 [self.navigationController popToRootViewControllerAnimated:YES];//返回根视图
 [self.navigationController popViewControllerAnimated:YES];//返回上级视图
 */
-(void)pushVC:(UIViewController *)vc withTitile:(NSString *)title {
    vc.title = title;
    vc.modalPresentationStyle=UIModalPresentationFullScreen;
    [self.navigationController pushViewController:vc animated:NO];
}

-(void)pushStorybVC:(NSString *)name withTitle:(NSString *)title{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:name bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    vc.title = title;
    [self.navigationController pushViewController:vc animated:NO];
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    YCLog(@"viewWillAppear  视图即将显示");
//    self.tabBarController.tabBar.hidden = NO;
//}
//
//- (void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
//    YCLog(@"viewWillLayoutSubviews  控制器的view将要布局子控件");
//}
//
//- (void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//    YCLog(@"viewWillLayoutSubviews  控制器的view布局子控件完毕");
//}
//
//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    YCLog(@"viewDidAppear  视图已经显示");
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    YCLog(@"viewWillDisappear  视图即将消失");
//}
//
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    YCLog(@"viewDidDisappear  视图已经消失");
//}
//
//- (void)didReceiveMemoryWarning{
//    [super didReceiveMemoryWarning];
//    YCLog(@"内存过低警告接受函数");
//}

//- (void)dealloc{
//    [super dealloc];
//    YCLog(@"控制器销毁");
//}

- (void)viewDidAppear:(BOOL)animated{
    YCLog(@"HomeViewController---viewDidAppear-- %@",NSStringFromCGRect(self.view.frame));
}

@end
